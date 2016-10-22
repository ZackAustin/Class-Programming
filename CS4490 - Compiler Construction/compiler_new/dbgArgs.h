#pragma once

#include <string>
#include <iostream>
#include <fstream>

struct compilerArgs
{
private:
	std::string kxiFileName;
public:
	std::string debugType;
	int debugStep;
	std::string outFile;
	bool debugging;
	bool debuggingLexer;
	bool debuggingParser;
	bool debuggingSyntax;
	bool debuggingSemantics;
	bool debuggingICode;
	bool showLineNumbers;
	std::ofstream *ofs;

	compilerArgs(std::string, std::string, int, std::string);

	template <typename T>
	void debugPrint(T type, bool debugMode)
	{
		if (debugMode)
		{
			if (ofs != nullptr && ofs->is_open())
				*ofs << type;
			else std::cout << type;
		}
	}

	std::string getFileName() {return kxiFileName;}

	friend std::ostream& operator<< (std::ostream& o, compilerArgs const& args)
	{
		if (args.debugging)
		{
			o <<"\nCommand Line Arguments:\n" << std::endl;
			o << "kxiFileName: " << args.kxiFileName << std::endl;
			o << "debugType: " << args.debugType << std::endl;
			o << "debugStep: " << args.debugStep << std::endl;
			o << "debugging: " << args.debugging << std::endl;
			return o << "Output File: " << args.outFile << std::endl;
		}
		else return o;
	}
};