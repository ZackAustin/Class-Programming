#include "Scanner.h"
#include <regex>
#include <iomanip>

using namespace std;

//grammar
string comment = "[/][/]";
regex kxi_comment(comment);
string number = "[0-9]+";
regex kxi_number(number);
string character2 = "['][\\x20-\\x7e][']";
regex kxi_character2(character2);
string nonPrint = "['][\\x5c][abtnvfre0][']";
regex kxi_nonPrint(nonPrint);
string space = "['][\\x20][']";
regex kxi_space(space);
string charstart = "[']";
regex kxi_characterstart(charstart);
string identifier = "[a-zA-Z][a-zA-Z0-9\\-_]*";
regex kxi_identifier(identifier);
string assignmentOp = "[=]";
regex kxi_assignmentOp(assignmentOp);
string relationalOp = "[=><!]?[=]?";
regex kxi_relationalOp(relationalOp);
string punctuation = "[,;.]";
regex kxi_punctuation(punctuation);
regex kxi_atoi("atoi");
regex kxi_bool("bool");
regex kxi_class("class");
regex kxi_char("char");
regex kxi_cin("cin");
regex kxi_cout("cout");
regex kxi_else("else");
regex kxi_false("false");
regex kxi_if("if");
regex kxi_int("int");
regex kxi_itoa("itoa");
regex kxi_main("main");
regex kxi_new("new");
regex kxi_null("null");
regex kxi_object("object");
regex kxi_public("public");
regex kxi_private("private");
regex kxi_return("return");
regex kxi_string("string");
regex kxi_this("this");
regex kxi_true("true");
regex kxi_void("void");
regex kxi_while("while");

Scanner::Scanner(string kxi, bool debug)
{
	currentToken = new Token("1", "1");
	peekToken = new Token("2", "2");
	lineNum = 1, seekpos = 0, failCount = 0, tokenCount = 0, tmp = 0;
	kxiFile.open(kxi, ios::binary);
	if (!kxiFile.is_open() || !kxiFile)  // Did the open work?
	{
		throw runtime_error("Could Not Open File: " + kxi);
	}
}

void Scanner::nextToken()
{
	if (seekpos != -1)
		kxiFile.seekg(seekpos);

	delete currentToken;

	//i)Discards the current token, find the next token and makes it the current token.

	string tmpLexem;
	string tmpType = "Unknown";

	if (!kxiFile.eof())
	{
		while (kxiFile.good() && aFileDelim(tmp))
		{
			tmp = kxiFile.get();
			if (tmp == '\n')
			{
				lineNum++;
			}
		}

		if (!aFileDelim(tmp))
			tmpLexem += tmp;

		while (kxiFile.good() && nonDelimiter(tmp))
		{
				tmp = kxiFile.get();

			if (nonDelimiter(tmp))
			{
				tmpLexem += tmp;
			}

			//Character space - No strings in KXI.
			if (regex_match(tmpLexem, kxi_characterstart))
			{
				tmpLexem += tmp;
				if (kxiFile.peek() == '\'')
				{
					tmp = kxiFile.get();
					tmpLexem += tmp;
					if (regex_match(tmpLexem, kxi_space))
					{
						tmpType = "Character";
					}
				}
				else
				{
					if (aSymbol(tmp))
					{
						tmp = kxiFile.get();
					}
				}
			}
		}

		if (aSymbol(tmp))
		{
			if (tmpLexem.size() == 0)
				tmpLexem = 0 + tmp;
		}

			//Comment - Ignore rest of line.
			if (tmp == '/' && kxiFile.peek() == '/')
			{
				tmpLexem += tmp;
				while (kxiFile.good() && tmp != '\n')
				{
					tmp = kxiFile.get();
				}
				if (tmp == '\n')
				{
					lineNum++;
				}
				tmpType = "Comment";
			}

			//printable Character - No strings in KXI.
			if (regex_match(tmpLexem, kxi_character2))
			{
				tmpType = "Character";
			}

			//Nonprintable Character
			if (regex_match(tmpLexem, kxi_nonPrint))
			{
				tmpType = "Character";
			}

			//Number - Only Integers in KXI.
			if (regex_match(tmpLexem, kxi_number)){tmpType = "Number";}

			//Identifier - (1) That begin when an Upper or Lower case letter && (2)Are less than 80 characters.

			if (tmpLexem.size() < 80 && regex_match(tmpLexem, kxi_identifier)){tmpType = "Identifier";}

				//Symbols

			// assignment operator = or relational operator ==

			if (tmp == '=' && tmpLexem == "=")
			{
				if (kxiFile.peek() != '=')
				{
					if (regex_match(tmpLexem, kxi_assignmentOp))
					{
						tmpType = "Assignment Operator";
					}
				}
				else
				{
					tmp = kxiFile.get();
					tmpLexem += tmp;
					if (regex_match(tmpLexem, kxi_relationalOp))
					{
						tmpType = "Relational Operator";
					}
				}
				tmp = kxiFile.get();
			}

			// logical connective operator &&
			if (tmp == '&' && tmpLexem == "&")
			{
				if (kxiFile.peek() == '&')
				{
					tmp = kxiFile.get();
					tmpLexem += tmp;
					tmpType = "Logical Connective Operator";
				}
				tmp = kxiFile.get();
			}

			// logical connective operator ||
			if (tmp == '|' && tmpLexem == "|")
			{
				if (kxiFile.peek() == '|')
				{
					tmp = kxiFile.get();
					tmpLexem += tmp;
					tmpType = "Logical Connective Operator";
				}
				tmp = kxiFile.get();
			}

			// relational operator !=

			if (tmp == '!' && tmpLexem == "!")
			{
				if (kxiFile.peek() == '=')
				{
					tmp = kxiFile.get();
					tmpLexem += tmp;
					tmpType = "Relational Operator";
				}
				tmp = kxiFile.get();
			}

			// relational operator < or <=

			if (tmp == '<' && tmpLexem == "<")
			{
				if (kxiFile.peek() != '=')
				{
					tmpType = "Relational Operator";
				}
				else
				{
					tmp = kxiFile.get();
					tmpLexem += tmp;
					if (regex_match(tmpLexem, kxi_relationalOp))
					{
						tmpType = "Relational Operator";
					}
				}
				tmp = kxiFile.get();
			}

			// operator <<
			if (tmp == '<' && tmpLexem == "<")
			{
				if (kxiFile.peek() == '<')
				{
					tmp = kxiFile.get();
					tmpLexem += tmp;
					tmpType = "<<";
				}
			}

			// relational operator > or >=

			if (tmp == '>' && tmpLexem == ">")
			{
				if (kxiFile.peek() != '=')
				{
					tmpType = "Relational Operator";
				}
				else
				{
					tmp = kxiFile.get();
					tmpLexem += tmp;
					if (regex_match(tmpLexem, kxi_relationalOp))
					{
						tmpType = "Relational Operator";
					}
				}
				tmp = kxiFile.get();
			}

			// operator >>
			if (tmp == '>' && tmpLexem == ">")
			{
				if (kxiFile.peek() == '>')
				{
					tmp = kxiFile.get();
					tmpLexem += tmp;
					tmpType = ">>";
				}
			}

			// math operator +

			if (tmp == '+' && tmpLexem == "+")
			{
				tmp = kxiFile.get();
				tmpType = "Plus Operator";
			}

			// math operator -

			if (tmp == '-' && tmpLexem == "-")
			{
				tmp = kxiFile.get();
				tmpType = "Minus Operator";
			}

			// math operator *

			if (tmp == '*' && tmpLexem == "*")
			{
				tmp = kxiFile.get();
				tmpType = "Math Operator";
			}

			// math operator /

			if (tmp == '/' && tmpLexem == "/")
			{
				tmp = kxiFile.get();
				tmpType = "Math Operator";
			}

			// array begin

			if (tmp == '[' && tmpLexem == "[")
			{
				tmp = kxiFile.get();
				tmpType = "[";
			}

			// array end

			if (tmp == ']' && tmpLexem == "]")
			{
				tmp = kxiFile.get();
				tmpType = "]";
			}

			// block begin

			if (tmp == '{' && tmpLexem == "{")
			{
				tmp = kxiFile.get();
				tmpType = "{";
			}

			// block end

			if (tmp == '}' && tmpLexem == "}")
			{
				tmp = kxiFile.get();
				tmpType = "}";
			}

			// parenthese open

			if (tmp == '(' && tmpLexem == "(")
			{
				tmp = kxiFile.get();
				tmpType = "(";
			}

			// parenthese close

			if (tmp == ')' && tmpLexem == ")")
			{
				tmp = kxiFile.get();
				tmpType = ")";
			}

			//Keyword - or you can use the name of the keyword as the token type(if, while, true, false, return, …)

			if (regex_match(tmpLexem, kxi_atoi))
				tmpType = "atoi";
			if (regex_match(tmpLexem, kxi_bool))
				tmpType = "bool";
			if (regex_match(tmpLexem, kxi_class))
				tmpType = "class";
			if (regex_match(tmpLexem, kxi_char))
				tmpType = "char";
			if (regex_match(tmpLexem, kxi_cin))
				tmpType = "cin";
			if (regex_match(tmpLexem, kxi_cout))
				tmpType = "cout";
			if (regex_match(tmpLexem, kxi_else))
				tmpType = "else";
			if (regex_match(tmpLexem, kxi_false))
				tmpType = "false";
			if (regex_match(tmpLexem, kxi_if))
				tmpType = "if";
			if (regex_match(tmpLexem, kxi_int))
				tmpType = "int";
			if (regex_match(tmpLexem, kxi_itoa))
				tmpType = "itoa";
			if (regex_match(tmpLexem, kxi_main))
				tmpType = "main";
			if (regex_match(tmpLexem, kxi_new))
				tmpType = "new";
			if (regex_match(tmpLexem, kxi_null))
				tmpType = "null";
			if (regex_match(tmpLexem, kxi_object))
				tmpType = "object";
			if (regex_match(tmpLexem, kxi_public))
				tmpType = "public";
			if (regex_match(tmpLexem, kxi_private))
				tmpType = "private";
			if (regex_match(tmpLexem, kxi_return))
				tmpType = "return";
			if (regex_match(tmpLexem, kxi_string))
				tmpType = "string";
			if (regex_match(tmpLexem, kxi_this))
				tmpType = "this";
			if (regex_match(tmpLexem, kxi_true))
				tmpType = "true";
			if (regex_match(tmpLexem, kxi_void))
				tmpType = "void";
			if (regex_match(tmpLexem, kxi_while))
				tmpType = "while";

			//Punctuation

			if ((tmp == ',' && tmpLexem == ",") || (tmp == ';' && tmpLexem == ";") || (tmp == '.' && tmpLexem == "."))
			{
				if (regex_search(tmpLexem, kxi_punctuation))
					tmpType = "Punctuation";
				tmp = kxiFile.get();
			}

			if (tmpLexem[0] == -1){tmpType = "EOT";}

			//create token
			currentToken = new Token(tmpLexem, tmpType);
			tokenCount++;
			if (tmpLexem.size() == 0 && tmpType == "Unknown"){failCount++;}
			seekpos = kxiFile.tellg();
		}	
	else
	{
		//End of File
		tmpType = "EOF";
		currentToken = new Token(tmpLexem, tmpType);
	}
}

Token* Scanner::peek(int n)
{
	for (int i = 0; i < n; i++)
	{
		delete peekToken;

		//i)Discards the current token, find the next token and makes it the current token.

		string tmpLexem;
		string tmpType = "Unknown";

		if (!kxiFile.eof())
		{
			while (kxiFile.good() && aFileDelim(tmp))
			{
				tmp = kxiFile.get();
			}

			if (!aFileDelim(tmp))
				tmpLexem += tmp;

			while (kxiFile.good() && nonDelimiter(tmp))
			{
				tmp = kxiFile.get();

				if (nonDelimiter(tmp))
				{
					tmpLexem += tmp;
				}

				//Character space - No strings in KXI.
				if (regex_match(tmpLexem, kxi_characterstart))
				{
					tmpLexem += tmp;
					if (kxiFile.peek() == '\'')
					{
						tmp = kxiFile.get();
						tmpLexem += tmp;
						if (regex_match(tmpLexem, kxi_space))
						{
							tmpType = "Character";
						}
					}
					else
					{
						if (aSymbol(tmp))
						{
							tmp = kxiFile.get();
						}
					}
				}
			}

			if (aSymbol(tmp))
			{
				if (tmpLexem.size() == 0)
					tmpLexem = 0 + tmp;
			}

			//Comment - Ignore rest of line.
			if (tmp == '/' && kxiFile.peek() == '/')
			{
				tmpLexem += tmp;
				while (kxiFile.good() && tmp != '\n')
				{
					tmp = kxiFile.get();
				}
				tmpType = "Comment";
			}

			//printable Character - No strings in KXI.
			if (regex_match(tmpLexem, kxi_character2))
			{
				tmpType = "Character";
			}

			//Nonprintable Character
			if (regex_match(tmpLexem, kxi_nonPrint))
			{
				tmpType = "Character";
			}

			//Number - Only Integers in KXI.
			if (regex_match(tmpLexem, kxi_number)){ tmpType = "Number"; }

			//Identifier - (1) That begin when an Upper or Lower case letter && (2)Are less than 80 characters.

			if (tmpLexem.size() < 80 && regex_match(tmpLexem, kxi_identifier)){ tmpType = "Identifier"; }

			//Symbols

			// assignment operator = or relational operator ==

			if (tmp == '=' && tmpLexem == "=")
			{
				if (kxiFile.peek() != '=')
				{
					if (regex_match(tmpLexem, kxi_assignmentOp))
					{
						tmpType = "Assignment Operator";
					}
				}
				else
				{
					tmp = kxiFile.get();
					tmpLexem += tmp;
					if (regex_match(tmpLexem, kxi_relationalOp))
					{
						tmpType = "Relational Operator";
					}
				}
				tmp = kxiFile.get();
			}

			// logical connective operator &&
			if (tmp == '&' && tmpLexem == "&")
			{
				if (kxiFile.peek() == '&')
				{
					tmp = kxiFile.get();
					tmpLexem += tmp;
					tmpType = "Logical Connective Operator";
				}
				tmp = kxiFile.get();
			}

			// logical connective operator ||
			if (tmp == '|' && tmpLexem == "|")
			{
				if (kxiFile.peek() == '|')
				{
					tmp = kxiFile.get();
					tmpLexem += tmp;
					tmpType = "Logical Connective Operator";
				}
				tmp = kxiFile.get();
			}

			// relational operator !=

			if (tmp == '!' && tmpLexem == "!")
			{
				if (kxiFile.peek() == '=')
				{
					tmp = kxiFile.get();
					tmpLexem += tmp;
					tmpType = "Relational Operator";
				}
				tmp = kxiFile.get();
			}

			// relational operator < or <=

			if (tmp == '<' && tmpLexem == "<")
			{
				if (kxiFile.peek() != '=')
				{
					tmpType = "Relational Operator";
				}
				else
				{
					tmp = kxiFile.get();
					tmpLexem += tmp;
					if (regex_match(tmpLexem, kxi_relationalOp))
					{
						tmpType = "Relational Operator";
					}
				}
				tmp = kxiFile.get();
			}

			// operator <<
			if (tmp == '<' && tmpLexem == "<")
			{
				if (kxiFile.peek() == '<')
				{
					tmp = kxiFile.get();
					tmpLexem += tmp;
					tmpType = "<<";
				}
			}

			// relational operator > or >=

			if (tmp == '>' && tmpLexem == ">")
			{
				if (kxiFile.peek() != '=')
				{
					tmpType = "Relational Operator";
				}
				else
				{
					tmp = kxiFile.get();
					tmpLexem += tmp;
					if (regex_match(tmpLexem, kxi_relationalOp))
					{
						tmpType = "Relational Operator";
					}
				}
				tmp = kxiFile.get();
			}

			// operator >>
			if (tmp == '>' && tmpLexem == ">")
			{
				if (kxiFile.peek() == '>')
				{
					tmp = kxiFile.get();
					tmpLexem += tmp;
					tmpType = ">>";
				}
			}

			// math operator +

			if (tmp == '+' && tmpLexem == "+")
			{
				tmp = kxiFile.get();
				tmpType = "Plus Operator";
			}

			// math operator -

			if (tmp == '-' && tmpLexem == "-")
			{
				tmp = kxiFile.get();
				tmpType = "Minus Operator";
			}

			// math operator *

			if (tmp == '*' && tmpLexem == "*")
			{
				tmp = kxiFile.get();
				tmpType = "Math Operator";
			}

			// math operator /

			if (tmp == '/' && tmpLexem == "/")
			{
				tmp = kxiFile.get();
				tmpType = "Math Operator";
			}

			// array begin

			if (tmp == '[' && tmpLexem == "[")
			{
				tmp = kxiFile.get();
				tmpType = "[";
			}

			// array end

			if (tmp == ']' && tmpLexem == "]")
			{
				tmp = kxiFile.get();
				tmpType = "]";
			}

			// block begin

			if (tmp == '{' && tmpLexem == "{")
			{
				tmp = kxiFile.get();
				tmpType = "{";
			}

			// block end

			if (tmp == '}' && tmpLexem == "}")
			{
				tmp = kxiFile.get();
				tmpType = "}";
			}

			// parenthese open

			if (tmp == '(' && tmpLexem == "(")
			{
				tmp = kxiFile.get();
				tmpType = "(";
			}

			// parenthese close

			if (tmp == ')' && tmpLexem == ")")
			{
				tmp = kxiFile.get();
				tmpType = ")";
			}

			//Keyword - or you can use the name of the keyword as the token type(if, while, true, false, return, …)

			if (regex_match(tmpLexem, kxi_atoi))
				tmpType = "atoi";
			if (regex_match(tmpLexem, kxi_bool))
				tmpType = "bool";
			if (regex_match(tmpLexem, kxi_class))
				tmpType = "class";
			if (regex_match(tmpLexem, kxi_char))
				tmpType = "char";
			if (regex_match(tmpLexem, kxi_cin))
				tmpType = "cin";
			if (regex_match(tmpLexem, kxi_cout))
				tmpType = "cout";
			if (regex_match(tmpLexem, kxi_else))
				tmpType = "else";
			if (regex_match(tmpLexem, kxi_false))
				tmpType = "false";
			if (regex_match(tmpLexem, kxi_if))
				tmpType = "if";
			if (regex_match(tmpLexem, kxi_int))
				tmpType = "int";
			if (regex_match(tmpLexem, kxi_itoa))
				tmpType = "itoa";
			if (regex_match(tmpLexem, kxi_main))
				tmpType = "main";
			if (regex_match(tmpLexem, kxi_new))
				tmpType = "new";
			if (regex_match(tmpLexem, kxi_null))
				tmpType = "null";
			if (regex_match(tmpLexem, kxi_object))
				tmpType = "object";
			if (regex_match(tmpLexem, kxi_public))
				tmpType = "public";
			if (regex_match(tmpLexem, kxi_private))
				tmpType = "private";
			if (regex_match(tmpLexem, kxi_return))
				tmpType = "return";
			if (regex_match(tmpLexem, kxi_string))
				tmpType = "string";
			if (regex_match(tmpLexem, kxi_this))
				tmpType = "this";
			if (regex_match(tmpLexem, kxi_true))
				tmpType = "true";
			if (regex_match(tmpLexem, kxi_void))
				tmpType = "void";
			if (regex_match(tmpLexem, kxi_while))
				tmpType = "while";

			//Punctuation

			if (tmp == ',' && tmpLexem == ",")
			{
				if (regex_search(tmpLexem, kxi_punctuation))
					tmpType = ",";
				tmp = kxiFile.get();
			}
			else if (tmp == ';' && tmpLexem == ";")
			{
				if (regex_search(tmpLexem, kxi_punctuation))
					tmpType = ";";
				tmp = kxiFile.get();
			}
			else if (tmp == '.' && tmpLexem == ".")
			{
				if (regex_search(tmpLexem, kxi_punctuation))
					tmpType = ".";
				tmp = kxiFile.get();
			}

			if (tmpLexem[0] == -1){ tmpType = "EOT"; }

			//create token
			peekToken = new Token(tmpLexem, tmpType);
			tokenCount++;
			if (tmpLexem.size() == 0 && tmpType == "Unknown"){ failCount++; }
		}
		else
		{
			//End of File
			tmpType = "EOF";
			peekToken = new Token(tmpLexem, tmpType);
		}
	}
	return peekToken;
}

bool Scanner::aSymbol(char t)
{
	if (t == '=' || t == '&' || t == '|' || t == '!' || t == '<'
		|| t == '>' || t == '+' || t == '-' || t == '*' || t == '/'
		|| t == ',' || t == ';' || t== '.' || t == '[' || t == ']' || t == '{'
		|| t == '}' || t == '(' || t == ')')
		return true;
	else return false;
}

bool Scanner::aFileDelim(char t)
{
	if (t == ' ' || t == '\r' || t == '\n' || t == '\t' || t == 0)
		return true;
	else return false;
}

bool Scanner::nonDelimiter(char t)
{
	if (t != '\r' && t != '\n' && t != -1 && t != ' ' && t != '\t' && t != '=' &&
		t != '&' && t != '|' && t != '!' && t != '<' &&
		t != '>' && t != '+' && t != '-' && t != '*' && t != '/'
		&& t != ',' && t != ';' && t != '.' && t != '[' && t != ']' && t != '{'
		&& t != '}' && t != '(' && t != ')')
		return true;
	else return false;
}