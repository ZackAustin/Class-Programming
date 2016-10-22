#pragma once
#include <fstream>
#include <iostream>
#include <string>

struct fileWrapper
{
	std::string fileName;
	std::fstream* file;

	fileWrapper(){}

	fileWrapper(std::string fn, std::string streamType)
	{
		fileName = fn;
		if (streamType == "in")
			file = new std::fstream(fn, std::ifstream::in);
		else if(streamType == "out" && fn != ".xml")
			file = new std::fstream(fn, std::ofstream::out);
		else file = nullptr;
	}

	void operator=(const fileWrapper &other)
	{
		fileName = other.fileName;
		file = other.file;
	}
};

class XMLGenerator
{
private:
	fileWrapper fileDirectory;
	fileWrapper currentPuzzleFile;
	fileWrapper currentXMLOutputFile;

	void setupDirectoryFile();
	void closeCurrentFiles();
	fileWrapper getNextInputFile();
	fileWrapper getNextOutputFile();
	void parseTextToXML();
	bool validNumber(char);
	bool aValidValue(char);

public:
	XMLGenerator();
	void runXMLGenerator();
};