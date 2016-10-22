#include "sas.h"
#include <stdexcept>

void SAS::push(SAR* newSar)
{
	sas.push_back(newSar);
}

SAR* SAS::pop()
{
	SAR* topOfStack = nullptr;
	if (sas.size() > 0)
	{
		topOfStack = sas.back();
		sas.pop_back();
	}
	else throw std::runtime_error("Semantic action stack error: underflow.");

	return topOfStack;
}