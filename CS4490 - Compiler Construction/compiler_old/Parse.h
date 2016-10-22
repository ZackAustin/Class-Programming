#include "Scanner.h"

#pragma once
class Parse
{
public:
	Parse(Scanner* ct);
	~Parse(void);
	Scanner* ct;
	void statement();
	void expression();
	void expressionz();
	void genError(std::string expected);
	void assignment_expression();
};

