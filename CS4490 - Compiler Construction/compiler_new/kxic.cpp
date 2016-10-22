//	Programmer:		Zack Austin
//	Program:		KXI-COMPILER
//	Class:			CS4490 - Compilers
//	Date:			Worked on: 12/24/14


#include <cctype>
#include <algorithm>
#include <typeinfo>
#include "scanner.h"
#include "cl.h"
#include "tcgen.h"

compilerArgs parseArgs(int argc, const char* argv[]);

int main(int argc, const char* argv[])
{
	//First thing we want to add is an easy to use debugger through the command line.
	//Such as: First is compile cmd, followed by the file to parse (main), an optional debug option(dnon, dlex, dsyn, dsem, dint, dtar, dall,
	// or a value to debug step-forwards to such as dbg2 which refers to debug, lex, then debug syn, and then be done.), and optional out file for debug option.
	// Textfile would be required, so argc of at least 2. 
		//EX: kxic kxiex1.txt
		//EX: kxic kxiex1.txt dsyn

	//parseArgs will need the ability to pass this debugging information along to the compilation process.

	compilerArgs argumentList = parseArgs(argc, argv);

	try
	{
		Scanner lexer(&argumentList);
		ST symbolTable;
		Cl syntaxParser(&argumentList, &lexer, &symbolTable);
		//Pass 1
		syntaxParser.compilation_unit();
		argumentList.debugPrint(&symbolTable, argumentList.debuggingSyntax);

		//Pass 2
		lexer.resetFileState();
		OS operatorStack(&argumentList);
		SAS semanticActionStack;
		ICGenerator ICodeGenerator(&lexer);
		ICGenerator StaticICodeGenerator(&lexer);
		Cl semanticsParser(&argumentList, &lexer, &symbolTable, &operatorStack, &semanticActionStack, &ICodeGenerator, &StaticICodeGenerator);
		semanticsParser.compilation_unit();
		argumentList.debugPrint(&symbolTable, argumentList.debugging);
		argumentList.debugPrint(&ICodeGenerator, argumentList.debuggingICode);

		//Target Code Generation
		TCGenerator TCodeGenerator(&symbolTable, &ICodeGenerator, argumentList.getFileName());
	}

	catch (const std::runtime_error& error)
	{
		std::cout << error.what();
	}
	
	return 0;
}


compilerArgs parseArgs(int argc, const char* argv[])
{
	//Setup compilerArgs filename.
	std::string fileName = "";
	//Check no arguments.
	if (argc < 2)
	{
		std::cout << "Enter KXI Filename: ";
		getline(std::cin, fileName);
	}
	//Second arg must be the file to be parsed. argc 2 is argv[1].
	else
		fileName = argv[1];

	//Setup compilerArgs debugType (none default otherwise as specified (dall as long as debugStep is a valid value))
	//Using both these values with an overload of the struct operator to go if (compilerArgs) {compiler parsing stuff.}
		//overload: if (debugType != "" || debugStep > 0) return true else return false;
	std::string debuggingType = "";
	int debugSteps = -999;
	std::string outFile = "";

	if (argc >= 3)
	{
		std::string debugOption = argv[2];
		std::transform(debugOption.begin(), debugOption.end(), debugOption.begin(), ::tolower);

		if (debugOption == "dall" || debugOption == "dlex" || debugOption == "dpar" || debugOption == "dsyn" || debugOption == "dsem" || debugOption == "dint" || debugOption == "dtar" || debugOption == "dnon")
		{
			debuggingType = argv[2];
		}
		else if (true)
		{
			for (size_t i = 1; i < 6; ++i)
			{
				std::ostringstream ss;
				ss << i;
				std::string posDbgVal = "dbg" + ss.str();
				if (debugOption == posDbgVal)
				{
					debugSteps = i;
					debuggingType = posDbgVal;
				}
			}
		}
	}

	if (argc >= 4 && debuggingType != "")
		outFile = argv[3];

	return compilerArgs{fileName, debuggingType, debugSteps, outFile};
}