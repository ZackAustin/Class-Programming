#pragma once

#include <sstream>
#include "dbgArgs.h"

class Token
{
public:
	std::string lexem;
	std::string tokenType;

	Token(std::string initLexem, std::string initType) : lexem(initLexem), tokenType(initType){}
	~Token(){}

	friend std::ostream& operator<< (std::ostream& o, Token const& token)
	{
		o << "Lexem: " << token.lexem << std::endl;
		return o << "Type: " << token.tokenType << std::endl;
	}
};

class Scanner
{
private:
	bool debugMode;
	std::streamoff seekpos;
	char tmp;
	int failCount;
	int tokenCount;
public:
	std::ostringstream ss;
	bool peeking;
	Token* token;
	Token* peekToken;
	std::ifstream kxiFile;
	compilerArgs* argumentList;
	int lineNumber;

	Scanner(compilerArgs*);
	void nextToken();
	void peek(int n);
	int getFailRate(){ return failCount; }
	int getTokenCount(){ return tokenCount; }
	Token* getPeek() { return peekToken; }
	~Scanner(){delete token; delete peekToken; }
	void resetFileState();

	//operator bool() const{ return argumentList.debugging;}

	bool aLetter(char c);
	bool aNumber(char c);
	bool whiteSpace(char c);
	bool aKeyword(std::string s);
	bool aCharacter(char c);
	bool punctuation(char c);
	bool mathOperator(char c);
	bool booleanOperator(char c, std::string s);
	bool logicalOperator(char c, std::string s);
	bool possibleDualSymbol(char c);
	bool secondSymbol(char c);
	bool arrayBracket(char c);
	bool blockBracket(char c);
	bool parenthesis(char c);

	void spaceChecking();

	friend std::ostream& operator<< (std::ostream& o, Scanner const& scanner)
	{
		return o << "\nLexical Analysis:\n" << std::endl;
	}
};