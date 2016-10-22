#include "Hourly.h"
#include <iostream>
using namespace std;

void Hourly::writeData(ostream& os)
{
   Super::writeData(os);
   os << hourlyRate << '\n';
   os << hoursWorked << '\n';
}

void Hourly::readData(istream& is)
{
   Super::readData(is);
   is >> hourlyRate; is.get();
   is >> hoursWorked; is.get();
}

