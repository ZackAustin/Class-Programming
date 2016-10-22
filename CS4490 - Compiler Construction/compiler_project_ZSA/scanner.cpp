#include <regex>
#include <iomanip>
#include "scanner.h"

Scanner::Scanner(compilerArgs* debug) : argumentList(debug)
{
	lineNumber = 1;

    ss << lineNumber;

	argumentList->debugPrint(*argumentList, argumentList->debugging);
	argumentList->debugPrint(std::string{"\nLine " + ss.str() + " :\n\n"}, argumentList->showLineNumbers);

	token = new Token("1", "1");
	peekToken = new Token("2", "2");
	seekpos = 0, failCount = 0, tokenCount = 0, tmp = 0;
	peeking = false;
	kxiFile.open(argumentList->getFileName(), std::ios::binary);

	if (!kxiFile.is_open() || !kxiFile)  // Did the open work?
		throw std::runtime_error("Could Not Open File: " + argumentList->getFileName());
}

void Scanner::nextToken()
{
	std::string tmpLexem = "";
	std::string tmpType = "Unknown";

	//grab tokens until it isn't a space or newline or a comment.
	spaceChecking();

	bool grabbingTokens = true;
	tmpLexem += kxiFile.get();
	char c = tmpLexem.at(0);

	//grab a token see if it matches a letter(start of an identifier), if so while loop until not letter or number.
	if (aLetter(c))
		tmpType = "Identifier";
	else grabbingTokens = false;

	while (grabbingTokens && tmpLexem.size() < 90)
	{
		char filePeeker = kxiFile.peek();
		//numbers or letters
		if (aLetter(filePeeker) || aNumber(filePeeker) || filePeeker == 95)
			tmpLexem += kxiFile.get();
		else grabbingTokens = false;
	}

	//check if token is non-singular and not an identifier
	if (possibleDualSymbol(tmpLexem.at(0)))
	{
		char peekChar2 = kxiFile.peek();
		if (secondSymbol(peekChar2))
			tmpLexem += kxiFile.get();
	}

	if (aCharacter(tmpLexem.at(0)) && tmpType == "Unknown")
		tmpType = "Character";

	//check if token matches a keyword

	if (aKeyword(tmpLexem))
		tmpType = "Keyword";

	//otherwise the token is a single-character token, no loops, match it with something.

	else if (aNumber(tmpLexem.at(0)))
		tmpType = "Number";

	else if (punctuation(tmpLexem.at(0)))
		tmpType = "Punctuation";

	else if (tmpLexem.at(0) == 61 && tmpLexem.size() == 1)
		tmpType = "Assignment Operator";

	else if (logicalOperator(tmpLexem.at(0), tmpLexem))
		tmpType = "Logical Operator";

	else if (booleanOperator(tmpLexem.at(0), tmpLexem))
		tmpType = "Boolean Operator";

	else if (mathOperator(tmpLexem.at(0)))
		tmpType = "Math Operator";

	else if (tmpLexem.at(0) == 92)
		tmpType = "BackSlash";

	else if (arrayBracket(tmpLexem.at(0)))
		tmpType = "Array Bracket";

	else if (blockBracket(tmpLexem.at(0)))
		tmpType = "Block Bracket";

	else if (parenthesis(tmpLexem.at(0)))
		tmpType = "Parenthesis";

	else if (tmpLexem.at(0) == -1)
		tmpType = "EOF";

	if (tmpLexem.size() == 1 && (tmpLexem.at(0) == '<' || tmpLexem.at(0) == '>'))
	{
		char consolePeek = kxiFile.peek();
		if (consolePeek == '<')
		{
			tmpLexem += kxiFile.get();
			tmpType = "Left Shift Operator";
		}
		else if (consolePeek == '>')
		{
			tmpLexem += kxiFile.get();
			tmpType = "Right Shift Operator";
		}
	}

	delete token;
	token = new Token(tmpLexem, tmpType);

	if (!peeking)
		argumentList->debugPrint(*token, argumentList->debuggingLexer);
}

void Scanner::peek(int n)
{
	peeking = true;
	//set a temp equal to the current token to reset current later.
	auto theCurrentToken = new Token(token->lexem, token->tokenType);

	//save the file seek position before calling next token.
	seekpos = kxiFile.tellg();

	bool stillGoing = true;
	while (kxiFile && stillGoing)
	{
		//call next token to set current token.
		nextToken();

		if (n-- <= 1)
			stillGoing = false;
	}

	//set a second temp equal to the current token.
	auto thePeekedToken = new Token(token->lexem, token->tokenType);

	if (peekToken != nullptr)
		delete peekToken;

	peekToken = thePeekedToken;

	//reset current token to the first temp.
	token = theCurrentToken;

	//reset file seek position before the peek.
	if (seekpos != -1)
		kxiFile.seekg(seekpos);

	peeking = false;
}

bool Scanner::aLetter(char c)
{
	if ((c >= 65 && c <= 90) || (c >= 97 && c <= 122))
		return true;
	else return false;
}

bool Scanner::aNumber(char c)
{
	if (c >= 48 && c <= 57)
		return true;
	else return false;
}

bool Scanner::whiteSpace(char c)
{
	if (c == 32 ||c == 10 || c == 13 || c == 9)
		return true;
	else return false;
}

bool Scanner::aKeyword(std::string s)
{
	if (s == "atoi" || s == "bool" || s == "class" || s == "char" || s == "cin" || s == "cout"
		|| s == "else" || s == "false"  || s == "if"  || s == "int" || s == "itoa" || s == "main"
		|| s ==  "new" || s == "null"  || s == "object" ||  s == "public" || s == "private" 
		|| s == "return" || s == "string" || s == "this"  || s == "true" || s == "void" 
		|| s == "while" || s == "spawn" || s == "lock" || s == "release" || s == "block" 
		|| s == "sym" || s == "kxi2015" || s == "protected" || s == "unprotected" || s == "StaticInit")
		return true;
	else return false;
}

bool Scanner::aCharacter(char c)
{
	if (c >= 0 && c <= 127)
		return true;
	else return false;
}

bool Scanner::punctuation(char c)
{
	if (c == 39 || c == 44 || c == 46 || c == 58 || c == 59)
		return true;
	else return false;
}

bool Scanner::mathOperator(char c)
{
	if (c == 42 || c == 43 || c == 45 || c == 47)
		return true;
	else return false;
}

bool Scanner::booleanOperator(char c, std::string s)
{
	if (c == 61 && s.size() == 1)
		return false;
	else if ((c == 61 || c == 33 || c == 60 || c == 62) && s.size() > 1)
		return true;
	else return false;
}

bool Scanner::logicalOperator(char c, std::string s)
{
	if ((c == 38 || c == 124) && s.size() > 1)
		return true;
	else return false;
}

bool Scanner::possibleDualSymbol(char c)
{
	if (c == 38 || c == 124 || c == 60 || c == 62 || c == 61 || c == 33)
		return true;
	else return false;
}

bool Scanner::secondSymbol(char c)
{
	if (c == 38 || c == 124 || c == 61)
		return true;
	else return false;
}

bool Scanner::arrayBracket(char c)
{
	if (c == 91 || c == 93)
		return true;
	else return false;
}

bool Scanner::blockBracket(char c)
{
	if (c == 123 || c == 125)
		return true;
	else return false;
}

bool Scanner::parenthesis(char c)
{
	if (c == 40 || c == 41)
		return true;
	else return false;
}

void Scanner::spaceChecking()
{
	bool tokenNotReady = true;

	char initPeek = kxiFile.peek();
	if (whiteSpace(initPeek))
		tokenNotReady = true;
	else tokenNotReady = false;
			
	while (tokenNotReady)
	{
		char worthlessChar = kxiFile.get();

		if (worthlessChar == '\n')
		{
			lineNumber++;
			ss.str(std::string());
			ss << lineNumber;
			argumentList->debugPrint(std::string{"\nLine " + ss.str() + " :\n\n"}, argumentList->showLineNumbers);
		}
		initPeek = kxiFile.peek();

		if (whiteSpace(initPeek))
			tokenNotReady = true;
		else tokenNotReady = false;
	}

	//save the file seek position before calling next token incase it isn't a comment line.
	std::streamoff seekposition = kxiFile.tellg();

	char c = kxiFile.get();
	if (c == '/')
	{
		char c2 = kxiFile.get();
		if (c2 == '/')
		{
			while (c != '\n')
			{
				c = kxiFile.get();
			}

			if (c == '\n')
			{
				lineNumber++;
				ss.str(std::string());
				ss << lineNumber;
				argumentList->debugPrint(std::string{"\nLine " + ss.str() + " :\n\n"}, argumentList->showLineNumbers);
			}
			bool tokenNotReady2 = true;

			char initPeek2 = kxiFile.peek();
			if (whiteSpace(initPeek2))
				tokenNotReady2 = true;
			else tokenNotReady2 = false;
			
			while (tokenNotReady2)
			{
				char worthlessChar2 = kxiFile.get();

				if (worthlessChar2 == '\n')
				{
					lineNumber++;
					ss.str(std::string());
					ss << lineNumber;
					argumentList->debugPrint(std::string{"\nLine " + ss.str() + " :\n\n"}, argumentList->showLineNumbers);
				}
				initPeek2 = kxiFile.peek();

				if (whiteSpace(initPeek2))
					tokenNotReady2 = true;
				else tokenNotReady2 = false;
			}

			char c3 = kxiFile.peek();
			if (c3 == '/')
			{
				spaceChecking();
			}

		}//not a comment line, reset the seekpos.
		else
		{
			kxiFile.seekg(seekposition);
		}
	}
	else
	{
		kxiFile.seekg(seekposition);
	}
}

void Scanner::resetFileState()
{
	lineNumber = 1;
	kxiFile.clear();
	kxiFile.seekg(0);
}