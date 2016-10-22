#include "geneticAlgs.h"

std::string GeneticAlgs::codeString = "";

void GeneticAlgs::fitnessCorrectChars(Hypothesis& h, double maxChars)
{
	double charsCorrect = 0;
	for (int i = 0; i < h.individual.length(); ++i)
	{
		if (h.individual[i] == GeneticAlgs::codeString[i])
			charsCorrect++;
	}
	h.fitness = charsCorrect / maxChars;
}

void GeneticAlgs::fitnessNumberOfCharsOff(Hypothesis& h, double maxOff)
{
	double charsOff = 0;
	for (int i = 0; i < h.individual.length(); ++i)
	{
		if (h.individual[i] != GeneticAlgs::codeString[i])
			charsOff += abs(h.individual[i] - GeneticAlgs::codeString[i]);
	}
	h.fitness = 1 - (charsOff / maxOff);
}

std::vector<Hypothesis> GeneticAlgs::runSinglePointCrossOver(std::vector<Hypothesis>& sc)
{
	std::vector<Hypothesis> children;
	int indexMaxVal = 0;
	if (sc.size() > 0)
		indexMaxVal = sc.size() - 1;

	std::random_device rd; // obtain a random number from hardware
	std::mt19937 eng(rd()); // seed the generator
	std::uniform_int_distribution<int> distrIndex(0, indexMaxVal); // define the range_

	for (size_t i = 0; i < indexMaxVal; i += 2)
	{
		std::string fs1 = sc[distrIndex(eng)].individual;
		std::string front1 = fs1.substr(0, fs1.length() / 2 + 1);
		std::string back1 = fs1.substr(fs1.length() / 2 + 1, fs1.length() - 1);

		std::string fs2, front2, back2;

		fs2 = sc[distrIndex(eng)].individual;

		front2 = fs2.substr(0, fs2.length() / 2 + 1);
		back2 = fs2.substr(fs2.length() / 2 + 1, fs2.length() - 1);

		std::string child1 = front1 + back2;
		std::string child2 = front2 + back1;

		children.push_back({ child1, 999 });
		children.push_back({ child2, 999 });
	}
	
	//if odd size add 1 more.
	if (sc.size() % 2 != 0)
	{
		//1 more child
		std::string fs = sc[distrIndex(eng)].individual;
		std::string front = fs.substr(0, fs.length() / 2 + 1);
		std::string back = fs.substr(fs.length() / 2 + 1, fs.length() - 1);

		children.push_back({ front + back, 999 });
	}
	return children;
}

void GeneticAlgs::runMutations(std::vector<Hypothesis>& pop, double mr, int wl)
{
	int mutateAmount = mr * pop.size();
	int indexMaxVal = 1;
	if (pop.size() > 0)
		indexMaxVal = pop.size() - 1;
	int charAtMaxVal = 1;
	if (wl - 1 > 0)
		charAtMaxVal = wl - 1;
		
	std::random_device rd; // obtain a random number from hardware
	std::mt19937 eng(rd()); // seed the generator
	std::uniform_int_distribution<int> distrIndex(0, indexMaxVal); // define the range_
	std::uniform_int_distribution<int> distrChar(ALPHABET_START, ALPHABET_END); // define the range_
	std::uniform_int_distribution<int> distrCharAt(0, charAtMaxVal); // define the range_

	for (int i = 0; i < mutateAmount; i++)
	{
		int index = distrIndex(eng);
		pop[index].individual[distrCharAt(eng)] = distrChar(eng);
	}
}