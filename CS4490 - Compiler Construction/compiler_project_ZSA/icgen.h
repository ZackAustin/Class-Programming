#pragma once
#include <string>
#include <iostream>
#include <vector>
#include <iomanip>
#include "scanner.h"

struct quad
{
	std::string label;
	std::string instruction;
	std::string op1;
	std::string op2;
	std::string op3;
	std::string comment;
	int lineNumber;

	quad(std::string lbl, std::string instr, std::string o1, std::string o2, std::string o3, std::string comm, int ln)
	 : label(lbl), instruction(instr), op1(o1), op2(o2), op3(o3), comment(comm), lineNumber(ln) {}

	 ~quad(){}

	friend std::ostream& operator<<(std::ostream& os, const quad* quad)
	{
		std::string colonIfLabel = "";
		if (quad->label != "")
			colonIfLabel = ":";

		std::string firstComma = "";
		if (quad->op2 != "")
			firstComma = ", ";

		std::string secondComma = "";
		if (quad->op3 != "")
			secondComma = ", ";

		std::string semiIfComment = "";

		if (quad->comment != "")
			semiIfComment += "\t; ";

		if (quad->lineNumber != 0)
			os << std::endl << "Line " << quad->lineNumber << " :\n" << std::endl;

		std::string quadLabel = "    " + quad->label + colonIfLabel;

		std::string quadStatement = quad->instruction + " " + quad->op1 + firstComma + quad->op2 + secondComma + quad->op3;

		std::string quadComment = semiIfComment + quad->comment;

		os << std::setw(25) << std::left << std::setfill (' ') << quadLabel <<  std::setw(25) << std::left << std::setfill (' ')
		 << quadStatement << std::setw(25) << std::left << std::setfill (' ') << quadComment << std::endl;

		return os;
	}
};

class ICGenerator
{
public:
	std::vector<quad*> quads;
	int quadCounter;
	int lineNumber;
	Scanner* ct;
	static int labelLength;

	ICGenerator(Scanner*);

	void insert(std::string, std::string, std::string, std::string, std::string, std::string);
	void push(quad*);
	void copyQuad(quad*);
	void update(std::string, std::string, std::string, std::string, std::string, std::string, int);
	void backpatch(std::string, std::string, int);

	friend std::ostream& operator<<(std::ostream& os, const ICGenerator* icg)
	{
		os << std::endl << "size: " << icg->quads.size() << std::endl;

		for (auto it = icg->quads.begin(); it != icg->quads.end(); ++it)
		{
  			os << *it;
		}
		return os;
	}
};