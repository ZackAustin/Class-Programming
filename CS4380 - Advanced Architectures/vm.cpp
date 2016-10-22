// Name:		Zack Austin
// Date:		11/8/13
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

using namespace std;
const int MEMORY_SIZE = 3146000; //3 Megabytes.
const int INSTR_SIZE = 12, REG_SIZE = 15, INT_SIZE = 4 ,CHAR_SIZE = 1, SL = 10, SP = 11, FP = 12, SB = 13, PC = 14;
const int TS = 5000;
const int MEM_SB = 3146000, WORD_SIZE = 4;
const int MEM_SL = MEMORY_SIZE / 3; //stack limit is mem address of 1 megabyte. aka 2 megabyte run time stack.

int endian();
int assemblerPass1(ifstream &assemblyFile, int& instrCounter, vector<int32_t>& reg, map<string, int32_t> &ST);
int assemblerPass2(ifstream &assemblyFile, int& instrCounter, vector<int32_t>& reg, vector<unsigned char> &MEM, map<string, int32_t> &ST, int &beginningAddress);
void genByteCode(vector<string> &tokens, vector<unsigned char> &MEM, map<string, int32_t> symbol, vector<int32_t>& reg, int iVal);
void bigSwitch(vector<unsigned char> &MEM, vector<int32_t> &reg);
bool aRegister(string token);
bool anInstruction(string token);
bool aNumber(const std::string& s);
int registerNumber(string registerName);
void writeIntToMem(int &temp, vector<unsigned char> &MEM, vector<int32_t>& reg);
void writeByteToMem(vector<unsigned char> &MEM, vector<int32_t>& reg, vector<string> &tokens, int &position);

//ByteCode.
struct Bytecode
{
	int32_t opcode;
	int32_t opd1;
	int32_t opd2;
} instrSet;
int main(int argc, char* argv [])
{
	argc = 2;
	//Memory Layout.
	std::vector<unsigned char> MEM(MEMORY_SIZE);
	//Symbol Table.
	std::map<string, int32_t> symbolTable;
	//Initialize Registers.
	std::vector<int32_t> reg(REG_SIZE);
	
	//64..amount of space for all 15 registers at bottom of main TS.
	reg[SP] = MEMORY_SIZE - 64; //stack pointer initialized to end of memory.
	reg[SB] = MEMORY_SIZE - 64; //stack base end of memory.
	reg[SL] = reg[SB] - TS;

	//Assembler Pass 1. Open file, create symbol table(a map).
	//	Read Assembly Source File
	ifstream assemblyFile;
	if (argc > 1)
	{
		//assemblyFile.open("proj4.asm", ios::binary);
		assemblyFile.open(argv[1], ios::binary);
		if (!assemblyFile.is_open() || !assemblyFile)  // Did the open work?
		{
			cout << "Can't open file for input!\n";
			return 1;
		}

		int instrCounter = 1, success = -1;
		reg[PC] = 0;
		success = assemblerPass1(assemblyFile, instrCounter, reg, symbolTable);
		if (success == 1)
			return 1;
		assemblyFile.close();

		//Finished Assembler Pass 1 - Labels are loaded in to Symbol Table.
		//Next is 2nd Pass where we check and make sure these instructions and labels are correct
		//for the assembly language.

		//Assembler Pass 2
		//assemblyFile.open("proj4.asm", ios::binary);
		assemblyFile.open(argv[1], ios::binary);
		if (!assemblyFile.is_open() || !assemblyFile)  // Did the open work?
		{
			cout << "Can't open file for input!\n";
			return 1;
		}

		instrCounter = 1, reg[PC] = 0;
		bool firstInstruction = true;
		int beginningAddress = 0;
		success = assemblerPass2(assemblyFile, instrCounter, reg, MEM, symbolTable, beginningAddress);
		if (success == 1)
			return 1;
		assemblyFile.close();

		//Finished Assembler Pass 2 - Labels are referenced in Symbol Table and bytecode loaded into MEM.
		//Now Virtual Machine
		//The Big Switch(VM)
		reg[PC] = beginningAddress;
		bigSwitch(MEM, reg);
	}
	return 0;
}
int assemblerPass1(ifstream &assemblyFile, int& instrCounter, vector<int32_t>& reg, map<string, int32_t> &ST)
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
				reg[PC] += CHAR_SIZE;
			else if (tokens[0] == ".INT")
				reg[PC] += INT_SIZE;
		}
		else if (anInstruction(tokens[0]))
		{
			if (tokens[1].size() > 0)
			{
				if (aRegister(tokens[1]))
				{
					if (tokens[3].size() > 0)
					if (tokens[3].at(0) == ';') {}
				}
			}
			instrCounter += 1;
			reg[PC] += INSTR_SIZE;
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
				ST.insert(std::pair<string, int32_t>(tokens[0], reg[PC]));
				instrCounter += 1;
				if (tokens[1] == ".BYT")
					reg[PC] += CHAR_SIZE;
				else if (tokens[1] == ".INT")
					reg[PC] += INT_SIZE;
			}
			else if (anInstruction(tokens[1]))
			{
				if (tokens[2].size() > 0)
				{
					if (aRegister(tokens[2]))
					{
						if (tokens[4].size() > 0)
						if (tokens[4].at(0) == ';') {}
					}
				}
				ST.insert(std::pair<string, int32_t>(tokens[0], reg[PC]));
				instrCounter += 1;
				reg[PC] += INSTR_SIZE;
			}
			else
			{
				//Check for comment line
				if (tokens[0].size() > 0)
				{
					if (tokens[0].at(0) == ';'){ instrCounter++; }
					else
					{
						ST.insert(std::pair<string, int32_t>(tokens[0], reg[PC]));
						instrCounter++;
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
int assemblerPass2(ifstream &assemblyFile, int& instrCounter, vector<int32_t>& reg, vector<unsigned char> &MEM, map<string, int32_t> &ST, int &beginningAddress)
{
	string aLine, buf;
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
		int iVal = 0, tempOpCode = -1;
		//Check blank line
		if (tokens[0] == "") { instrCounter += 1; }
		else if (tokens[0] == ".BYT")
		{
			//no semantics check for directives.
			//load value into memory
			int position = 1;
			writeByteToMem(MEM, reg, tokens, position);
			reg[PC] += CHAR_SIZE;
			instrCounter++;
		}
		else if (tokens[0] == ".INT")
		{
			//no semantics check for directives.
			//load value into memory
			int32_t temp = atoi(tokens[1].c_str());
			writeIntToMem(temp, MEM, reg);
			reg[PC] += INT_SIZE;
			instrCounter++;
		}
		else if (anInstruction(tokens[0]))
		{
			//Check Semantics
			std::map<string, int32_t>::iterator it = ST.find(tokens[2]);
			if (tokens[2].size() > 0)
			{
				if (tokens[2].at(0) == ';'){}
				else if (it == ST.end() && !aRegister(tokens[2]) && !aNumber(tokens[2]))
				{
					cout << "Semantics Error on Line " << instrCounter << ": " << tokens[0] << " Instruction - Label not in Table.\n";
					return 1;
				}
			}
			if (firstInstruction)
			{
				beginningAddress = reg[PC];
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
			else if (tokens[0] == "RUN")
				tempOpCode = 25;
			else if (tokens[0] == "END")
				tempOpCode = 26;
			else if (tokens[0] == "BLK")
				tempOpCode = 27;
			else if (tokens[0] == "LCK")
				tempOpCode = 28;
			else if (tokens[0] == "ULK")
				tempOpCode = 29;

			//Generate Byte Code. Fixed Length of 3 ints (12 bytes). [opcode.opd1.opd2]
			MEM[reg[PC]] = tempOpCode;
			reg[PC] += INT_SIZE;
			genByteCode(tokens, MEM, ST, reg, iVal);
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
				int position = 2;
				writeByteToMem(MEM, reg, tokens, position);
				reg[PC] += CHAR_SIZE;
				instrCounter++;
			}
			else if (tokens[1] == ".INT")
			{
				//no semantics check for directives.
				//load value into memory
				int32_t temp = atoi(tokens[2].c_str());
				writeIntToMem(temp, MEM, reg);
				reg[PC] += INT_SIZE;
				instrCounter++;
			}
			else if (anInstruction(tokens[1]))
			{
				//Check Semantics
				std::map<string, int32_t>::iterator it = ST.find(tokens[3]);
				if (tokens[3].size() > 0)
				{
					if (tokens[3].at(0) == ';'){}
					else if (it == ST.end() && !aRegister(tokens[3]) && !aNumber(tokens[3]))
					{
						cout << "Semantics Error on Line " << instrCounter << ": " << tokens[1] << " Instruction - Label not in Table.\n";
						return 1;
					}
				}
				if (firstInstruction)
				{
					beginningAddress = reg[PC];
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
				else if (tokens[1] == "RUN")
					tempOpCode = 25;
				else if (tokens[1] == "END")
					tempOpCode = 26;
				else if (tokens[1] == "BLK")
					tempOpCode = 27;
				else if (tokens[1] == "LCK")
					tempOpCode = 28;
				else if (tokens[1] == "ULK")
					tempOpCode = 29;

				//Generate Byte Code. Fixed Length of 3 ints (12 bytes). [opcode.opd1.opd2]
				MEM[reg[PC]] = tempOpCode;
				reg[PC] += INT_SIZE;
				genByteCode(tokens, MEM, ST, reg, iVal);
				instrCounter++;
			}
			else
				instrCounter++;
		}
	}
	return 0;
}
void genByteCode(vector<string> &tokens, vector<unsigned char> &MEM, map<string, int32_t> symbol, vector<int> &reg, int iVal)
{
	//opd1 register or label(JMP)
	//if label
	std::map<string, int32_t>::iterator itop1 = symbol.find(tokens[iVal + 1]);
	if (itop1 != symbol.end())
	{
		int32_t temp = itop1->second;
		writeIntToMem(temp, MEM, reg);
	}
	else
	{
		int32_t temp = 0;
		//a register or immediate value, or no-op
		if (tokens[iVal + 1].size() > 0)
		{
			temp = registerNumber(tokens[iVal + 1]);
		}
		writeIntToMem(temp, MEM, reg);
	}
	reg[PC] += INT_SIZE;
	//opd2 label or register
	//if label
	std::map<string, int32_t>::iterator itop2 = symbol.find(tokens[iVal + 2]);
	if (itop2 != symbol.end())
	{
		int32_t temp = itop2->second;
		writeIntToMem(temp, MEM, reg);
	}
	else
	{
		int32_t temp = 0;
		//a register or immediate value
		if (tokens[iVal + 2].size() > 0)
		{
			temp = registerNumber(tokens[iVal + 2]);
		}
		writeIntToMem(temp, MEM, reg);
	}
	reg[PC] += INT_SIZE;
}
void bigSwitch(vector<unsigned char> &MEM, vector<int32_t> &reg)
{
	//vector for threads, setup initial main thread and runtime stack.
	vector<int> threads;
	threads.push_back(threads.size()); //pushback, vector is existance of certain thread.
	int currentTID = 0;	//will be used for TID.

	bool running = true;
	while (running)
	{
		int TSloc;
		//context switching between threads
		//store registers of the current thread.
			//PC = reg[PC] (14).
			//first locate TS:
		if (threads[currentTID] >= 0)
			TSloc = MEM_SB - (TS * threads[currentTID]) - WORD_SIZE;
		else
			TSloc = MEM_SB - (TS * currentTID) - WORD_SIZE;
			//store registers:
		for (int i = 0; i < reg.size(); i++)
		{
			char a[4];
			for (int j = 0; j < 4; j++)
			{
				a[j] = (reg[reg.size() - (i + 1)] >> (8 * j)) & 0xff;
				MEM[TSloc + j] = a[j];
			}
			TSloc -= WORD_SIZE; //pointing at top of TS
		}

		bool nextThread = true;
		//round robin,
		while (nextThread)
		{
			currentTID++;
			nextThread = false;
			if (currentTID >= threads.size())
				currentTID = 0;
			if (threads[currentTID] < 0)
			{
				for (int i = 0; i < threads.size(); i++)
				{
					if (threads[i] >= 0)
						nextThread = true;
				}
				if (nextThread == false)
				{
					threads[0] = 0;
					currentTID = 0;
					int somesize = threads.size();
					for (int z = 1; z < somesize; z++) //, erase all threads
						threads.erase(threads.begin() + 1);
				}
			}	
		}

		//load registers for new thread
		//find TS for new thread:
		TSloc = MEM_SB - (TS * threads[currentTID]) - WORD_SIZE;
		//load registers:
		for (int i = 0; i < reg.size(); i++)
		{
			reg[reg.size() - (i + 1)] = *(int32_t*) &MEM[TSloc];
			TSloc -= WORD_SIZE; //pointing at top of TS
		}
		
		//run this round robin style.
		int instructionsRun = 2;
		for (int instrNumber = 0; instrNumber < instructionsRun; instrNumber++)
		{
			if (threads[currentTID] >= 0)
			{
				char a[4];
				Bytecode *instrSet = (Bytecode*) (&MEM[reg[PC]]);
				switch (instrSet->opcode)
				{
					//LDB immediate / direct mode
				case 0:
					reg[instrSet->opd1] = MEM[instrSet->opd2];
					reg[PC] += INSTR_SIZE;
					break;
					//LDB register-indirect mode
				case 1:
					reg[instrSet->opd1] = MEM[reg[instrSet->opd2]];
					reg[PC] += INSTR_SIZE;
					break;
					//LDR immediate / direct mode
				case 2:
					reg[instrSet->opd1] = *(int32_t*) &MEM[instrSet->opd2];
					reg[PC] += INSTR_SIZE;
					break;
					//LDR register-indirect mode
				case 3:
					reg[instrSet->opd1] = *(int32_t*) &MEM[reg[instrSet->opd2]];
					reg[PC] += INSTR_SIZE;
					break;
					//ADD
				case 4:
					reg[instrSet->opd1] = reg[instrSet->opd1] + reg[instrSet->opd2];
					reg[PC] += INSTR_SIZE;
					break;
					//SUB
				case 5:
					reg[instrSet->opd1] = reg[instrSet->opd1] - reg[instrSet->opd2];
					reg[PC] += INSTR_SIZE;
					break;
					//MUL
				case 6:
					reg[instrSet->opd1] = reg[instrSet->opd1] * reg[instrSet->opd2];
					reg[PC] += INSTR_SIZE;
					break;
					//DIV
				case 7:
					reg[instrSet->opd1] = reg[instrSet->opd1] / reg[instrSet->opd2];
					reg[PC] += INSTR_SIZE;
					break;
					//TRP, all work with R0.
				case 8:
					if (instrSet->opd1 == 0)
					{
						running = false;
						instrNumber = 2;
					}
					else if (instrSet->opd1 == 1) //output int
						cout << reg[0];
					else if (instrSet->opd1 == 2) //read an int
					{
						bool failed = true;
						while (failed)
						{
							int i;
							string text;
							getline(cin, text);
							text = text.substr(text.find_first_not_of(" \t"));
							text = text.substr(0, text.find_last_not_of(" \t\n") + 1);
							stringstream convert(text);
							if (convert >> i && convert.eof())
							{
								failed = false;
								reg[0] = i;
							}
							else
								cout << "Enter an integer, try again: ";
						}
					}
					else if (instrSet->opd1 == 3) //output char
						cout << (char) reg[0];
					else if (instrSet->opd1 == 4) //getchar
						reg[0] = getchar();
					else if (instrSet->opd1 == 10) //char to int
					{
						if (reg[0] >= 48 && reg[0] <= 57)
							reg[0] -= '0';
						else
							reg[0] = -1;
					}
					else if (instrSet->opd1 == 11) //int to char
					{
						if (reg[0] >= 0 && reg[0] <= 9)
							reg[0] += '0';
						else
							reg[0] = -1;
					}
					else if (instrSet->opd1 == 99) //debug mode
					{/*not doing stuff for debug*/ cout << "";
					}
					reg[PC] += INSTR_SIZE;
					break;
					//STB direct / immediate mode
				case 9:
					MEM[instrSet->opd2] = reg[instrSet->opd1];
					reg[PC] += INSTR_SIZE;
					break;
					//STB register-indirect mode
				case 10:
					MEM[reg[instrSet->opd2]] = reg[instrSet->opd1];
					reg[PC] += INSTR_SIZE;
					break;
					//STR direct / immediate mode
				case 11:
					for (int i = 0; i < 4; i++)
					{
						a[i] = (reg[instrSet->opd1] >> (8 * i)) & 0xff;
						MEM[instrSet->opd2 + i] = a[i];
					}
					reg[PC] += INSTR_SIZE;
					break;
					//STR register-indirect mode
				case 12:
					for (int i = 0; i < 4; i++)
					{
						a[i] = (reg[instrSet->opd1] >> (8 * i)) & 0xff;
						MEM[reg[instrSet->opd2] + i] = a[i];
					}
					reg[PC] += INSTR_SIZE;
					break;
					//JMP
				case 13:
					reg[PC] = instrSet->opd1;
					break;
					//JMR
				case 14:
					reg[PC] = reg[instrSet->opd1];
					break;
					//BNZ
				case 15:
					if (reg[instrSet->opd1] != 0)
					{
						reg[PC] = instrSet->opd2;
						break;
					}
					reg[PC] += INSTR_SIZE;
					break;
					//BGT
				case 16:
					if (reg[instrSet->opd1] > 0)
					{
						reg[PC] = instrSet->opd2;
						break;
					}
					reg[PC] += INSTR_SIZE;
					break;
					//BLT
				case 17:
					if (reg[instrSet->opd1] < 0)
					{
						reg[PC] = instrSet->opd2;
						break;
					}
					reg[PC] += INSTR_SIZE;
					break;
					//BRZ
				case 18:
					if (reg[instrSet->opd1] == 0)
					{
						reg[PC] = instrSet->opd2;
						break;
					}
					reg[PC] += INSTR_SIZE;
					break;
					//MOV
				case 19:
					reg[instrSet->opd1] = reg[instrSet->opd2];
					reg[PC] += INSTR_SIZE;
					break;
					//LDA
				case 20:
					{
						reg[instrSet->opd1] = instrSet->opd2;
						reg[PC] += INSTR_SIZE;
						break;
					   }
					//ADI
				case 21:
					reg[instrSet->opd1] += instrSet->opd2;
					reg[PC] += INSTR_SIZE;
					break;
					//AND
				case 22:
					if (reg[instrSet->opd1] == 0 && reg[instrSet->opd2] == 0)
						reg[instrSet->opd1] = 0; //true
					else
						reg[instrSet->opd1] = 1; //false
					reg[PC] += INSTR_SIZE;
					break;
					//OR
				case 23:
					if (reg[instrSet->opd1] == 0 || reg[instrSet->opd2] == 0)
						reg[instrSet->opd1] = 0; //true
					else
						reg[instrSet->opd1] = 1; //false
					reg[PC] += INSTR_SIZE;
					break;
					//CMP
				case 24:
					if (reg[instrSet->opd1] == reg[instrSet->opd2])
						reg[instrSet->opd1] = 0;
					else if (reg[instrSet->opd1] > reg[instrSet->opd2])
						reg[instrSet->opd1] = 1;
					else
						reg[instrSet->opd1] = -1;
					reg[PC] += INSTR_SIZE;
					break;
					//RUN
				case 25:
					try
					{
						if (threads.size() < 6)
						{
							int tmp = threads.size();
							threads.push_back(threads.size());
							reg[instrSet->opd1] = tmp;
							//label jumped to by newly created thread.
							int threadloc = MEM_SB - (TS * tmp) - WORD_SIZE;
							//find PC & store there
							int threadPC = instrSet->opd2;
							char a[4];
							for (int j = 0; j < 4; j++)
							{
								a[j] = (threadPC >> (8 * j)) & 0xff;
								MEM[threadloc + j] = a[j];
							}
							threadloc -= WORD_SIZE; //at reg[13] (SB) now
							int threadTopState = threadloc - 64;
							for (int j = 0; j < 4; j++)
							{
								a[j] = (threadTopState >> (8 * j)) & 0xff;
								MEM[threadloc + j] = a[j];
							}
							threadloc -= (WORD_SIZE * 2); //at reg[11] (SP) now

							for (int j = 0; j < 4; j++)
							{
								a[j] = (threadTopState >> (8 * j)) & 0xff;
								MEM[threadloc + j] = a[j];
							}

							threadloc -= WORD_SIZE; //at reg[10] (SL) now
							int tmpmemloc = threadloc;
							threadloc = MEM_SB - (TS * tmp) - (TS + WORD_SIZE);
							for (int j = 0; j < 4; j++)
							{
								a[j] = (threadloc >> (8 * j)) & 0xff;
								MEM[tmpmemloc + j] = a[j];
							}
							int theReg = instrSet->opd1;
							threadloc = MEM_SB - (TS * tmp) - WORD_SIZE; //at PC
							while (theReg < 14)
							{
								threadloc -= WORD_SIZE;
								theReg++;
							}
							//reg which is holding TID
							for (int j = 0; j < 4; j++)
							{
								a[j] = (tmp >> (8 * j)) & 0xff;
								MEM[threadloc + j] = a[j];
							}
						}
						else
							throw runtime_error("Cant instantiate anymore threads.");
					}
					catch (runtime_error& x) { cout << x.what() << endl; reg[instrSet->opd1] = -1; }
					instrNumber = instructionsRun;
					reg[PC] += INSTR_SIZE;
					break;
					//END
				case 26:
					if (currentTID != 0)
						threads[currentTID] = -1;
					instrNumber = instructionsRun;
					reg[PC] += INSTR_SIZE;
					break;
					//BLK
				case 27:
					if (currentTID == 0)
						threads[0] = -1;
					instrNumber = instructionsRun;
					reg[PC] += INSTR_SIZE;
					break;
					//LCK
				case 28:
					{
						int lckval = *(int32_t*) &MEM[instrSet->opd1];

						//try to place a lock
						if (lckval == -1 || lckval == threads[currentTID])
						{
							lckval = threads[currentTID];
							reg[PC] += INSTR_SIZE;

							//write lock to memory
							char a[4];
							for (int j = 0; j < 4; j++)
							{
								a[j] = (lckval >> (8 * j)) & 0xff;
								MEM[instrSet->opd1 + j] = a[j];
							}
							//reg[PC] += INSTR_SIZE;
						}
						instrNumber = instructionsRun;
						break;
					 }
					//ULK
				case 29:
					int unlockval = *(int32_t*) &MEM[instrSet->opd1];

					//try to unlock
					if (unlockval == -1 || unlockval == threads[currentTID])
					{
						unlockval = -1;

						//write lock to memory
						char a[4];
						for (int j = 0; j < 4; j++)
						{
							a[j] = (unlockval >> (8 * j)) & 0xff;
							MEM[instrSet->opd1 + j] = a[j];
						}
						reg[PC] += INSTR_SIZE;
					}
					instrNumber = instructionsRun;
					break;
				}
			}
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
		|| token == "R8" || token == "R9" || token == "SL" || token == "SP" || token == "FP" || token == "SB" || token == "PC")
		return true;
	else return false;
}
bool anInstruction(string token)
{
	//check if defined instruction
	if (token == "LDB" || token == "LDR" || token == "ADD" || token == "SUB" || token == "MUL" || token == "DIV"
		|| token == "JMP" || token == "JMR" || token == "BNZ" || token == "BGT" || token == "BLT"
		|| token == "BRZ" || token == "MOV" || token == "LDA" || token == "STR" || token == "STB"
		|| token == "ADI" || token == "AND" || token == "OR" || token == "CMP" || token == "TRP"
		|| token == "RUN" || token == "END" || token == "BLK" || token == "LCK" || token == "ULK")
		return true;
	else return false;
}
bool aNumber(const std::string& s)
{
	if (s.at(0) == '0' || s.at(0) == '1' || s.at(0) == '2' || s.at(0) == '3' || s.at(0) == '4' || s.at(0) == '5' || s.at(0) == '6'
		|| s.at(0) == '7' || s.at(0) == '8' || s.at(0) == '9')
		return !s.empty() && s.find_first_not_of("0123456789") == std::string::npos;
	else if (s.at(0) == '#' || s.at(0) == '+' || s.at(0) == '#')
		return !s.empty() && s.substr(1).find_first_not_of("0123456789") == std::string::npos;
}
int registerNumber(string registerName)
{
	int value = -1;
	//remove pesky comma
	if (char ch = registerName.back() == ',')
		registerName = registerName.substr(0, registerName.size() - 1);

	if (registerName == "R0")
		value = 0;
	else if (registerName == "R1")
		value = 1;
	else if (registerName == "R2")
		value = 2;
	else if (registerName == "R3")
		value = 3;
	else if (registerName == "R4")
		value = 4;
	else if (registerName == "R5")
		value = 5;
	else if (registerName == "R6")
		value = 6;
	else if (registerName == "R7")
		value = 7;
	else if (registerName == "R8")
		value = 8;
	else if (registerName == "R9")
		value = 9;
	else if (registerName == "SL")
		value = 10;
	else if (registerName == "SP")
		value = 11;
	else if (registerName == "FP")
		value = 12;
	else if (registerName == "SB")
		value = 13;
	else if (registerName == "PC")
		value = 14;
	else
	{
		//it's an immediate value
		//remove pesky #
		if (registerName.at(0) == '#')
			registerName = registerName.substr(0, registerName.size() - 1);
		if (aNumber(registerName))
		{
			value = atoi(registerName.c_str());
		}
	}
	return value;
}
void writeIntToMem(int &temp, vector<unsigned char> &MEM, vector<int32_t>& reg)
{
	char a[4];
	for (int i = 0; i < 4; i++)
	{
		a[i] = (temp >> (8 * i)) & 0xff;
		MEM[reg[PC] + i] = a[i];
	}
}
void writeByteToMem(vector<unsigned char> &MEM, vector<int32_t>& reg, vector<string> &tokens, int &position)
{
	if (tokens[position].at(0) == '\'')
		MEM[reg[PC]] = tokens[position].at(1);
	else if (tokens[position].at(0) >= 48 && tokens[position].at(0) <= 57)
	{
		std::stringstream ss;
		ss << std::hex << tokens[position];
		int temp;
		ss >> temp;
		MEM[reg[PC]] = temp;
	}
	else
	{
		std::stringstream ss;
		ss << std::hex << tokens[position];
		int temp;
		ss >> temp;
		MEM[reg[PC]] = temp;
	}
}