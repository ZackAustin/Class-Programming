#pragma once

#include "st.h"
#include "icgen.h"


struct staticDataItem
{
	std::string label;
	std::string type;
	std::string value;

	staticDataItem(std::string l, std::string t, std::string v) : label(l), type(t), value(v) {}

	friend std::ostream& operator<<(std::ostream& os, const staticDataItem* dataItem)
	{
		os << std::setw(25) << std::left << std::setfill (' ') << dataItem->label <<  std::setw(25) << std::left << std::setfill (' ')
		 << dataItem->type << std::setw(25) << std::left << std::setfill (' ') << dataItem->value << std::endl;

		return os;
	}
};

struct assemblyStatement
{
	std::string label;
	std::string instruction;
	std::string op1;
	std::string op2;
	std::string comment;

	assemblyStatement(std::string l, std::string i, std::string o1, std::string o2, std::string c) : label(l), instruction(i), op1(o1), op2(o2), comment(c){}

	friend std::ostream& operator<<(std::ostream& os, const assemblyStatement* dataItem)
	{
		std::string operands = dataItem->op1;
		if (dataItem->op2 != "")
			operands = operands + ", " + dataItem->op2;

		os << std::setw(ICGenerator::labelLength + 1) << std::left << std::setfill (' ') << dataItem->label << dataItem->instruction << " "
		 << std::setw(25) << std::left << std::setfill (' ') << operands << dataItem->comment << std::endl;

		return os;
	}
};


class TCGenerator
{
private:
	ST* st;
	ICGenerator* icgen;
	std::vector<staticDataItem*> staticDataStatements;
	std::vector<assemblyStatement*> assemblyStatements;
	std::string assemblyFileName;
	std::ofstream *ofs;
	int freeCounter;
	std::vector<std::string> scopes;
	int quadCounter;

	void writeStaticData();
	void writeStaticOverflow();
	void writeStaticUnderflow();
	void writeAssemblyStatements();
	void writeInitialRegisters();
	void writeAssemblyOverflow();
	void writeAssemblyUnderflow();
	void pushStatement(assemblyStatement*);
	void writeFile();
	std::vector<std::string> getLocation(std::string);
	std::string getData(quad*, bool, std::string, std::string, std::string);
	void storeData(std::string, std::string, std::string, std::string, bool);

	//Instructions
	void writeFrame(quad*);
	void writeCall(quad*);
	void writePush(quad*);
	void writeFunc(quad*);
	void writeRTN(quad*);
	void writeReturn(quad*);
	void writePeek(quad*);
	void writeWrite(quad*);
	void writeRead(quad*);
	void writeMov(quad*);
	void writeAdd(quad*);
	void writeSub(quad*);
	void writeMul(quad*);
	void writeDiv(quad*);
	void writeControlStatement(quad*);
	void writeEquality(quad*, std::string);
	void writeLessThan(quad*, std::string);
	void writeGreaterThan(quad*, std::string);
	void writeNotEqual(quad*, std::string);
	void writeLessThanEqual(quad*, std::string, std::string, std::string);
	void writeGreaterThanEqual(quad*, std::string, std::string, std::string);
	void writeBranchFalse(quad*);
	void writeJump(quad*);
	void writeLogicalAnd(quad*);
	void writeLogicalOr(quad*);
	void writeItoA(quad*);
	void writeNewI(quad*);
	void writeNew(quad*);
	void writeRef(quad*);
	void writeAEF(quad*);
public:
	TCGenerator(ST*, ICGenerator*, std::string);
};