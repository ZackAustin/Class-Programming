/** \brief
 *
 * \param
 * \param
 * \return
 *
 */
// Name:		Zack Austin
// Date:		10/2/13
// Class:		CS 4380
// Assignment:	Virtual Machine Assembler - Project 1
// Purpose:		byte array understanding.

#include <iostream>
#include <vector>
#include <fstream>
#include <map>
#include <sstream>
#include <iterator>
#include <stdint.h>
#include <stdio.h>

const int MEMORY_SIZE = 3146000; //3 Megabytes.
const int INSTR_SIZE = 12;
const int REG_SIZE = 10;
const int INT_SIZE = 4;
const int CHAR_SIZE = 1;

using namespace std;
void genByteCode(vector<string> &tokens, vector<unsigned char> &MEM, map<string, uint32_t> &symbolTable, int &PC, int iVal);
int endian();
int assemblerPass1(ifstream &assemblyFile, int& instrCounter, int& PC, std::map<string, uint32_t> &symbolTable);
int assemblerPass2(ifstream &assemblyFile, int& instrCounter, int& PC, vector<unsigned char> &MEM, map<string, uint32_t> &symbolTable, int &beginningAddress);
void bigSwitch(std::vector<unsigned char> &MEM, int &PC, std::vector<int> &reg);

#define LITTLE_ENDIAN 0
#define BIG_ENDIAN    1

//ByteCode.
union Bytecode
{
	struct Instruction
	{
		uint32_t opcode;
		uint32_t opd1;
		uint32_t opd2;
	} instrSet;
} instruction;

int main(int argc, char* argv [])
{
	int endianValue = endian();

	//Memory Layout.
	std::vector<unsigned char> MEM(MEMORY_SIZE);
	//Symbol Table.
	std::map<string, uint32_t> symbolTable;
	//Registers.
	std::vector<int> reg(REG_SIZE);

	//Assembler Pass 1. Open file, create symbol table(a map).
	//	Read Assembly Source File
	ifstream assemblyFile;
	if (argc > 1)
	{
		//assemblyFile.open("proj1.asm", ios::binary);
		assemblyFile.open(argv[1], ios::binary);
		if (!assemblyFile.is_open() || !assemblyFile)  // Did the open work?
		{
			cout << "Can't open file for input!\n";
			return 1;
		}

		int instrCounter = 1;
		int PC = 0;
		int success;
		success = assemblerPass1(assemblyFile, instrCounter, PC, symbolTable);
		if (success == 1)
			return 1;
		assemblyFile.close();

		//Finished Assembler Pass 1 - Labels are loaded in to Symbol Table.
		//Next is 2nd Pass where we check and make sure these instructions and labels are correct
		//for the assembly language.

		//Assembler Pass 2
		//assemblyFile.open("proj1.asm", ios::binary);
		assemblyFile.open(argv[1], ios::binary);
		if (!assemblyFile.is_open() || !assemblyFile)  // Did the open work?
		{
			cout << "Can't open file for input!\n";
			return 1;
		}

		instrCounter = 1;
		PC = 0;
		bool firstInstruction = true;
		int beginningAddress = 0;
		success = assemblerPass2(assemblyFile, instrCounter, PC, MEM, symbolTable, beginningAddress);
		if (success == 1)
			return 1;
		assemblyFile.close();

		//Finished Assembler Pass 2 - Labels are referenced in Symbol Table and bytecode loaded into MEM.
		//Now Virtual Machine
		//The Big Switch(VM)
		PC = beginningAddress;
		bigSwitch(MEM, PC, reg);
	}

	return 0;
}

void genByteCode(vector<string> &tokens, vector<unsigned char> &MEM, map<string, uint32_t> &symbolTable, int &PC, int iVal)
{
	//opd1 register
	string regTemp = tokens[iVal+1];
	string reg = "";
	for (unsigned int i = 0; i < regTemp.size(); i++)
	{
		if (tokens[iVal+1].at(i) >= '0' && tokens[iVal+1].at(i) <= '9')
			reg += tokens[iVal+1].at(i);
	}
	int temp = atoi(reg.c_str());
	MEM[PC] = temp;
	PC += INT_SIZE;
	//opd2 label or register
	//if label
	std::map<string, uint32_t>::iterator it = symbolTable.find(tokens[iVal + 2]);
	if (it != symbolTable.end())
		MEM[PC] = it->second;
	else
	{
		//a register
		string op2 = "";
		string op2Temp = tokens[iVal + 2];
		for (unsigned int i = 0; i < op2Temp.size(); i++)
		{
			if (tokens[iVal+2].at(i) >= '0' && tokens[iVal+2].at(i) <= '9')
				op2 += tokens[iVal+2].at(i);
		}
		int temp = atoi(op2.c_str());
		MEM[PC] = temp;
	}
	PC += INT_SIZE;
}

int endian()
{
	int i = 1;
	char *p = (char *) &i;

	if (p[0] == 1)
		return LITTLE_ENDIAN;
	else
		return BIG_ENDIAN;
}

int assemblerPass1(ifstream &assemblyFile, int& instrCounter, int& PC, map<string, uint32_t> &symbolTable)
{
	//Lexical Analysis - Group chars into Tokens
	string aLine;
	string buf;
	while (!assemblyFile.eof())
	{
		getline(assemblyFile, aLine, '\n');
		stringstream ss(aLine);
		vector<string> tokens(60);
		int tokenCount = 0;
		while (ss >> buf)
		{
			tokens[tokenCount] = buf;
			tokenCount++;
		}


		//Check blank line
		if (tokens[0] == "") { instrCounter += 1; }

		//Syntax Analysis - Check Syntax of Instructions
		//Ensure Instructions Defined in Assembly Language
		else if (tokens[0] == ".BYT")
		{
			if (tokens[2].size() > 0)
			{
				if (tokens[2].at(0) == ';') {}
				else
				{
					cout << "Syntax Error on Line " << instrCounter << ".\n";
					return 1;//the instructions invalid. Doesnt fit any of the Operator Syntax's.
				}
			}
			instrCounter += 1;
		}
		else if (tokens[0] == ".INT")
		{
			if (tokens[2].size() > 0)
			{
				if (tokens[2].at(0) == ';') {}
				else
				{
					cout << "Syntax Error on Line " << instrCounter << ".\n";
					return 1;//the instructions invalid. Doesnt fit any of the Operator Syntax's.
				}
			}
			instrCounter += 1;
		}
		else if (tokens[0] == "LDB" || tokens[0] == "LDR" || tokens[0] == "ADD" || tokens[0] == "SUB" || tokens[0] == "MUL"
			|| tokens[0] == "DIV")
		{
			if (tokens[1] == "R0," || tokens[1] == "R1," || tokens[1] == "R2," || tokens[1] == "R3," || tokens[1] == "R4," ||
				tokens[1] == "R5," || tokens[1] == "R6," || tokens[1] == "R7,"){
			}
			else
			{
				cout << "Syntax Error on Line " << instrCounter << ".\n";
				return 1;//the instructions invalid. Doesnt fit any of the Operator Syntax's.
			}
			if (tokens[3].size() > 0)
			{
				if (tokens[3].at(0) == ';') {}
				else
				{
					cout << "Syntax Error on Line " << instrCounter << ".\n";
					return 1;//the instructions invalid. Doesnt fit any of the Operator Syntax's.
				}
			}
			instrCounter += 1;
		}
		else if (tokens[0] == "TRP")
		{
			if (tokens[2].size() > 0)
			{
				if (tokens[2].at(0) == ';') {}
				else
				{
					cout << "Syntax Error on Line " << instrCounter << ".\n";
					return 1;//the instructions invalid. Doesnt fit any of the Operator Syntax's.
				}
			}
			instrCounter += 1;
		}
		else
		{
			//its a label, load it. Next thing is the Operator.
			//check rest of instruction
			if (tokens[1] == ".BYT")
			{
				if (tokens[3].size() > 0)
				{
					if (tokens[3].at(0) == ';') {}
					else
					{
						cout << "Syntax Error on Line " << instrCounter << ".\n";
						return 1;//the instructions invalid. Doesnt fit any of the Operator Syntax's.
					}
				}
				symbolTable.insert(std::pair<string, uint32_t>(tokens[0], PC));
				instrCounter += 1;
				PC += CHAR_SIZE;
			}
			else if (tokens[1] == ".INT")
			{
				if (tokens[3].size() > 0)
				{
					if (tokens[3].at(0) == ';') {}
					else
					{
						cout << "Syntax Error on Line " << instrCounter << ".\n";
						return 1;//the instructions invalid. Doesnt fit any of the Operator Syntax's.
					}
				}
				symbolTable.insert(std::pair<string, uint32_t>(tokens[0], PC));
				instrCounter += 1;
				PC += INT_SIZE;
			}
			else if (tokens[1] == "LDB" || tokens[1] == "LDR" || tokens[1] == "ADD" || tokens[1] == "SUB" || tokens[1] == "MUL"
				|| tokens[1] == "DIV")
			{
				if (tokens[2] == "R0," || tokens[2] == "R1," || tokens[2] == "R2," || tokens[2] == "R3," || tokens[2] == "R4," ||
					tokens[2] == "R5," || tokens[2] == "R6," || tokens[2] == "R7,"){
				}
				else
				{
					cout << "Syntax Error on Line " << instrCounter << ".\n";
					return 1;//the instructions invalid. Doesnt fit any of the Operator Syntax's.
				}
				if (tokens[4].size() > 0)
					if (tokens[4].at(0) == ';') {}
					else
					{
						cout << "Syntax Error on Line " << instrCounter << ".\n";
						return 1;//the instructions invalid. Doesnt fit any of the Operator Syntax's.
					}
					symbolTable.insert(std::pair<string, uint32_t>(tokens[0], PC));
					instrCounter += 1;
					PC += INSTR_SIZE;
			}

			else if (tokens[1] == "TRP")
			{
				if (tokens[3].size() > 0)
				{
					if (tokens[3].at(0) == ';') {}
					else
					{
						cout << "Syntax Error on Line " << instrCounter << ".\n";
						return 1;//the instructions invalid. Doesnt fit any of the Operator Syntax's.
					}
				}
				symbolTable.insert(std::pair<string, uint32_t>(tokens[0], PC));
				instrCounter += 1;
				PC += INSTR_SIZE;
			}
			else
			{
				//Check for comment line
				if (tokens[0].size() > 0)
				{
					if (tokens[0].at(0) == ';'){ instrCounter += 1; }
				}
				else
				{
					cout << "Syntax Error on Line " << instrCounter << ".\n";
					return 1;//the instructions invalid. Doesnt fit any of the Operator Syntax's.
				}
			}
		}
	}
	return 0;
}

int assemblerPass2(ifstream &assemblyFile, int& instrCounter, int& PC, vector<unsigned char> &MEM, map<string, uint32_t> &symbolTable, int &beginningAddress)
{
	string aLine;
	string buf;
	bool firstInstruction = true;
	while (!assemblyFile.eof())
	{
		getline(assemblyFile, aLine, '\n');
		stringstream ss(aLine);
		vector<string> tokens(60);
		int tokenCount = 0;
		while (ss >> buf)
		{
			tokens[tokenCount] = buf;
			tokenCount++;
		}
		//Semantics Analysis - Check that Referenced Labels are defined in the Symbol Table
		//LDR	R1, NUTMEG	is label NUTMEG defined(what is its address ? )
		//JMP	NEXT		is label NEXT defined(what is its address ? )
		int ivalNoLabel = 0;
		//Check blank line
		if (tokens[0] == "") { instrCounter += 1; }
		else if (tokens[0] == ".BYT")
		{
			//no semantics check for directives.
			//load value into memory
			if (tokens[1].at(0) == '\'')
				MEM[PC] = tokens[1].at(1);
			else if (tokens[1].at(0) >= 48 && tokens[1].at(0) <= 57)
			{
				std::stringstream ss;
				ss << std::hex << tokens[1];
				int temp;
				ss >> temp;
				MEM[PC] = temp;
			}
			else
			{
				std::stringstream ss;
				ss << std::hex << tokens[2];
				int temp;
				ss >> temp;
				MEM[PC] = temp;
			}
			PC += CHAR_SIZE;
			instrCounter++;
		}
		else if (tokens[0] == ".INT")
		{
			//no semantics check for directives.
			//load value into memory
			int temp = atoi(tokens[2].c_str());
			char a[4];
			*((int *) a) = temp;
			for (int i = 0; i < 4; i++)
				MEM[PC + i] = a[i];
			PC += INT_SIZE;
			instrCounter++;
		}
		else if (tokens[0] == "LDB")
		{
			//Check Semantics
			std::map<string, uint32_t>::iterator it = symbolTable.find(tokens[2]);
			if (it == symbolTable.end() && tokens[2] != "R0" && tokens[2] != "R1" && tokens[2] != "R2" && tokens[2] != "R3" && tokens[2] != "R4" &&
				tokens[2] != "R5" && tokens[2] != "R6" && tokens[2] != "R7" && tokens[2] != "R8" && tokens[2] != "R9")
			{
				cout << "Semantics Error on Line " << instrCounter << ": LDB Instruction - Label not in Table.\n";
				return 1;
			}
			if (firstInstruction)
			{
				beginningAddress = PC;
				firstInstruction = false;
			}
			//Generate Byte Code. Fixed Length of 3 ints (12 bytes). [opcode.opd1.opd2]
			//opcode
			MEM[PC] = 0;
			PC += INT_SIZE;
			//call genByteCode.
			genByteCode(tokens, MEM, symbolTable, PC, ivalNoLabel);
			instrCounter++;
		}
		else if (tokens[0] == "LDR")
		{
			std::map<string, uint32_t>::iterator it = symbolTable.find(tokens[2]);
			if (it == symbolTable.end() && tokens[2] != "R0" && tokens[2] != "R1" && tokens[2] != "R2" && tokens[2] != "R3" && tokens[2] != "R4" &&
				tokens[2] != "R5" && tokens[2] != "R6" && tokens[2] != "R7" && tokens[2] != "R8" && tokens[2] != "R9")
			{
				cout << "Semantics Error on Line " << instrCounter << ": LDR Instruction - Label not in Table.\n";
				return 1;
			}
			if (firstInstruction)
			{
				beginningAddress = PC;
				firstInstruction = false;
			}
			MEM[PC] = 1;
			PC += INT_SIZE;
			genByteCode(tokens, MEM, symbolTable, PC, ivalNoLabel);
			instrCounter++;
		}
		else if (tokens[0] == "ADD")
		{
			std::map<string, uint32_t>::iterator it = symbolTable.find(tokens[2]);
			if (it == symbolTable.end() && tokens[2] != "R0" && tokens[2] != "R1" && tokens[2] != "R2" && tokens[2] != "R3" && tokens[2] != "R4" &&
				tokens[2] != "R5" && tokens[2] != "R6" && tokens[2] != "R7" && tokens[2] != "R8" && tokens[2] != "R9")
			{
				cout << "Semantics Error on Line " << instrCounter << ": ADD Instruction - Label not in Table.\n";
				return 1;
			}
			if (firstInstruction)
			{
				beginningAddress = PC;
				firstInstruction = false;
			}
			MEM[PC] = 2;
			PC += INT_SIZE;
			genByteCode(tokens, MEM, symbolTable, PC, ivalNoLabel);
			instrCounter++;
		}
		else if (tokens[0] == "SUB")
		{
			std::map<string, uint32_t>::iterator it = symbolTable.find(tokens[2]);
			if (it == symbolTable.end() && tokens[2] != "R0" && tokens[2] != "R1" && tokens[2] != "R2" && tokens[2] != "R3" && tokens[2] != "R4" &&
				tokens[2] != "R5" && tokens[2] != "R6" && tokens[2] != "R7" && tokens[2] != "R8" && tokens[2] != "R9")
			{
				cout << "Semantics Error on Line " << instrCounter << ": SUB Instruction - Label not in Table.\n";
				return 1;
			}
			if (firstInstruction)
			{
				beginningAddress = PC;
				firstInstruction = false;
			}
			MEM[PC] = 3;
			PC += 4;
			genByteCode(tokens, MEM, symbolTable, PC, ivalNoLabel);
			instrCounter++;
		}
		else if (tokens[0] == "MUL")
		{
			std::map<string, uint32_t>::iterator it = symbolTable.find(tokens[2]);
			if (it == symbolTable.end() && tokens[2] != "R0" && tokens[2] != "R1" && tokens[2] != "R2" && tokens[2] != "R3" && tokens[2] != "R4" &&
				tokens[2] != "R5" && tokens[2] != "R6" && tokens[2] != "R7" && tokens[2] != "R8" && tokens[2] != "R9")
			{
				cout << "Semantics Error on Line " << instrCounter << ": MUL Instruction - Label not in Table.\n";
				return 1;
			}
			if (firstInstruction)
			{
				beginningAddress = PC;
				firstInstruction = false;
			}
			MEM[PC] = 4;
			PC += INT_SIZE;
			genByteCode(tokens, MEM, symbolTable, PC, ivalNoLabel);
			instrCounter++;
		}
		else if (tokens[0] == "DIV")
		{
			std::map<string, uint32_t>::iterator it = symbolTable.find(tokens[2]);
			if (it == symbolTable.end() && tokens[2] != "R0" && tokens[2] != "R1" && tokens[2] != "R2" && tokens[2] != "R3" && tokens[2] != "R4" &&
				tokens[2] != "R5" && tokens[2] != "R6" && tokens[2] != "R7" && tokens[2] != "R8" && tokens[2] != "R9")
			{
				cout << "Semantics Error on Line " << instrCounter << ": DIV Instruction - Label not in Table.\n";
				return 1;
			}
			if (firstInstruction)
			{
				beginningAddress = PC;
				firstInstruction = false;
			}
			MEM[PC] = 5;
			PC += INT_SIZE;
			genByteCode(tokens, MEM, symbolTable, PC, ivalNoLabel);
			instrCounter++;
		}
		else if (tokens[0] == "TRP")
		{
			//no semantics on trp
			//opcode, for trap
			MEM[PC] = 6;
			if (firstInstruction)
			{
				beginningAddress = PC;
				firstInstruction = false;
			}
			PC += INT_SIZE;
			//opd1, immediate value
			std::stringstream ss;
			ss << std::hex << tokens[1];
			int temp;
			ss >> temp;
			MEM[PC] = temp;
			PC += INT_SIZE;
			//opd2, nothing
			MEM[PC] = 0;
			PC += INT_SIZE;
			instrCounter++;
		}
		else if (tokens[0] == "") { instrCounter += 1; PC += INSTR_SIZE; }
		else
		{
			int iVal = 1;
			//first thing was label, ignore it.
			if (tokens[1] == ".BYT")
			{
				//no semantics check for directives.
				//load value into memory
				if (tokens[2].at(0) == '\'')
					MEM[PC] = tokens[2].at(1);
				else if (tokens[2].at(0) >= 48 && tokens[2].at(0) <= 57)
				{
					std::stringstream ss;
					ss << std::hex << tokens[2];
					int temp;
					ss >> temp;
					MEM[PC] = temp;
				}
				else
				{
					std::stringstream ss;
					ss << std::hex << tokens[2];
					int temp;
					ss >> temp;
					MEM[PC] = temp;
				}
				PC += CHAR_SIZE;
				instrCounter++;
			}
			else if (tokens[1] == ".INT")
			{
				//no semantics check for directives.
				//load value into memory
				int temp = atoi(tokens[2].c_str());
				char a[4];
				*((int *) a) = temp;
				for (int i = 0; i < 4; i++)
					MEM[PC + i] = a[i];
				PC += INT_SIZE;
				instrCounter++;
			}
			else if (tokens[1] == "LDB")
			{
				std::map<string, uint32_t>::iterator it = symbolTable.find(tokens[3]);
				if (it == symbolTable.end() && tokens[3] != "R0" && tokens[3] != "R1" && tokens[3] != "R2" && tokens[3] != "R3" && tokens[3] != "R4"
					&& tokens[3] != "R5" && tokens[3] != "R6" && tokens[3] != "R7" && tokens[3] != "R8" && tokens[3] != "R9")
				{
					cout << "Semantics Error on Line " << instrCounter << ": LDB Instruction - Label not in Table.\n";
					return 1;
				}
				if (firstInstruction)
				{
					beginningAddress = PC;
					firstInstruction = false;
				}
				//Generate Byte Code. Fixed Length of 3 ints (12 bytes). [opcode.opd1.opd2]
				//opcode
				MEM[PC] = 0;
				PC += INT_SIZE;
				//Call a function here
				genByteCode(tokens, MEM, symbolTable, PC, iVal);
				instrCounter++;
			}
			else if (tokens[1] == "LDR")
			{
				std::map<string, uint32_t>::iterator it = symbolTable.find(tokens[3]);
				if (it == symbolTable.end() && tokens[3] != "R0" && tokens[3] != "R1" && tokens[3] != "R2" && tokens[3] != "R3" && tokens[3] != "R4"
					&& tokens[3] != "R5" && tokens[3] != "R6" && tokens[3] != "R7" && tokens[3] != "R8" && tokens[3] != "R9")
				{
					cout << "Semantics Error on Line " << instrCounter << ": LDR Instruction - Label not in Table.\n";
					return 1;
				}
				if (firstInstruction)
				{
					beginningAddress = PC;
					firstInstruction = false;
				}
				MEM[PC] = 1;
				PC += INT_SIZE;
				genByteCode(tokens, MEM, symbolTable, PC, iVal);
				instrCounter++;
			}
			else if (tokens[1] == "ADD")
			{
				std::map<string, uint32_t>::iterator it = symbolTable.find(tokens[3]);
				if (it == symbolTable.end() && tokens[3] != "R0" && tokens[3] != "R1" && tokens[3] != "R2" && tokens[3] != "R3" && tokens[3] != "R4"
					&& tokens[3] != "R5" && tokens[3] != "R6" && tokens[3] != "R7" && tokens[3] != "R8" && tokens[3] != "R9")
				{
					cout << "Semantics Error on Line " << instrCounter << ": ADD Instruction - Label not in Table.\n";
					return 1;
				}
				if (firstInstruction)
				{
					beginningAddress = PC;
					firstInstruction = false;
				}
				MEM[PC] = 2;
				PC += INT_SIZE;
				genByteCode(tokens, MEM, symbolTable, PC, iVal);
				instrCounter++;
			}
			else if (tokens[1] == "SUB")
			{
				std::map<string, uint32_t>::iterator it = symbolTable.find(tokens[3]);
				if (it == symbolTable.end() && tokens[3] != "R0" && tokens[3] != "R1" && tokens[3] != "R2" && tokens[3] != "R3" && tokens[3] != "R4"
					&& tokens[3] != "R5" && tokens[3] != "R6" && tokens[3] != "R7" && tokens[3] != "R8" && tokens[3] != "R9")
				{
					cout << "Semantics Error on Line " << instrCounter << ": SUB Instruction - Label not in Table.\n";
					return 1;
				}
				if (firstInstruction)
				{
					beginningAddress = PC;
					firstInstruction = false;
				}
				MEM[PC] = 3;
				PC += INT_SIZE;
				genByteCode(tokens, MEM, symbolTable, PC, iVal);
				instrCounter++;
			}
			else if (tokens[1] == "MUL")
			{
				std::map<string, uint32_t>::iterator it = symbolTable.find(tokens[3]);
				if (it == symbolTable.end() && tokens[3] != "R0" && tokens[3] != "R1" && tokens[3] != "R2" && tokens[3] != "R3" && tokens[3] != "R4"
					&& tokens[3] != "R5" && tokens[3] != "R6" && tokens[3] != "R7" && tokens[3] != "R8" && tokens[3] != "R9")
				{
					cout << "Semantics Error on Line " << instrCounter << ": MUL Instruction - Label not in Table.\n";
					return 1;
				}
				if (firstInstruction)
				{
					beginningAddress = PC;
					firstInstruction = false;
				}
				MEM[PC] = 4;
				PC += INT_SIZE;
				genByteCode(tokens, MEM, symbolTable, PC, iVal);
				instrCounter++;
			}
			else if (tokens[1] == "DIV")
			{
				std::map<string, uint32_t>::iterator it = symbolTable.find(tokens[3]);
				if (it == symbolTable.end() && tokens[3] != "R0" && tokens[3] != "R1" && tokens[3] != "R2" && tokens[3] != "R3" && tokens[3] != "R4"
					&& tokens[3] != "R5" && tokens[3] != "R6" && tokens[3] != "R7" && tokens[3] != "R8" && tokens[3] != "R9")
				{
					cout << "Semantics Error on Line " << instrCounter << ": DIV Instruction - Label not in Table.\n";
					return 1;
				}
				if (firstInstruction)
				{
					beginningAddress = PC;
					firstInstruction = false;
				}
				MEM[PC] = 5;
				PC += INT_SIZE;
				genByteCode(tokens, MEM, symbolTable, PC, iVal);
				instrCounter++;
			}
			else if (tokens[1] == "TRP")
			{
				//opcode, for trap
				MEM[PC] = 6;
				if (firstInstruction)
				{
					beginningAddress = PC;
					firstInstruction = false;
				}
				PC += INT_SIZE;
				//opd1, immediate value
				std::stringstream ss;
				ss << std::hex << tokens[2];
				int temp;
				ss >> temp;
				MEM[PC] = temp;
				PC += INT_SIZE;
				//opd2, nothing
				MEM[PC] = 0;
				PC += INT_SIZE;
				instrCounter++;
			}
		}
	}
	return 0;
}

void bigSwitch(std::vector<unsigned char> &MEM, int &PC, std::vector<int> &reg)
{
	bool running = true;
	while (running)
	{
		Bytecode *instrSet = (Bytecode*) (&MEM[PC]);
		switch (instrSet->instrSet.opcode)
		{
			//LDB
		case 0:
			reg[instrSet->instrSet.opd1] = MEM[instrSet->instrSet.opd2];
			PC += INSTR_SIZE;
			break;
			//LDR
		case 1:
			reg[instrSet->instrSet.opd1] = *(int*) &MEM[instrSet->instrSet.opd2];
			PC += INSTR_SIZE;
			break;
			//ADD
		case 2:
			reg[instrSet->instrSet.opd1] = reg[instrSet->instrSet.opd1] + reg[instrSet->instrSet.opd2];
			PC += INSTR_SIZE;
			break;
			//SUB
		case 3:
			reg[instrSet->instrSet.opd1] = reg[instrSet->instrSet.opd1] - reg[instrSet->instrSet.opd2];
			PC += INSTR_SIZE;
			break;
			//MUL
		case 4:
			reg[instrSet->instrSet.opd1] = reg[instrSet->instrSet.opd1] * reg[instrSet->instrSet.opd2];
			PC += INSTR_SIZE;
			break;
			//DIV
		case 5:
			reg[instrSet->instrSet.opd1] = reg[instrSet->instrSet.opd1] / reg[instrSet->instrSet.opd2];
			PC += INSTR_SIZE;
			break;
			//TRP
		case 6:
			if (instrSet->instrSet.opd1 == 1)
				cout << reg[0];
			if (instrSet->instrSet.opd1 == 3)
				cout << (char) reg[0];
			if (instrSet->instrSet.opd1 == 0)
				running = false;
			PC += INSTR_SIZE;
			break;
		}
	}
}
