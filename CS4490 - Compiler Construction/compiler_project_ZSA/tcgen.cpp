#include "tcgen.h"
#include <cstddef>

TCGenerator::TCGenerator(ST* symbolTable, ICGenerator* quads, std::string kxiFileName) : st(symbolTable), icgen(quads)
{
	assemblyFileName = kxiFileName.substr(0, kxiFileName.find_last_of(".")) + ".asm";
	freeCounter = 0;

	ofs = new std::ofstream(assemblyFileName, std::ofstream::out | std::ofstream::trunc);
	//run it.

	//Step 1: Write Out Static Data.
	// This needs an update to SymbolTable to Extract symids of the current(global) scope, check their type, and write out .BYtE or .INT for that type.
	writeStaticData();

	//Step 2: Write Out Assembly Statements from ICode Quads.
		//Requires us to write a getLocation Function to see where the data is. We must trach this data from when we're loading and storing the data.
			//Keep track of this data in a std::vector in each struct of temp datas in Symbol Table.
		//We'll have a "Big Switch" like our VM for each individual statements and will perform actions in reading the data into specific registers.
	writeAssemblyStatements();

	//Step 3: Take the vectors for static data and assembly statements, process the free start position, and then write this information out to file.
	writeFile();
}

void TCGenerator::writeStaticData()
{
	std::vector<std::string> scopeIDs = st->extractScope("g");

	for (auto it = scopeIDs.begin(); it != scopeIDs.end(); ++it)
	{
		if(st->symbolTable[*it]->getType() == "char" || st->symbolTable[*it]->getType() == "bool")
		{
			std::string charLiteral = st->symbolTable[*it]->getValue();
			std::string printer = charLiteral;

			if (charLiteral == "'\\n'")
				printer = "A";
			else if (charLiteral == "'\\t'")
				printer = "9";
			else if (charLiteral == "' '")
				printer = "20";
			else if (charLiteral == "true")
				printer = "0";
			else if (charLiteral == "false")
				printer = "1";
			else if (charLiteral == "null")
				printer = "0";

			staticDataStatements.push_back(new staticDataItem(st->symbolTable[*it]->getSymID(), ".BYT", printer));
			freeCounter++;
		}

		else if(st->symbolTable[*it]->getType() == "int" || st->symbolTable[*it]->getType() == "ref")
		{
			std::string charLiteral = st->symbolTable[*it]->getValue();
			std::string printer = charLiteral;

			if (charLiteral == "null")
				printer = "0";

			staticDataStatements.push_back(new staticDataItem(st->symbolTable[*it]->getSymID(), ".INT", printer));
			freeCounter += 4;
		}
	}
	writeStaticOverflow();
	writeStaticUnderflow();

	staticDataStatements.push_back(new staticDataItem("FREE", ".INT", "0"));
	freeCounter += 4;
}

void TCGenerator::writeStaticOverflow()
{
	staticDataStatements.push_back(new staticDataItem("O", ".BYT", "'O'"));
	freeCounter += 1;
	staticDataStatements.push_back(new staticDataItem("v", ".BYT", "'v'"));
	freeCounter += 1;
	staticDataStatements.push_back(new staticDataItem("e", ".BYT", "'e'"));
	freeCounter += 1;
	staticDataStatements.push_back(new staticDataItem("r", ".BYT", "'r'"));
	freeCounter += 1;
	staticDataStatements.push_back(new staticDataItem("f", ".BYT", "'f'"));
	freeCounter += 1;
	staticDataStatements.push_back(new staticDataItem("l", ".BYT", "'l'"));
	freeCounter += 1;
	staticDataStatements.push_back(new staticDataItem("o", ".BYT", "'o'"));
	freeCounter += 1;
	staticDataStatements.push_back(new staticDataItem("w", ".BYT", "'w'"));
	freeCounter += 1;
}

void TCGenerator::writeStaticUnderflow()
{
	staticDataStatements.push_back(new staticDataItem("U", ".BYT", "'U'"));
	freeCounter += 1;
	staticDataStatements.push_back(new staticDataItem("n", ".BYT", "'n'"));
	freeCounter += 1;
	staticDataStatements.push_back(new staticDataItem("d", ".BYT", "'d'"));
	freeCounter += 1;
}

void TCGenerator::writeAssemblyStatements()
{
	writeInitialRegisters();
	for (size_t i = 0; i < icgen->quads.size(); ++i)
	{
		quadCounter = i;
		if (icgen->quads[i]->instruction == "FRAME")
		{
			writeFrame(icgen->quads[i]);
			i = quadCounter;
		}
		else if (icgen->quads[i]->instruction == "CALL")
		{
			writeCall(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "TRP0")
		{
			pushStatement(new assemblyStatement("", "TRP", "0", "", ""));
		}
		else if (icgen->quads[i]->instruction == "FUNC")
		{
			writeFunc(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "RTN")
		{
			writeRTN(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "RETURN")
		{
			writeReturn(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "PEEK")
		{
			writePeek(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "WRITE")
		{
			writeWrite(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "READ")
		{
			writeRead(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "MOV")
		{
			writeMov(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "ADD")
		{
			writeAdd(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "SUB")
		{
			writeSub(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "MUL")
		{
			writeMul(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "DIV")
		{
			writeDiv(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "EQ" || icgen->quads[i]->instruction == "LT" || icgen->quads[i]->instruction == "GT"
			|| icgen->quads[i]->instruction == "NE" || icgen->quads[i]->instruction == "LE" || icgen->quads[i]->instruction == "GE")
		{
			writeControlStatement(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "BF")
		{
			writeBranchFalse(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "JMP")
		{
			writeJump(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "AND")
		{
			writeLogicalAnd(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "OR")
		{
			writeLogicalOr(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "ItoA")
		{
			writeItoA(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "NEWI")
		{
			writeNewI(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "NEW")
		{
			writeNew(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "REF")
		{
			writeRef(icgen->quads[i]);
		}
		else if (icgen->quads[i]->instruction == "AEF")
		{
			writeAEF(icgen->quads[i]);
		}
	}

	writeAssemblyOverflow();
	writeAssemblyUnderflow();
}

void TCGenerator::writeInitialRegisters()
{
	//R7 holds 0 (true), R8 holds 1 (false).
	pushStatement(new assemblyStatement("", "LDR", "R7", "S2", "; Set R7 to hold 0 - TRUE"));
	pushStatement(new assemblyStatement("", "LDR", "R8", "S0", "; Set R8 to hold 1 - FALSE"));
}

void TCGenerator::writeAssemblyOverflow()
{
	pushStatement(new assemblyStatement("OVERFLOW", "LDB", "R0", "O", "; output something if overflow occurs."));
	pushStatement(new assemblyStatement("", "TRP", "3", "", ""));
	pushStatement(new assemblyStatement("", "LDB", "R0", "v", ""));
	pushStatement(new assemblyStatement("", "TRP", "3", "", ""));
	pushStatement(new assemblyStatement("", "LDB", "R0", "e", ""));
	pushStatement(new assemblyStatement("", "TRP", "3", "", ""));
	pushStatement(new assemblyStatement("", "LDB", "R0", "r", ""));
	pushStatement(new assemblyStatement("", "TRP", "3", "", ""));
	pushStatement(new assemblyStatement("", "LDB", "R0", "f", ""));
	pushStatement(new assemblyStatement("", "TRP", "3", "", ""));
	pushStatement(new assemblyStatement("", "LDB", "R0", "l", ""));
	pushStatement(new assemblyStatement("", "TRP", "3", "", ""));
	pushStatement(new assemblyStatement("", "LDB", "R0", "o", ""));
	pushStatement(new assemblyStatement("", "TRP", "3", "", ""));
	pushStatement(new assemblyStatement("", "LDB", "R0", "w", ""));
	pushStatement(new assemblyStatement("", "TRP", "3", "", ""));
	pushStatement(new assemblyStatement("", "TRP", "0", "", ""));
}

void TCGenerator::writeAssemblyUnderflow()
{
	pushStatement(new assemblyStatement("UNDERFLOW", "LDB", "R0", "U", "; output something if underflow occurs."));
	pushStatement(new assemblyStatement("", "TRP", "3", "", ""));
	pushStatement(new assemblyStatement("", "LDB", "R0", "n", ""));
	pushStatement(new assemblyStatement("", "TRP", "3", "", ""));
	pushStatement(new assemblyStatement("", "LDB", "R0", "d", ""));
	pushStatement(new assemblyStatement("", "TRP", "3", "", ""));
	pushStatement(new assemblyStatement("", "LDB", "R0", "e", ""));
	pushStatement(new assemblyStatement("", "TRP", "3", "", ""));
	pushStatement(new assemblyStatement("", "LDB", "R0", "r", ""));
	pushStatement(new assemblyStatement("", "TRP", "3", "", ""));
	pushStatement(new assemblyStatement("", "LDB", "R0", "f", ""));
	pushStatement(new assemblyStatement("", "TRP", "3", "", ""));
	pushStatement(new assemblyStatement("", "LDB", "R0", "l", ""));
	pushStatement(new assemblyStatement("", "TRP", "3", "", ""));
	pushStatement(new assemblyStatement("", "LDB", "R0", "o", ""));
	pushStatement(new assemblyStatement("", "TRP", "3", "", ""));
	pushStatement(new assemblyStatement("", "LDB", "R0", "w", ""));
	pushStatement(new assemblyStatement("", "TRP", "3", "", ""));
	pushStatement(new assemblyStatement("", "TRP", "0", "", ""));
}

void TCGenerator::pushStatement(assemblyStatement* newAsmStatement)
{
	freeCounter += 12;
	assemblyStatements.push_back(newAsmStatement);
}

void TCGenerator::writeFile()
{
	//Compute Free.
	freeCounter += 12;
	std::stringstream is;
	is << freeCounter;
	staticDataStatements.back()->value = is.str();

	for (auto it = staticDataStatements.begin(); it != staticDataStatements.end(); ++it)
	{
		*ofs << *it;
	}

	*ofs << std::endl << std::endl;

	for (auto it = assemblyStatements.begin(); it != assemblyStatements.end(); ++it)
	{
		*ofs << *it;
	}
}

std::vector<std::string> TCGenerator::getLocation(std::string symID)
{
	return st->symbolTable[symID]->getLocations();
}

std::string TCGenerator::getData(quad* quadStatement, bool writeLabel, std::string symid, std::string regToUse, std::string FPRegsiter)
{
	//sticks data into the register to use and returns that register name.

	std::vector<std::string> dataLocations = getLocation(symid);
	std::string spotOfDataName = "";
	std::string labelWriter = "";
	std::string commentWriter = "";
	if (writeLabel)
	{
		labelWriter = quadStatement->label;
		commentWriter = "; " + quadStatement->comment;
	}

	if (dataLocations.size() > 0)
	{
		if (dataLocations.back() == "global")
		{
			if (st->symbolTable[symid]->getType() == "char" || st->symbolTable[symid]->getType() == "bool")
				pushStatement(new assemblyStatement(labelWriter, "LDB", regToUse, symid, commentWriter));
			else pushStatement(new assemblyStatement(labelWriter, "LDR", regToUse, symid, commentWriter));
			spotOfDataName = regToUse;
		}
		else if (dataLocations.back().size() > 5 && dataLocations.back().substr(0, 5) == "stack")
		{
			pushStatement(new assemblyStatement(labelWriter, "MOV", regToUse, FPRegsiter, commentWriter));
			pushStatement(new assemblyStatement("", "ADI", regToUse, st->symbolTable[symid]->getSize(), ""));

			//next we check if the temporary is used a reference. We use the value inside the register at this point as an address to our data.
			std::string usedAsRef = st->symbolTable[symid]->getRefFlag();
			// if (usedAsRef == "Y")
			// {
			// 	pushStatement(new assemblyStatement("", "LDR", regToUse, regToUse, ""));
			// }

			//Finally, load the data of the specific type.

			if (st->symbolTable[symid]->getType() == "char" || st->symbolTable[symid]->getType() == "bool")
				pushStatement(new assemblyStatement("", "LDB", regToUse, regToUse, ""));
			else pushStatement(new assemblyStatement("", "LDR", regToUse, regToUse, ""));

			spotOfDataName = regToUse;
		}

		spotOfDataName = regToUse;
		
		// else //data accessed from heap.
		// {
		// 	//Needs to be accessed either through this pointer or through ref object.

		// 	std::string usedAsRef = st->symbolTable[symid]->getRefFlag();
		// 	//through this pointer. Meaning it wasn't used as a ref.
		// 	if (usedAsRef == "N" || usedAsRef == "")
		// 	{
		// 		//Local instance variables are always accessed from the “this” pointer
		// 		// which is on the stack + a displacement to the instance variable.


		// 		//Refactor this into passing the this register into the function.
		// 		std::string thisRegister = "R6";

		// 		//first get this into a register.

		// 		pushStatement(new assemblyStatement(labelWriter, "MOV", thisRegister, FPRegsiter, commentWriter));
		// 		pushStatement(new assemblyStatement("", "ADI", thisRegister, "-8", ""));
		// 		pushStatement(new assemblyStatement("", "LDR", thisRegister, thisRegister, ""));

		// 		//Next use this address with offset to get data Register address.
		// 		pushStatement(new assemblyStatement("", "MOV", regToUse, thisRegister, ""));
		// 		pushStatement(new assemblyStatement("", "ADI", regToUse, st->symbolTable[symid]->getSize(), ""));

		// 		//Finally check type of item and Load Data for it.
		// 		if (st->symbolTable[symid]->getType() == "char" || st->symbolTable[symid]->getType() == "bool")
		// 			pushStatement(new assemblyStatement("", "LDB", regToUse, regToUse, ""));
		// 		else pushStatement(new assemblyStatement("", "LDR", regToUse, regToUse, ""));
		// 		spotOfDataName = regToUse;
		// 	}
		// }
	}

	return spotOfDataName;
}

void TCGenerator::storeData(std::string symid, std::string dataReg, std::string addressReg, std::string thisRegister, bool storeAtAddress)
{
	//stores data into a symid using an address register with the dataRegister to store that data for symid.

	//storeData(quadStatement->op1, "R1", "R4", "R6", false);

	std::vector<std::string> dataLocations = getLocation(symid);
	if (dataLocations.size() > 0)
	{
		if (dataLocations.back() == "global")
		{
			if (st->symbolTable[symid]->getType() == "char" || st->symbolTable[symid]->getType() == "bool")
				pushStatement(new assemblyStatement("", "STB", dataReg, symid, ""));
			else pushStatement(new assemblyStatement("", "STR", dataReg, symid, ""));
		}
		else if (dataLocations.back().size() > 5 && dataLocations.back().substr(0, 5) == "stack")
		{
			pushStatement(new assemblyStatement("", "MOV", addressReg, "FP", ""));
			pushStatement(new assemblyStatement("", "ADI", addressReg, st->symbolTable[symid]->getSize(), ""));


			//next we check if the temporary is used a reference. We use the value inside the register at this point as an address to our data.
			std::string usedAsRef = st->symbolTable[symid]->getRefFlag();
			// if (usedAsRef == "Y" && storeAtAddress == false)
			// {
			// 	pushStatement(new assemblyStatement("", "LDR", addressReg, addressReg, ""));
			// }

			if ((st->symbolTable[symid]->getType() == "char" || st->symbolTable[symid]->getType() == "bool") && storeAtAddress == false)
				pushStatement(new assemblyStatement("", "STB", dataReg, addressReg, ""));
			else pushStatement(new assemblyStatement("", "STR", dataReg, addressReg, ""));
		}
		// else //data accessed from heap.
		// {
		// 	std::string usedAsRef = st->symbolTable[symid]->getRefFlag();
		// 	//through this pointer. Meaning it wasn't used as a ref.
		// 	if (usedAsRef == "N" || usedAsRef == "")
		// 	{
		// 		//first get this into a register.

		// 		pushStatement(new assemblyStatement("", "MOV", thisRegister, "FP", ""));
		// 		pushStatement(new assemblyStatement("", "ADI", thisRegister, "-8", ""));
		// 		pushStatement(new assemblyStatement("", "LDR", thisRegister, thisRegister, ""));

		// 		//Next use this address with offset to get data Register address.
		// 		pushStatement(new assemblyStatement("", "MOV", addressReg, thisRegister, ""));
		// 		pushStatement(new assemblyStatement("", "ADI", addressReg, st->symbolTable[symid]->getSize(), ""));

		// 		//Finally check type of item and Load Data for it.
		// 		if (st->symbolTable[symid]->getType() == "char" || st->symbolTable[symid]->getType() == "bool")
		// 			pushStatement(new assemblyStatement("", "STB", dataReg, addressReg, ""));
		// 		else pushStatement(new assemblyStatement("", "STR", dataReg, addressReg, ""));
		// 	}
		// }
	}
}

void TCGenerator::writeFrame(quad* quadStatement)
{
	pushStatement(new assemblyStatement(quadStatement->label, "MOV", "R1", "SP", "; " + quadStatement->comment + " " + quadStatement->op2));
	pushStatement(new assemblyStatement("", "ADI", "R1", st->symbolTable[st->getSymIDForLabel(quadStatement->op1)]->getSize(), "; Space for Function"));
	pushStatement(new assemblyStatement("", "CMP", "R1", "SL", "; Test Overflow"));
	pushStatement(new assemblyStatement("", "BLT", "R1", "OVERFLOW", ""));

	pushStatement(new assemblyStatement("", "MOV", "R9", "FP", "; Old Frame"));
	pushStatement(new assemblyStatement("", "MOV", "FP", "SP", "; New Frame"));
	pushStatement(new assemblyStatement("", "ADI", "SP", "-4", "; PFP"));
	pushStatement(new assemblyStatement("", "STR", "R9", "SP", "; Set PFP"));
	pushStatement(new assemblyStatement("", "ADI", "SP", "-4", ""));

	//Set this on Stack
		//Load into Register 2.
	if (quadStatement->op2 == "blank") //no loading for this necessory. Store junk here.
	{
		pushStatement(new assemblyStatement("", "STR", "R2", "SP", "; Set this on Stack"));
		pushStatement(new assemblyStatement("", "ADI", "SP", "-4", ""));
	}
	//for this we would use the old frame -8 to get the this pointer address. Then load itself with the this pointer
	// and set it on the stack.
	else if (quadStatement->op2 == "this")
	{
		pushStatement(new assemblyStatement("", "MOV", "R2", "R9", "; Old Frame to R2"));
		pushStatement(new assemblyStatement("", "ADI", "R2", "-8", "; address of this")); // address of this.
		pushStatement(new assemblyStatement("", "LDR", "R2", "R2", "; value of this")); // value of this.
		pushStatement(new assemblyStatement("", "STR", "R2", "SP", "; Set this on Stack"));
		pushStatement(new assemblyStatement("", "ADI", "SP", "-4", ""));
	}
	else
	{
		// not "blank" and not "this", need to get data from Old frame.
		std::string dataRegister = getData(quadStatement, false, quadStatement->op2, "R1", "R9"); //R9 holds prev frame.
		pushStatement(new assemblyStatement("", "STR", dataRegister, "SP", "; Set this on Stack"));
		pushStatement(new assemblyStatement("", "ADI", "SP", "-4", ""));
	}

	//while loop through quads for push instructions.

	int loopCounter = quadCounter + 1;
	while (icgen->quads[loopCounter]->instruction == "PUSH")
	{
		writePush(icgen->quads[loopCounter++]);
		quadCounter++;
	}
}

void TCGenerator::writePush(quad* quadStatement)
{
	//get data from op1.
	std::string dataRegister = getData(quadStatement, true, quadStatement->op1, "R1", "R9"); //R9 holds prev frame.

	//do -- store on SP address. Check if we're dealing with 4 bytes or 1 byte.
	std::string type = st->symbolTable[quadStatement->op1]->getType();
	if (type == "int" || type == "ref")
	{
		pushStatement(new assemblyStatement("", "ADI", "SP", "-3", "; Store 4 bytes."));
		pushStatement(new assemblyStatement("", "STR", dataRegister, "SP", ""));
		pushStatement(new assemblyStatement("", "ADI", "SP", "-1", ""));
	}
	else if (type == "bool" || type == "char")
	{
		pushStatement(new assemblyStatement("", "STB", dataRegister, "SP", "; Store 1 byte."));
		pushStatement(new assemblyStatement("", "ADI", "SP", "-1", ""));
	}
}

void TCGenerator::writeCall(quad* quadStatement)
{
	//CALL Frame Label.
	pushStatement(new assemblyStatement(quadStatement->label, "MOV", "R1", "PC", ""));
	pushStatement(new assemblyStatement("", "ADI", "R1", "48", "; Compute rtn addr")); //48 is for the statement after the JMP. 12 byte statements.
	pushStatement(new assemblyStatement("", "STR", "R1", "FP", "; Set rtn addr"));
	pushStatement(new assemblyStatement("", "JMP", quadStatement->op1, "", ""));
}

void TCGenerator::writeFunc(quad* quadStatement)
{
	pushStatement(new assemblyStatement(quadStatement->op1, "ADI", "SP", st->symbolTable[st->getSymIDForLabel(quadStatement->op1)]->getSize(), ""));
	pushStatement(new assemblyStatement("", "MOV", "R1", "SP", "; Test Overflow"));
	pushStatement(new assemblyStatement("", "CMP", "R1", "SL", ""));
	pushStatement(new assemblyStatement("", "BLT", "R1", "OVERFLOW", ""));
}

void TCGenerator::writeRTN(quad* quadStatement)
{
	pushStatement(new assemblyStatement(quadStatement->label, "MOV", "SP", "FP", "; Test for Underflow"));
	pushStatement(new assemblyStatement("", "MOV", "R1", "SP", ""));
	pushStatement(new assemblyStatement("", "CMP", "R1", "SB", ""));
	pushStatement(new assemblyStatement("", "BGT", "R1", "UNDERFLOW", ""));
	pushStatement(new assemblyStatement("", "LDR", "R1", "FP", "; rtn addr"));
	pushStatement(new assemblyStatement("", "MOV", "R2", "FP", ""));
	pushStatement(new assemblyStatement("", "ADI", "R2", "-4", ""));
	pushStatement(new assemblyStatement("", "LDR", "FP", "R2", "; PFP -> FP"));
	pushStatement(new assemblyStatement("", "JMR", "R1", "", "; goto rtn addr"));
}

void TCGenerator::writeReturn(quad* quadStatement)
{
	//get data
	std::string dataRegister = "";
	if (quadStatement->op1 != "this")
		dataRegister = getData(quadStatement, true, quadStatement->op1, "R1", "FP");
	else
	{
		pushStatement(new assemblyStatement(quadStatement->label, "MOV", "R1", "FP", quadStatement->comment));
		pushStatement(new assemblyStatement("", "ADI", "R1", "-8", ""));
		pushStatement(new assemblyStatement("", "LDR", "R1", "R1", "; this -> R1"));
		dataRegister = "R1";
	}

	pushStatement(new assemblyStatement(quadStatement->label, "MOV", "SP", "FP", "; Test for Underflow"));
	pushStatement(new assemblyStatement("", "MOV", "R2", "SP", ""));
	pushStatement(new assemblyStatement("", "CMP", "R2", "SB", ""));
	pushStatement(new assemblyStatement("", "BGT", "R2", "UNDERFLOW", ""));
	pushStatement(new assemblyStatement("", "LDR", "R2", "FP", "; rtn addr"));
	pushStatement(new assemblyStatement("", "MOV", "R3", "FP", ""));
	pushStatement(new assemblyStatement("", "ADI", "R3", "-4", ""));
	pushStatement(new assemblyStatement("", "LDR", "FP", "R3", "; PFP -> FP"));
	pushStatement(new assemblyStatement("", "STR", dataRegister, "SP", "; return " + quadStatement->op1));
	pushStatement(new assemblyStatement("", "JMR", "R2", "", "; goto rtn addr"));
}

void TCGenerator::writePeek(quad* quadStatement)
{
	//get data
	std::string type = st->symbolTable[quadStatement->op1]->getType();
	if (type == "char" || type == "bool")
		pushStatement(new assemblyStatement(quadStatement->label, "LDB", "R1", "SP", "; PEEK"));
	else pushStatement(new assemblyStatement(quadStatement->label, "LDR", "R1", "SP", "; PEEK"));

	//store into temporary
		//(std::string symid, std::string dataReg, std::string addressReg)
	storeData(quadStatement->op1, "R1", "R4", "R6", false);
}

void TCGenerator::writeWrite(quad* quadStatement)
{
	//get data
	std::string dataRegister = getData(quadStatement, true, quadStatement->op2, "R1", "FP");

	//do it
	if (quadStatement->op1 == "1")
	{
		//write integer, TRP 1 from R0.
		pushStatement(new assemblyStatement("", "MOV", "R0", dataRegister, "; load int for print."));
		pushStatement(new assemblyStatement("", "TRP", "1", "", ""));
	}
	else if (quadStatement->op1 == "2")
	{
		//write byte, TRP 3 from R0.
		pushStatement(new assemblyStatement("", "MOV", "R0", dataRegister, "; load byt for print."));
		pushStatement(new assemblyStatement("", "TRP", "3", "", ""));
	}
}

void TCGenerator::writeRead(quad* quadStatement)
{
	//get data
	std::string dataRegister = getData(quadStatement, true, quadStatement->op2, "R1", "FP");

	//do it
	if (quadStatement->op1 == "1")
	{
		//read integer, TRP 2 from R0.
		pushStatement(new assemblyStatement("", "MOV", "R0", dataRegister, "; read int for print."));
		pushStatement(new assemblyStatement("", "TRP", "2", "", ""));
	}
	else if (quadStatement->op1 == "2")
	{
		//read byte, TRP 4 from R0.
		pushStatement(new assemblyStatement("", "MOV", "R0", dataRegister, "; read byt for print."));
		pushStatement(new assemblyStatement("", "TRP", "4", "", ""));
	}

	//save data
	storeData(quadStatement->op2, "R0", "R5", "R6", false); //Address registers are R4 (op1) and R5 (op2).
}

void TCGenerator::writeMov(quad* quadStatement)
{
	//get data into a register.
	std::string dataReg1 = getData(quadStatement, true, quadStatement->op1, "R1", "FP"); //first statement is true for labels, otherwise false.
	std::string dataReg2 = getData(quadStatement, false, quadStatement->op2, "R2", "FP");

	//do
	pushStatement(new assemblyStatement("", "MOV", dataReg1, dataReg2, "; Move Data."));

	//save data
	storeData(quadStatement->op1, dataReg1, "R4", "R6", false);
}

void TCGenerator::writeAdd(quad* quadStatement)
{
	//get data
	std::string dataReg1 = getData(quadStatement, true, quadStatement->op1, "R1", "FP");
	std::string dataReg2 = getData(quadStatement, false, quadStatement->op2, "R2", "FP");

	//do
	pushStatement(new assemblyStatement("", "ADD", dataReg1, dataReg2, "; Add Data."));

	//save data
	storeData(quadStatement->op3, dataReg1, "R4", "R6", false);
}

void TCGenerator::writeSub(quad* quadStatement)
{
	//get data
	std::string dataReg1 = getData(quadStatement, true, quadStatement->op1, "R1", "FP");
	std::string dataReg2 = getData(quadStatement, false, quadStatement->op2, "R2", "FP");

	//do
	pushStatement(new assemblyStatement("", "SUB", dataReg1, dataReg2, "; Subtract Data."));

	//save data
	storeData(quadStatement->op3, dataReg1, "R4", "R6", false);
}

void TCGenerator::writeMul(quad* quadStatement)
{
	//get data
	std::string dataReg1 = getData(quadStatement, true, quadStatement->op1, "R1", "FP");
	std::string dataReg2 = getData(quadStatement, false, quadStatement->op2, "R2", "FP");

	//do
	pushStatement(new assemblyStatement("", "MUL", dataReg1, dataReg2, "; Multiply Data."));

	//save data
	storeData(quadStatement->op3, dataReg1, "R4", "R6", false);
}

void TCGenerator::writeDiv(quad* quadStatement)
{
	//get data
	std::string dataReg1 = getData(quadStatement, true, quadStatement->op1, "R1", "FP");
	std::string dataReg2 = getData(quadStatement, false, quadStatement->op2, "R2", "FP");

	//do
	pushStatement(new assemblyStatement("", "DIV", dataReg1, dataReg2, "; Divide Data."));

	//save data
	storeData(quadStatement->op3, dataReg1, "R4", "R6", false);
}

void TCGenerator::writeControlStatement(quad* quadStatement)
{
	//get data
	std::string dataReg1 = getData(quadStatement, true, quadStatement->op1, "R1", "FP");
	std::string dataReg2 = getData(quadStatement, false, quadStatement->op2, "R2", "FP");

	//do
	pushStatement(new assemblyStatement("", "MOV", "R3", dataReg1, "; Move data into 3rd register for compare."));
	pushStatement(new assemblyStatement("", "CMP", "R3", dataReg2, "; Compare Data."));

	//gensym a label to skip setting false use it instead of dataReg2 in next statement.
	std::string firstLabel = st->genSym("L");
	std::string secondLabel = icgen->quads[quadCounter + 1]->label;
	if (secondLabel == "")
	{
		secondLabel = st->genSym("L");
		icgen->quads[quadCounter + 1]->label = secondLabel;
	}

	//check operand of control statement and call correct TCGenerator for it.
	if (quadStatement->instruction == "EQ")
		writeEquality(quadStatement, firstLabel);
	else if (quadStatement->instruction == "LT")
		writeLessThan(quadStatement, firstLabel);
	else if (quadStatement->instruction == "GT")
		writeGreaterThan(quadStatement, firstLabel);
	else if (quadStatement->instruction == "NE")
		writeNotEqual(quadStatement, firstLabel);
	else if (quadStatement->instruction == "LE")
		writeLessThanEqual(quadStatement, firstLabel, dataReg1, dataReg2);
	else if (quadStatement->instruction == "GE")
		writeGreaterThanEqual(quadStatement, firstLabel, dataReg1, dataReg2);

	//R7 holds 0 (true), R8 holds 1 (false).
	pushStatement(new assemblyStatement("", "MOV", "R3", "R8", "; Set FALSE"));
	//need to store data for both cases of false and true.
	storeData(quadStatement->op3, "R3", "R5", "R6", false);

	pushStatement(new assemblyStatement("", "JMP", secondLabel, "", ""));
	pushStatement(new assemblyStatement(firstLabel, "MOV", "R3", "R7", "; Set TRUE"));
	//save data for case of true.
	storeData(quadStatement->op3, "R3", "R5", "R6", false);
}

void TCGenerator::writeEquality(quad* quadStatement, std::string firstLabel)
{
	pushStatement(new assemblyStatement("", "BRZ", "R3", firstLabel, "; " + quadStatement->op1 + " < " + quadStatement->op2 + " GOTO " + firstLabel));
}

void TCGenerator::writeLessThan(quad* quadStatement, std::string firstLabel)
{
	pushStatement(new assemblyStatement("", "BLT", "R3", firstLabel, "; " + quadStatement->op1 + " < " + quadStatement->op2 + " GOTO " + firstLabel));
}

void TCGenerator::writeGreaterThan(quad* quadStatement, std::string firstLabel)
{
	pushStatement(new assemblyStatement("", "BGT", "R3", firstLabel, "; " + quadStatement->op1 + " < " + quadStatement->op2 + " GOTO " + firstLabel));
}

void TCGenerator::writeNotEqual(quad* quadStatement, std::string firstLabel)
{
	pushStatement(new assemblyStatement("", "BNZ", "R3", firstLabel, "; " + quadStatement->op1 + " < " + quadStatement->op2 + " GOTO " + firstLabel));
}

void TCGenerator::writeLessThanEqual(quad* quadStatement, std::string firstLabel, std::string dataReg1, std::string dataReg2)
{
	writeLessThan(quadStatement, firstLabel);
	pushStatement(new assemblyStatement("", "MOV", "R3", dataReg1, "; Move data into 3rd register for compare."));
	pushStatement(new assemblyStatement("", "CMP", "R3", dataReg2, "; Compare Data."));
	writeEquality(quadStatement, firstLabel);
}

void TCGenerator::writeGreaterThanEqual(quad* quadStatement, std::string firstLabel, std::string dataReg1, std::string dataReg2)
{
	writeGreaterThan(quadStatement, firstLabel);
	pushStatement(new assemblyStatement("", "MOV", "R3", dataReg1, "; Move data into 3rd register for compare."));
	pushStatement(new assemblyStatement("", "CMP", "R3", dataReg2, "; Compare Data."));
	writeEquality(quadStatement, firstLabel);
}

void TCGenerator::writeBranchFalse(quad* quadStatement)
{
	//get data
	std::string dataReg1 = getData(quadStatement, true, quadStatement->op1, "R1", "FP");

	//do
	pushStatement(new assemblyStatement("", "BNZ", dataReg1, quadStatement->op2, "; Branch False"));
}

void TCGenerator::writeJump(quad* quadStatement)
{
	pushStatement(new assemblyStatement(quadStatement->label, "JMP", quadStatement->op1, quadStatement->op2, "; " + quadStatement->comment));
}

void TCGenerator::writeLogicalAnd(quad* quadStatement)
{
	//get data
	std::string dataReg1 = getData(quadStatement, true, quadStatement->op1, "R1", "FP");
	std::string dataReg2 = getData(quadStatement, false, quadStatement->op2, "R2", "FP");

	//do
	pushStatement(new assemblyStatement("", "MOV", "R3", dataReg1, ""));
	pushStatement(new assemblyStatement("", "AND", "R3", dataReg2, ""));

	//store
	storeData(quadStatement->op3, "R3", "R5", "R6", false);
}

void TCGenerator::writeLogicalOr(quad* quadStatement)
{
	//get data
	std::string dataReg1 = getData(quadStatement, true, quadStatement->op1, "R1", "FP");
	std::string dataReg2 = getData(quadStatement, false, quadStatement->op2, "R2", "FP");

	//do
	pushStatement(new assemblyStatement("", "MOV", "R3", dataReg1, ""));
	pushStatement(new assemblyStatement("", "OR", "R3", dataReg2, ""));

	//store
	storeData(quadStatement->op3, "R3", "R5", "R6", false);
}

void TCGenerator::writeItoA(quad* quadStatement)
{
	//get data
	std::string dataReg0 = getData(quadStatement, true, quadStatement->op1, "R0", "FP");

	//do TRP 11
	pushStatement(new assemblyStatement("", "TRP", "11", "", "; int to char Register 0."));

	//store
	storeData(quadStatement->op2, "R0", "R3", "R6", false);
}

void TCGenerator::writeNewI(quad* quadStatement)
{
	//R3 holds start address to Free Pointer.
	pushStatement(new assemblyStatement(quadStatement->label, "LDR", "R3", "FREE", "; Get this pointer to heap"));
	//R4 holds this pointer to free address.
	pushStatement(new assemblyStatement("", "MOV", "R4", "R3", "; this -> R4"));
	pushStatement(new assemblyStatement("", "ADI", "R3", quadStatement->op1, "")); //add sizeof object to Free.
	pushStatement(new assemblyStatement("", "STR", "R3", "FREE", ""));

	//get address of (op2) into register 2.
	pushStatement(new assemblyStatement("", "MOV", "R2", "FP", ""));
	pushStatement(new assemblyStatement("", "ADI", "R2", st->symbolTable[quadStatement->op2]->getSize(),""));
	//Store this pointer to heap into temporary.
	pushStatement(new assemblyStatement("", "STR", "R4", "R2", "; Store " + quadStatement->op2));
}

void TCGenerator::writeNew(quad* quadStatement)
{
	//get data for adding new.
	std::string dataReg1 = getData(quadStatement, true, quadStatement->op1, "R1", "FP");

	//R3 holds start address to Free Pointer.
	pushStatement(new assemblyStatement(quadStatement->label, "LDR", "R3", "FREE", "; Get this pointer to heap"));
	//R4 holds this pointer to free address.
	pushStatement(new assemblyStatement("", "MOV", "R4", "R3", "; this -> R4"));


	pushStatement(new assemblyStatement("", "ADD", "R3", dataReg1, "")); //add sizeof object to Free.
	pushStatement(new assemblyStatement("", "STR", "R3", "FREE", ""));

	//get address of (op2) into register 2.
	pushStatement(new assemblyStatement("", "MOV", "R2", "FP", ""));
	pushStatement(new assemblyStatement("", "ADI", "R2", st->symbolTable[quadStatement->op2]->getSize(),""));
	//Store this pointer to heap into temporary.
	pushStatement(new assemblyStatement("", "STR", "R4", "R2", "; Store " + quadStatement->op2));
}

void TCGenerator::writeRef(quad* quadStatement)
{
	//get data
	std::string dataReg1 = getData(quadStatement, true, quadStatement->op1, "R1", "FP");
	std::string dataReg2 = "R2";

	//do
	pushStatement(new assemblyStatement("", "SUB", dataReg2, dataReg2, ""));
	pushStatement(new assemblyStatement("", "ADI", dataReg2, st->symbolTable[quadStatement->op2]->getSize(), ""));

	//Computed address of T34(refers to an instance variable).
	pushStatement(new assemblyStatement("", "ADD", dataReg1, dataReg2, ""));

	bool storeAtAddress = true;

	//Store that computed address in T34. //store into temporary
		//(std::string symid, std::string dataReg, std::string addressReg)
	storeData(quadStatement->op3, dataReg1, "R4", "R6", storeAtAddress);
}

void TCGenerator::writeAEF(quad* quadStatement)
{
	//get data
	std::string dataReg1 = getData(quadStatement, true, quadStatement->op1, "R1", "FP");
	std::string dataReg2 = getData(quadStatement, false, quadStatement->op2, "R2", "FP");

	//do
	pushStatement(new assemblyStatement("", "SUB", "R3", "R3", ""));

	int adiAmt = 0;
	std::string type = st->symbolTable[quadStatement->op1]->getType();

	if (type.size() > 2 && type.at(0) == '@' && type.at(1) == ':')
		type = type.substr(2);

	if (type == "char" || type == "bool")
		adiAmt = 1;
	else adiAmt = 4;

	 std::ostringstream ss;
     ss << adiAmt;
	
	//holds size of type, next multiply in number of indexes.
	pushStatement(new assemblyStatement("", "ADI", "R3", ss.str(), ""));

	//R2 is holding size for multiply.
	pushStatement(new assemblyStatement("", "MUL", "R3", dataReg2, ""));

	//R3 is holding size offset. Compute address of temp.
	pushStatement(new assemblyStatement("", "ADD", dataReg1, "R3", ""));

	bool storeAtAddress = true;

	//Store that computed address in Temp. //store into temporary
		//(std::string symid, std::string dataReg, std::string addressReg)
	storeData(quadStatement->op3, dataReg1, "R4", "R6", storeAtAddress);
}