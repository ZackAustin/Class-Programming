#include "XMLGenerator.h"

void runMenu();

int main()
{
	runMenu();
	return 1;
}

void runMenu()
{
	std::cout << "XML Generator for Sudoku Puzzles.\n";
	std::string menuInput = "";

	while (menuInput != "2")
	{
		std::cout << "1: Generate XML Files from all Puzzle.txt files in directory?\n";
		std::cout << "2: Quit?\n";

		std::cin >> menuInput;

		if (menuInput == "1")
		{
			//new xml gen obj.
			XMLGenerator genXML;
			genXML.runXMLGenerator();
			menuInput = "2";
		}
	}
}