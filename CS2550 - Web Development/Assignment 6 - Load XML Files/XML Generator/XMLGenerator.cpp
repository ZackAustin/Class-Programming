#include "XMLGenerator.h"

#if defined(_WIN32)
	#define listcmd "dir /b *.txt > fileDirectory.text 2>nul"
#elif defined(__GNUC__)
	#define listcmd "ls *.txt > fileDirectory.text 2>/dev/null"
#else
	#error UnSupported Compiler.
#endif

XMLGenerator::XMLGenerator(){}

void XMLGenerator::runXMLGenerator()
{
	this->setupDirectoryFile();
	while (*fileDirectory.file)
	{
		currentPuzzleFile = this->getNextInputFile();
		currentXMLOutputFile = this->getNextOutputFile();
		std::cout << "file: " << currentPuzzleFile.fileName << std::endl;
		if (currentXMLOutputFile.file != nullptr)
			this->parseTextToXML();

		this->closeCurrentFiles();
	}
	if (fileDirectory.file != nullptr)
		delete fileDirectory.file;
}

void XMLGenerator::closeCurrentFiles()
{
	if (currentPuzzleFile.file != nullptr)
		currentPuzzleFile.file->close();
	if (currentXMLOutputFile.file != nullptr)
		currentXMLOutputFile.file->close();

	if (currentPuzzleFile.file != nullptr)
		delete currentPuzzleFile.file;

	if (currentXMLOutputFile.file != nullptr)
		delete currentXMLOutputFile.file;	
}

void XMLGenerator::setupDirectoryFile()
{
	system(listcmd);
	fileDirectory = {"fileDirectory.text", "in"};
}

fileWrapper XMLGenerator::getNextInputFile()
{
	std::string tmpFileName;
	std::getline(*fileDirectory.file, tmpFileName);

	return fileWrapper(tmpFileName, "in");
}

fileWrapper XMLGenerator::getNextOutputFile()
{
	std::string tmpFileName = currentPuzzleFile.fileName;
	std::size_t extensionPosition = tmpFileName.find(".");
	tmpFileName = tmpFileName.substr(0, extensionPosition);
	tmpFileName += ".xml";

	return fileWrapper(tmpFileName, "out");
}

void XMLGenerator::parseTextToXML()
{
	*currentXMLOutputFile.file << "<?xml version = \"1.0\"?>\n" << "<!DOCTYPE puzzle SYSTEM \"puzzleGen.dtd\">\n\n";
	*currentXMLOutputFile.file << "<puzzle>\n";

	int counter = 0;

	while(*currentPuzzleFile.file)
	{
		counter++;
		char nextItem = ' ';
		*currentPuzzleFile.file >> nextItem;

		if (aValidValue(nextItem))
		{
			*currentXMLOutputFile.file << "\t<node ID = \"" << counter << "\">\n";

			if (validNumber(nextItem)) //predetermined number
			{
				*currentXMLOutputFile.file << "\t\t<type>predetNum</type>\n";
				*currentXMLOutputFile.file << "\t\t<value>" << nextItem << "</value>\n";
			}
			else if (nextItem == 'b')//user number
			{
				*currentXMLOutputFile.file << "\t\t<type>userNum</type>\n";
				*currentXMLOutputFile.file << "\t\t<value></value>\n";
			}

			*currentXMLOutputFile.file << "\t</node>\n";
		}
	}

	*currentXMLOutputFile.file << "</puzzle>\n";
}

bool XMLGenerator::validNumber(char c)
{
	if (c == '1' || c == '2' || c == '3' || c == '4' ||
		 c == '5' || c == '6' || c == '7' ||
		  c == '8' || c == '9')
		return true;
	else return false;
}

bool XMLGenerator::aValidValue(char c)
{
	if (validNumber(c)|| c == 'b')
		return true;
	else return false;
}