#include "os.h"
#include <stdexcept>

OS::OS(compilerArgs* debug) : argumentList(debug)
{}

OS::~OS(){}

bool OS::opush(std::string operatorLexem)
{
	//only happens on SA #opush.
	int inputPrecedence = getPrecedence(operatorLexem);

	if (os.size() > 0)
	{
		if (os.back()->precedence < inputPrecedence)
		{
			os.push_back(new Operator(operatorLexem, getPrecedence(operatorLexem)));
			if (checkPrecedence(os.back()))
			{
				os.back()->precedence = -1;	
			}
			return true;
		}
		else
		{
			return false;
		}
	}
	else
	{
		os.push_back(new Operator(operatorLexem, inputPrecedence));
		if (checkPrecedence(os.back()))
		{
			os.back()->precedence = -1;
		}
		return true;
	}
}

Operator* OS::pop()
{
	Operator* o = nullptr;
	if (os.size() > 0)
	{
		o = os.back();
		os.pop_back();
	}
	else throw std::runtime_error("operator stack error: underflow");

	return o;
}

void OS::evaluateOperation(Operator* o)
{
	//try changing SA action Functions in Cl to statics and just calling them.
}

int OS::getPrecedence(std::string operatorLexem)
{
	int value = -1;
	if (operatorLexem == "." || operatorLexem == "(" || operatorLexem == "[")
		value = 15;
	else if (operatorLexem == ")" || operatorLexem == "]")
		value = 0;
	else if (operatorLexem == "*" || operatorLexem == "/" || operatorLexem == "%")
		value = 13;
	else if (operatorLexem == "+" || operatorLexem == "-")
		value = 11;
	else if (operatorLexem == "<" || operatorLexem == ">" || operatorLexem == "<=" || operatorLexem == ">=")
		value = 9;
	else if (operatorLexem == "==" || operatorLexem == "!=")
		value = 7;
	else if (operatorLexem == "&&")
		value = 5;
	else if (operatorLexem == "||")
		value = 3;
	else if (operatorLexem == "=")
		value = 1;
	return value;
}

bool OS::checkPrecedence(const Operator* o)
{
	if (o->operatorLexem == "." || o->operatorLexem == "(" || o->operatorLexem == "[")
		return true;
	else return false;
}
