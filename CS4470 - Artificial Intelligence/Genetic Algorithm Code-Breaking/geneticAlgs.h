#pragma once
#include <string>
#include <iostream>
#include <vector>
#include <random>
#include <cstdlib>

int const ALPHABET_START = 97;
int const ALPHABET_END = ALPHABET_START + 7;
struct Hypothesis
{
	std::string individual;
	double fitness;
	friend std::ostream& operator<<(std::ostream& os, Hypothesis const h)
	{
		os << h.individual + " " << h.fitness << std::endl;
		return os;
	}
};

class GeneticAlgs
{
public:
	static std::string codeString;
	static void fitnessCorrectChars(Hypothesis&, double);
	static void fitnessNumberOfCharsOff(Hypothesis&, double);
	static std::vector<Hypothesis> runSinglePointCrossOver(std::vector<Hypothesis>&);
	static void runMutations(std::vector<Hypothesis>&, double, int);
private:
	GeneticAlgs(); //no initializing!
	GeneticAlgs(const GeneticAlgs&); //no copying!
	GeneticAlgs& operator=(const GeneticAlgs&); // no assignment!
};