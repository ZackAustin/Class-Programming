//	Programmer:		Zack Austin
//	Program:		KXI-COMPILER
//	Class:			CS4490 - Compilers
//	Date:			Worked on: 1/14/14

#include "Scanner.h"
#include "Cl.h"
#include <cstring>

using namespace std;

const bool debugMode = true;
const bool debugLexer = false;

void parsingAnalysis(Scanner &ct, bool semantics);

int main(int argc, char* argv [])
{
	//Get a File from User either through CMD LINE ARG or INITIAL PROMPT
	string kxiFile;

	if (argc > 1)
	{
		kxiFile = argv[1];
	}
	else
	{
		cout << "Enter KXI Filename: ";
		getline(cin, kxiFile);
	}

	ofstream kxiOutput;

	if (argc > 2)
	{
		kxiOutput.open(argv[2], ios::binary);
	}

	Scanner* ctptr = nullptr;

	//Create Scanner Object, pass Filename into Constructor, Error on file name.
	try
	{
		Scanner* ct = new Scanner(kxiFile, debugMode);
		ctptr = ct;
	}

	catch (runtime_error& x)
	{
		cout << x.what() << endl;
		return 1;
	}

	if (debugLexer)
	{
		while (ctptr->getToken()->getType() != "EOF")
		{
			ctptr->nextToken();
			Token* aToken = ctptr->getToken();
			if (debugMode && aToken != nullptr)
			{
				cout << "\nToken Lexem: " << aToken->getLexem() << endl;
				cout << "Token Type : " << aToken->getType() << endl;
				if (argc > 2)
				{
					kxiOutput << "\nToken Lexem: " << aToken->getLexem() << endl;
					kxiOutput << "Token Type : " << aToken->getType() << endl;
				}
			}

			if (debugMode && ctptr->getToken()->getType() == "EOF")
			{
				cout << "\nFail Count Is: " << ctptr->getFailRate() << endl;
				cout << "\nToken Count is: " << ctptr->getTokenCount() << endl;
				if (argc > 2)
				{
					kxiOutput << "\nFail Count Is: " << ctptr->getFailRate() << endl;
					kxiOutput << "\nToken Count is: " << ctptr->getTokenCount() << endl;
				}
			}
		}
	}

	parsingAnalysis(*ctptr, false); //Pass 1

	delete ctptr;

	return 0;
}

void parsingAnalysis(Scanner &ct, bool semantics)
{
	Cl grammar(&ct);
	if (ct.getToken()->getType() != "EOF" && ct.getToken()->getType() != "EOT")
		grammar.genError("EOF");
}