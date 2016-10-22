#pragma once

#include <vector>
#include <string>
#include "dbgArgs.h"
#include "sas.h"

struct Operator
{
	std::string operatorLexem;
	int precedence;
	Operator(std::string s, int p) : operatorLexem(s), precedence(p)
	{

	}

	std::ostream& print(std::ostream& os)
	{
		os << this;
		return os;
	}

	friend std::ostream& operator<< (std::ostream& os, const Operator* op)
	{
		os << op->operatorLexem;
		return os;
	}
};

class OS
{
	compilerArgs* argumentList;
public:
	std::vector<Operator*> os;
	OS(compilerArgs*);
	~OS();
	bool opush(std::string);
	Operator* pop();
	void evaluateOperation(Operator*);
	int getPrecedence(std::string);
	bool checkPrecedence(const Operator*);
};

