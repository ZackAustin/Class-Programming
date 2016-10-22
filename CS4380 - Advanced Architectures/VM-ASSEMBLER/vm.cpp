// Name:		Zack Austin
// Date:		10/2/13
// Class:		CS 4380
// Assignment:	Virtual Machine Assembler.
// Purpose:		Learn Architectures.

#include <iostream>
#include <vector>
#include <fstream>
#include <map>
#include <sstream>
#include <iterator>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <locale>
#include <algorithm>
#include <string>
#include <string.h>

const int MEMORY_SIZE = 3146000; //3 Megabytes.
const int INSTR_SIZE = 12;
const int REG_SIZE = 10;
const int INT_SIZE = 4;
const int CHAR_SIZE = 1;

using namespace std;

int endian();
int assemblerPass1(ifstream &assemblyFile, int& instrCounter, int& PC, std::map<string, int> &symbolTable);
int assemblerPass2(ifstream &assemblyFile, int& instrCounter, int& PC, vector<unsigned char> &MEM, map<string, int> &symbolTable, int &beginningAddress);
void genByteCode(vector<string> &tokens, vector<unsigned char> &MEM, map<string, int> &symbolTable, int &PC, int iVal);
void bigSwitch(std::vector<unsigned char> &MEM, int &PC, std::vector<int32_t> &reg, std::map<string, int32_t> &symbolTable);
bool aRegister(string token);
bool anInstruction(string token);
bool aNumber(const std::string& s);

#define LITTLE_ENDIAN 0
#define BIG_ENDIAN    1

//ByteCode.
	struct Bytecode
	{
		int32_t opcode;
		int32_t opd1;
		int32_t opd2;
	} instrSet;

int main(int argc, char* argv [])
{
	//Memory Layout.
	std::vector<unsigned char> MEM(MEMORY_SIZE);
	//Symbol Table.
	std::map<string, int32_t> symbolTable;
	//Registers.
	std::vector<int32_t> reg(REG_SIZE);

	//Assembler Pass 1. Open file, create symbol table(a map).
	//	Read Assembly Source File
	ifstream assemblyFile;
	if (argc > 1)
	{
		//assemblyFile.open("proj2.asm", ios::binary);
		assemblyFile.open(argv[1], ios::binary);
		if (!assemblyFile.is_open() || !assemblyFile)  // Did the open work?
		{
			cout << "Can't open file for input!\n";
			return 1;
		}

		int instrCounter = 1, PC = 0, success = -1;
		success = assemblerPass1(assemblyFile, instrCounter, PC, symbolTable);
		if (success == 1)
			return 1;
		assemblyFile.close();

		//Finished Assembler Pass 1 - Labels are loaded in to Symbol Table.
		//Next is 2nd Pass where we check and make sure these instructions and labels are correct
		//for the assembly language.

		//Assembler Pass 2
		//assemblyFile.open("proj2.asm", ios::binary);
		assemblyFile.open(argv[1], ios::binary);
		if (!assemblyFile.is_open() || !assemblyFile)  // Did the open work?
		{
			cout << "Can't open file for input!\n";
			return 1;
		}

		instrCounter = 1, PC = 0;
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
		bigSwitch(MEM, PC, reg, symbolTable);
	}
	return 0;
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
int assemblerPass1(ifstream &assemblyFile, int& instrCounter, int& PC, map<string, int32_t> &symbolTable)
{
	//Lexical Analysis - Group chars into Tokens
	string aLine, buf;
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
		else if (tokens[0] == ".BYT" || tokens[0] == ".INT")
		{
			if (tokens[2].size() > 0)
			{
				if (tokens[2].at(0) == ';') {}
			}
			instrCounter += 1;
			if (tokens[0] == ".BYT")
				PC += CHAR_SIZE;
			else if (tokens[0] == ".INT")
				PC += INT_SIZE;
		}
		else if (anInstruction(tokens[0]))
		{
			if (aRegister(tokens[1]))
			{
				if (tokens[3].size() > 0)
					if (tokens[3].at(0) == ';') {}
			}
			instrCounter += 1;
			PC += INSTR_SIZE;
		}
		else
		{
			//its a label, load it. Next thing is the Operator.
			//check rest of instruction
			if (tokens[1] == ".BYT" || tokens[1] == ".INT")
			{
				if (tokens[3].size() > 0)
				{
					if (tokens[3].at(0) == ';') {}
				}
				symbolTable.insert(std::pair<string, int32_t>(tokens[0], PC));
				instrCounter += 1;
				if (tokens[1] == ".BYT")
					PC += CHAR_SIZE;
				else if (tokens[1] == ".INT")
					PC += INT_SIZE;
			}
			else if (anInstruction(tokens[1]))
			{
				if (aRegister(tokens[2]))
				{
					if (tokens[4].size() > 0)
						if (tokens[4].at(0) == ';') {}
				}
				symbolTable.insert(std::pair<string, int32_t>(tokens[0], PC));
				instrCounter += 1;
				PC += INSTR_SIZE;
			}
			else
			{
				//Check for comment line
				if (tokens[0].size() > 0)
				{
					if (tokens[0].at(0) == ';'){ instrCounter ++; }
					else
					{
						symbolTable.insert(std::pair<string, int32_t>(tokens[0], PC));
						instrCounter ++;
					}
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
int assemblerPass2(ifstream &assemblyFile, int& instrCounter, int& PC, vector<unsigned char> &MEM, map<string, int32_t> &symbolTable, int &beginningAddress)
{
	string aLine;
	string buf;
	char a[4];
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
		int iVal = 0,tempOpCode = -1;
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
				ss << std::hex << tokens[1];
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
			int32_t temp = atoi(tokens[1].c_str());
			for (int i = 0; i < 4; i++)
			{
				a[i] = (temp >> (8 * i)) & 0xff;
				MEM[PC + i] = a[i];
			}
			PC += INT_SIZE;
			instrCounter++;
		}
		else if (anInstruction(tokens[0]))
		{
			//Check Semantics
			std::map<string, int32_t>::iterator it = symbolTable.find(tokens[2]);
			if (tokens[2].size() > 0)
			{
				if (tokens[2].at(0) == ';'){}
				else if (it == symbolTable.end() && !aRegister(tokens[2]) && !aNumber(tokens[2]))
				{
					cout << "Semantics Error on Line " << instrCounter << ": " << tokens[0] << " Instruction - Label not in Table.\n";
					return 1;
				}
			}
			if (firstInstruction)
			{
				beginningAddress = PC;
				firstInstruction = false;
			}
			if (tokens[0] == "LDB")
			{
				tempOpCode = 0;
				if (aRegister(tokens[2]))
					tempOpCode++;
			}
			if (tokens[0] == "LDR")
			{
				tempOpCode = 2;
				if (aRegister(tokens[2]))
					tempOpCode++;
			}
			if (tokens[0] == "ADD")
				tempOpCode = 4;
			else if (tokens[0] == "SUB")
				tempOpCode = 5;
			else if (tokens[0] == "MUL")
				tempOpCode = 6;
			else if (tokens[0] == "DIV")
				tempOpCode = 7;
			else if (tokens[0] == "TRP")
			{
				tempOpCode = 8;
				tokens[2] = "0";
			}
			else if (tokens[0] == "STB")
			{
				tempOpCode = 9;
				if (aRegister(tokens[2]))
					tempOpCode++;
			}
			else if (tokens[0] == "STR")
			{
				tempOpCode = 11;
				if (aRegister(tokens[2]))
					tempOpCode++;
			}
			else if (tokens[0] == "JMP")
			{
				tempOpCode = 13;
				tokens[2] = "0";
			}
			else if (tokens[0] == "JMR")
			{
				tempOpCode = 14;
				tokens[2] = "0";
			}
			else if (tokens[0] == "BNZ")
				tempOpCode = 15;
			else if (tokens[0] == "BGT")
				tempOpCode = 16;
			else if (tokens[0] == "BLT")
				tempOpCode = 17;
			else if (tokens[0] == "BRZ")
				tempOpCode = 18;
			else if (tokens[0] == "MOV")
				tempOpCode = 19;
			else if (tokens[0] == "LDA")
				tempOpCode = 20;
			else if (tokens[0] == "ADI")
				tempOpCode = 21;
			else if (tokens[0] == "AND")
				tempOpCode = 22;
			else if (tokens[0] == "OR")
				tempOpCode = 23;
			else if (tokens[0] == "CMP")
				tempOpCode = 24;

			//Generate Byte Code. Fixed Length of 3 ints (12 bytes). [opcode.opd1.opd2]
			MEM[PC] = tempOpCode;
			PC += INT_SIZE;
			genByteCode(tokens, MEM, symbolTable, PC, iVal);
			instrCounter++;
		}
		else
		{
			iVal = 1;
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
				int32_t temp = atoi(tokens[2].c_str());
				for (int i = 0; i < 4; i++)
				{
					a[i] = (temp >> (8 * i)) & 0xff;
					MEM[PC + i] = a[i];
				}
				PC += INT_SIZE;
				instrCounter++;
			}
			else if (anInstruction(tokens[1]))
			{
				//Check Semantics
				std::map<string, int32_t>::iterator it = symbolTable.find(tokens[3]);
				if (tokens[3].size() > 0)
				{
					if (tokens[3].at(0) == ';'){}
					else if (it == symbolTable.end() && !aRegister(tokens[3]) && !aNumber(tokens[3]))
					{
						cout << "Semantics Error on Line " << instrCounter << ": " << tokens[1] << " Instruction - Label not in Table.\n";
						return 1;
					}
				}
				if (firstInstruction)
				{
					beginningAddress = PC;
					firstInstruction = false;
				}
				if (tokens[1] == "LDB")
				{
					tempOpCode = 0;
					if (aRegister(tokens[3]))
						tempOpCode++;
				}
				if (tokens[1] == "LDR")
				{
					tempOpCode = 2;
					if (aRegister(tokens[3]))
						tempOpCode++;
				}
				if (tokens[1] == "ADD")
					tempOpCode = 4;
				else if (tokens[1] == "SUB")
					tempOpCode = 5;
				else if (tokens[1] == "MUL")
					tempOpCode = 6;
				else if (tokens[1] == "DIV")
					tempOpCode = 7;
				else if (tokens[1] == "TRP")
				{
					tempOpCode = 8;
					tokens[3] = "0";
				}
				else if (tokens[1] == "STB")
				{
					tempOpCode = 9;
					if (aRegister(tokens[3]))
						tempOpCode++;
				}
				else if (tokens[1] == "STR")
				{
					tempOpCode = 11;
					if (aRegister(tokens[3]))
						tempOpCode++;
				}
				else if (tokens[1] == "JMP")
				{
					tempOpCode = 13;
					tokens[3] = "0";
				}
				else if (tokens[1] == "JMR")
				{
					tempOpCode = 14;
					tokens[3] = "0";
				}
				else if (tokens[1] == "BNZ")
					tempOpCode = 15;
				else if (tokens[1] == "BGT")
					tempOpCode = 16;
				else if (tokens[1] == "BLT")
					tempOpCode = 17;
				else if (tokens[1] == "BRZ")
					tempOpCode = 18;
				else if (tokens[1] == "MOV")
					tempOpCode = 19;
				else if (tokens[1] == "LDA")
					tempOpCode = 20;
				else if (tokens[1] == "ADI")
					tempOpCode = 21;
				else if (tokens[1] == "AND")
					tempOpCode = 22;
				else if (tokens[1] == "OR")
					tempOpCode = 23;
				else if (tokens[1] == "CMP")
					tempOpCode = 24;
				//Generate Byte Code. Fixed Length of 3 ints (12 bytes). [opcode.opd1.opd2]
				MEM[PC] = tempOpCode;
				PC += INT_SIZE;
				genByteCode(tokens, MEM, symbolTable, PC, iVal);
				instrCounter++;
			}
			else
				instrCounter++;
		}
	}
	return 0;
}
void genByteCode(vector<string> &tokens, vector<unsigned char> &MEM, map<string, int32_t> &symbolTable, int &PC, int iVal)
{
	char a[4];
	//opd1 register or label(JMP)
	//if label
	std::map<string, int32_t>::iterator itop1 = symbolTable.find(tokens[iVal + 1]);
	if (itop1 != symbolTable.end())
	{
		int32_t temp = itop1->second;
		for (int i = 0; i < 4; i++)
		{
			a[i] = (temp >> (8 * i)) & 0xff;
			MEM[PC + i] = a[i];
		}
	}
	else
	{
		string regTemp = tokens[iVal + 1];
		string reg = "";
		for (unsigned int i = 0; i < regTemp.size(); i++)
		{
			if (tokens[iVal + 1].at(i) >= '0' && tokens[iVal + 1].at(i) <= '9')
				reg += tokens[iVal + 1].at(i);
		}
		int32_t temp = atoi(reg.c_str());
		for (int i = 0; i < 4; i++)
		{
			a[i] = (temp >> (8 * i)) & 0xff;
			MEM[PC + i] = a[i];
		}
	}
	PC += INT_SIZE;
	//opd2 label or register
	//if label
	std::map<string, int32_t>::iterator itop2 = symbolTable.find(tokens[iVal + 2]);
	if (itop2 != symbolTable.end())
	{
		int32_t temp = itop2->second;
		for (int i = 0; i < 4; i++)
		{
			a[i] = (temp >> (8 * i)) & 0xff;
			MEM[PC + i] = a[i];
		}
	}
	else
	{
	//a register
		string op2 = "";
		string op2Temp = tokens[iVal + 2];
		for (unsigned int i = 0; i < op2Temp.size(); i++)
		{
			if (tokens[iVal + 2].at(i) >= '0' && tokens[iVal + 2].at(i) <= '9')
				op2 += tokens[iVal + 2].at(i);
		}
		int32_t temp = atoi(op2.c_str());
		for (int i = 0; i < 4; i++)
		{
			a[i] = (temp >> (8 * i)) & 0xff;
			MEM[PC + i] = a[i];
		}
	}
	PC += INT_SIZE;
}
void bigSwitch(std::vector<unsigned char> &MEM, int &PC, std::vector<int32_t> &reg, std::map<string, int32_t> &symbolTable)
{
	bool running = true;
	while (running)
	{
		char a[4];
		Bytecode *instrSet = (Bytecode*) (&MEM[PC]);
		switch (instrSet->opcode)
		{
			//LDB immediate / direct mode
		case 0:
			reg[instrSet->opd1] = MEM[instrSet->opd2];
			PC += INSTR_SIZE;
			break;
			//LDB register-indirect mode
		case 1:
			reg[instrSet->opd1] = MEM[reg[instrSet->opd2]];
			PC += INSTR_SIZE;
			break;
			//LDR immediate / direct mode
		case 2:
			reg[instrSet->opd1] = *(int32_t*) &MEM[instrSet->opd2];
			PC += INSTR_SIZE;
			break;
			//LDR register-indirect mode
		case 3:
			reg[instrSet->opd1] = *(int32_t*) &MEM[reg[instrSet->opd2]];
			PC += INSTR_SIZE;
			break;
			//ADD
		case 4:
			reg[instrSet->opd1] = reg[instrSet->opd1] + reg[instrSet->opd2];
			PC += INSTR_SIZE;
			break;
			//SUB
		case 5:
			reg[instrSet->opd1] = reg[instrSet->opd1] - reg[instrSet->opd2];
			PC += INSTR_SIZE;
			break;
			//MUL
		case 6:
			reg[instrSet->opd1] = reg[instrSet->opd1] * reg[instrSet->opd2];
			PC += INSTR_SIZE;
			break;
			//DIV
		case 7:
			reg[instrSet->opd1] = reg[instrSet->opd1] / reg[instrSet->opd2];
			PC += INSTR_SIZE;
			break;
			//TRP
		case 8:
			if (instrSet->opd1 == 1)
				cout << reg[0];
			if (instrSet->opd1 == 3)
				cout << (char) reg[0];
			if (instrSet->opd1 == 0)
				running = false;
			PC += INSTR_SIZE;
			break;
			//STB direct / immediate mode
		case 9:
			MEM[instrSet->opd2] = reg[instrSet->opd1];
			PC += INSTR_SIZE;
			break;
			//STB register-indirect mode
		case 10:
			MEM[reg[instrSet->opd2]] = reg[instrSet->opd1];
			PC += INSTR_SIZE;
			break;
			//STR direct / immediate mode
		case 11:
			for (int i = 0; i < 4; i++)
			{
				a[i] = (reg[instrSet->opd1] >> (8 * i)) & 0xff;
				MEM[instrSet->opd2 + i] = a[i];
			}
			PC += INSTR_SIZE;
			break;
			//STR register-indirect mode
		case 12:
			for (int i = 0; i < 4; i++)
			{
				a[i] = (reg[instrSet->opd1] >> (8 * i)) & 0xff;
				MEM[reg[instrSet->opd2 + i]] = a[i];
			}
			PC += INSTR_SIZE;
			break;
			//JMP
		case 13:
			PC = instrSet->opd1;
			break;
			//JMR
		case 14:
			PC = reg[instrSet->opd1];
			break;
			//BNZ
		case 15:
			if (reg[instrSet->opd1] != 0)
			{
				PC = instrSet->opd2;
				break;
			}
			PC += INSTR_SIZE;
			break;
			//BGT
		case 16:
			if (reg[instrSet->opd1] > 0)
			{
				PC = instrSet->opd2;
				break;
			}
			PC += INSTR_SIZE;
			break;
			//BLT
		case 17:
			if (reg[instrSet->opd1] < 0)
			{
				PC = instrSet->opd2;
				break;
			}
			PC += INSTR_SIZE;
			break;
			//BRZ
		case 18:
			if (reg[instrSet->opd1] == 0)
			{
				PC = instrSet->opd2;
				break;
			}
			PC += INSTR_SIZE;
			break;
			//MOV
		case 19:
			reg[instrSet->opd1] = reg[instrSet->opd2];
			PC += INSTR_SIZE;
			break;
			//LDA
		case 20:
			{
				reg[instrSet->opd1] = instrSet->opd2;
				PC += INSTR_SIZE;
				break;
			   }
			//ADI
		case 21:
			reg[instrSet->opd1] += instrSet->opd2;
			PC += INSTR_SIZE;
			break;
			//AND
		case 22:
			if (reg[instrSet->opd1] == 1 && reg[instrSet->opd2] == 1)
				reg[instrSet->opd1] = 1; //true
			else
				reg[instrSet->opd1] = 0; //false
			break;
			//OR
		case 23:
			if (reg[instrSet->opd1] == 0 && reg[instrSet->opd2] == 0)
				reg[instrSet->opd1] = 0; //false
			else
				reg[instrSet->opd1] = 1; //true
			break;
			//CMP
		case 24:
			if (reg[instrSet->opd1] == reg[instrSet->opd2])
				reg[instrSet->opd1] = 0;
			else if (reg[instrSet->opd1] > reg[instrSet->opd2])
				reg[instrSet->opd1] = 1;
			else
				reg[instrSet->opd1] = -1;
			PC += INSTR_SIZE;
			break;
		}
	}
}
bool aRegister(string token)
{
	//remove pesky comma
	if (char ch = token.back() == ',')
		token = token.substr(0, token.size() - 1);

	//check if defined register
	if (token == "R0" || token == "R1" || token == "R2" || token == "R3" || token == "R4" || token == "R5" || token == "R6" || token == "R7"
		|| token == "R8" || token == "R9")
		return true;
	else return false;
}
bool anInstruction(string token)
{
	//check if defined instruction
	if (token == "LDB" || token == "LDR" || token == "ADD" || token == "SUB" || token == "MUL" || token == "DIV"
		|| token == "JMP" || token == "JMR" || token == "BNZ" || token == "BGT" || token == "BLT"
		|| token == "BRZ" || token == "MOV" || token == "LDA" || token == "STR" || token == "STB"
		|| token == "ADI" || token == "AND" || token == "OR" || token == "CMP" || token == "TRP")
		return true;
	else return false;
}
bool aNumber(const std::string& s)
{
	return !s.empty() && s.find_first_not_of("0123456789") == std::string::npos;
}
