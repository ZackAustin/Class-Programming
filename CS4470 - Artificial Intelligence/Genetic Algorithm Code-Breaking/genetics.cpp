//	Author:		Zack Austin
//	Program:	Genetic Algorithms - Code Breaking
//	Class:		CS4470
//	Date:		11/05/14

#include "population.h"

void runMenu();

int main()
{
	runMenu();
	return 0;
}

void runMenu()
{
	std::string inputCase = "-1";
	std::cout << "Genetic Code Breaking Algorithm\n";
	while (inputCase != "3")
	{
		std::cout << "\n1. Run Default\n2. Change Input Experiment Parameter\n3. Quit\n";
		std::cin >> inputCase;
		Population* initPopulation;
		if (inputCase == "1")
			initPopulation = new Population();
		else if (inputCase == "2")
		{
			std::string inputVal = "-1";
			while (inputVal != "1" && inputVal != "2" && inputVal != "3" && inputVal != "4" && inputVal != "5")
			{
				std::cout << "\n1. Change Temperature\n";
				std::cout << "2. Change Crossover Rate\n";
				std::cout << "3. Change Mutation Rate\n";
				std::cout << "4. Change Code's Size\n";
				std::cout << "5. Change Fitness Function\n";			
				std:: cin >> inputVal;
			}
			initPopulation = new Population(inputVal);
		}
		
		if (inputCase == "1" || inputCase == "2")
		{
			//run it
			initPopulation->runExperiment();
			std::cout << initPopulation;
	
			delete initPopulation;
		}
	}
}