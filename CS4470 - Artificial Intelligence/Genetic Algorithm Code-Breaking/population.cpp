#include "population.h"
#include <ctime>
#include <algorithm>
#include <cmath>
#include <exception>

using namespace std::chrono;

struct sortHypothesis
{
	bool operator() (Hypothesis i, Hypothesis j)
	{
		return i.fitness < j.fitness;
	}
} sortFitness;

Population::Population()
{
	setupDefaults();
}

Population::Population(std::string changed)
{
	setupDefaults();
	
	if (changed == "1")
	{
		//Temperature Change
		std::cout << "\nNew Temperature: ";
		std::cin >> temperature;
	}
	else if(changed == "2")
	{
		//CrossOver Rate Change
		std::cout << "\nNew CrossOver Rate: ";
		std::cin >> crossOverPercent;
		if (crossOverPercent > 1)
			crossOverPercent = 1;
		else if (crossOverPercent < 0)
			crossOverPercent = 0.01;
	}
	else if(changed == "3")
	{
		//Mutation Rate Change
		std::cout << "\nNew Mutation Rate: ";
		std::cin >> mutationRate;
		if (mutationRate > 1)
			mutationRate = 1;
		else if (mutationRate < 0)
			mutationRate = 0.01;
	}
	else if(changed == "4")
	{
		//Code Size Change
		std::cout << "\nSize of Code String: ";
		int codeSize = 0;
		std::cin >> codeSize;
		if (codeSize < 0)
			codeSize = 1;
		else if (codeSize > 10)
			codeSize = 10;

		std::random_device rd; // obtain a random number from hardware
		std::mt19937 eng(rd()); // seed the generator
		std::uniform_int_distribution<int> distr(ALPHABET_START, ALPHABET_END); // define the range_
		
		std::string stringValue = "";
		for (int i = 0; i < codeSize; ++i)
			stringValue += distr(eng);
		
		GeneticAlgs::codeString = stringValue;
		wordLength = GeneticAlgs::codeString.length();
		
		population.clear();
		population.resize(populationSize);
	
		for (auto itr = population.begin(); itr != population.end(); ++itr)
		{
			std::string stringValue2 = "";
			for (int i = 0; i < wordLength; ++i)
				stringValue2 += distr(eng);
			*itr = {stringValue2, 999};
		}
	}
	else if(changed == "5")
	{
		//Fitness Function Change
		std::string inputVal = "-1";
		while (inputVal != "1" && inputVal != "2")
		{
			std::cout << "\t1. Use Fitness Function: Correct Number of Characters\n";
			std::cout << "\t2. Use Fitness Function: Number of Characters Off\n";
			std::cin >> inputVal;
		}
		fitnessType = std::stoi(inputVal);
		if (fitnessType == 1)
			fitnessFunction = &GeneticAlgs::fitnessCorrectChars;
		else fitnessFunction = &GeneticAlgs::fitnessNumberOfCharsOff;
	}
}

void Population::setupDefaults()
{
	populationSize = 25;
	wordLength = 5;
	crossOverPercent = 0.6;
	mutationRate = 0.15;
	temperature = 2;
	population.resize(populationSize);
	
	std::random_device rd; // obtain a random number from hardware
    std::mt19937 eng(rd()); // seed the generator
	std::uniform_int_distribution<int> distr(ALPHABET_START, ALPHABET_END); // define the range_
	
	std::string codeValue = "";
		for (int i = 0; i < wordLength; ++i)
			codeValue += distr(eng);
		
	GeneticAlgs::codeString = codeValue;
	
	for (auto itr = population.begin(); itr != population.end(); ++itr)
	{
		std::string stringValue = "";
		for (int i = 0; i < wordLength; ++i)
			stringValue += distr(eng);
		*itr = {stringValue, 999};
	}
	
	//setup function pointer fitness.
	fitnessFunction = &GeneticAlgs::fitnessNumberOfCharsOff;
	fitnessType = 2;
	fitnessThreshold = 1;
	//setup crossover function pointer.
	crossOverFunction = &GeneticAlgs::runSinglePointCrossOver;
	//setup mutation function pointer.
	mutationFunction = &GeneticAlgs::runMutations;
}

void Population::runExperiment()
{
	auto startTime = high_resolution_clock::now();
	
	individualCount = populationSize;
	double maxThreshold = 0;
	int loops = 0;
	double averageFitness = 0;
	Hypothesis best;
	
	//initial fitness.
	for (auto itr = begin(population); itr != end(population); ++itr)
	{
		if (fitnessType == 1)
			fitnessFunction(*itr, wordLength);
		else if (fitnessType == 2)
			fitnessFunction(*itr, wordLength * (ALPHABET_END - ALPHABET_START));
		if ((*itr).fitness > maxThreshold)
		{
			maxThreshold = (*itr).fitness;
			best = (*itr);
		}
		averageFitness += (*itr).fitness;
	}
	
	averageFitness = averageFitness / populationSize;
	std::sort(begin(population), end(population), sortFitness);
	std::vector<Hypothesis> selectedCrossOver;
	
	double totalFitness = 0;
	std::cout << "\nInitial Population:\n";
	for (auto itr = begin(population); itr != end(population); ++itr)
	{
		std::cout << (*itr);
		totalFitness += (*itr).fitness;
	}
	std::cout << "total fitness amount: " << totalFitness << std::endl;
	
	std::random_device rd; // obtain a random number from hardware
    std::mt19937 eng(rd()); // seed the generator
	std::uniform_int_distribution<int> distr(0, 100); // define the range_
	
	while (maxThreshold != fitnessThreshold)
	{
		selectedCrossOver.swap(std::vector<Hypothesis> {});

		//Boltzman Distribution and Selection
		for (auto itr = 0; itr < population.size(); ++itr)
		{
			double probSelect = runBoltzmanDistribution(population[itr], averageFitness) * 100;
			double prob = distr(eng);
			double ratio = (double) selectedCrossOver.size() / (double) populationSize;
			if (probSelect > prob && ratio < crossOverPercent)
			{
				selectedCrossOver.push_back(population[itr]);
				population.erase(population.begin() + itr);
			}
		}

		//CrossOver -- Single Point
		//use selectedCrossOver vector as parents to create and add children to population.
		individualCount += selectedCrossOver.size();
		std::vector<Hypothesis> childPopulation = crossOverFunction(selectedCrossOver);
		population.insert(population.end(), childPopulation.begin(), childPopulation.end());

		//Mutations
		mutationFunction(population, mutationRate, wordLength);

		//Run fitness on pop.
		averageFitness = 0;
		maxThreshold = 0;

		for (auto itr = begin(population); itr != end(population); ++itr)
		{
			if (fitnessType == 1)
				fitnessFunction(*itr, wordLength);
			else if (fitnessType == 2)
				fitnessFunction(*itr, wordLength * (ALPHABET_END - ALPHABET_START));
			if ((*itr).fitness > maxThreshold)
			{
				maxThreshold = (*itr).fitness;
				best = (*itr);
			}
			averageFitness += (*itr).fitness;
		}

		averageFitness = averageFitness / populationSize;
		std::sort(begin(population), end(population), sortFitness);
		loops++;
	}
	auto endTime = high_resolution_clock::now();
	experimentTime = duration_cast<std::chrono::milliseconds>(endTime - startTime).count();
	hypothesisIterations = loops;
	std::cout << "\n\nFinished Running Experiment.\n";
	std::cout << "\nFinal Population:\n";
}

double Population::runBoltzmanDistribution(Hypothesis h, double fj)
{
	double e = 2, T = temperature, fi = h.fitness;
	//fitness proportionate
	return (pow(e, (fi / T))) / (pow(e, (1 / T)));
}