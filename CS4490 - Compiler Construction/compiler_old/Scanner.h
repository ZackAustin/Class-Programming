#pragma once

#include <fstream>
#include <iostream>
#include <string>

class Token
{
private:
	std::string lexem;
	std::string tokenType;
public:
	Token(std::string initLexem, std::string initType) : lexem(initLexem), tokenType(initType){}
	std::string getLexem() { return lexem; }
	std::string getType() { return tokenType; }
	~Token(){}
};

class Scanner
{
private:
	std::ifstream kxiFile;
	Token* currentToken;
	Token* peekToken;
	bool debugMode;
	int lineNum;
	std::streamoff seekpos;
	char tmp;
	int failCount;
	int tokenCount;
public:
	Scanner(std::string kxi, bool debug);
	Token* getToken() { return currentToken; }
	void nextToken();
	Token* peek(int n);
	int getFailRate(){ return failCount; }
	int getTokenCount(){ return tokenCount; }
	Token* getPeek() { return peekToken; }
	int getLineNum() {return lineNum;}
	~Scanner(){delete currentToken; delete peekToken; }
	bool aSymbol(char t);
	bool aFileDelim(char t);
	bool nonDelimiter(char t);
};

