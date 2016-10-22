#pragma once
#include <chrono>
#include "geneticAlgs.h"

class Population
{
public:
	int populationSize;
	int wordLength;
	double fitnessThreshold;
	double crossOverPercent;
	double mutationRate;
	double temperature;
	double fitnessType;
	long long experimentTime;
	int hypothesisIterations;
	unsigned long long individualCount;
	
	std::vector<Hypothesis> population;
	
	void (*fitnessFunction)(Hypothesis&, double);
	std::vector<Hypothesis> (*crossOverFunction)(std::vector<Hypothesis>&);
	void (*mutationFunction)(std::vector<Hypothesis>&, double, int);

	Population();
	Population(std::string);
	void setupDefaults();
	void runExperiment();
	double runBoltzmanDistribution(Hypothesis, double);
	
	friend std::ostream& operator<<(std::ostream& os, Population const* pop)
	{

		double totalFitness = 0;
		for (size_t i = 0; i < pop->population.size(); ++i)
		{
			os << pop->population[i];
			totalFitness += pop->population[i].fitness;
		}
		os << "total fitness amount: " << totalFitness << std::endl;
		
		os << "\nString Decoded: " << GeneticAlgs::codeString << std::endl;
		os << "Population Size: " << pop->populationSize << std::endl;
		os << "Code Word Lengths: " << pop->wordLength << std::endl;
		os << "Time Taken: " << (double) (pop->experimentTime / 1000.0) << "s" << std::endl;
		os << "Hypothesis Iterations: " << pop->hypothesisIterations << std::endl;
		os << "Individuals Expanded: " << pop->individualCount << std::endl;
		return os;
	}
private:

};