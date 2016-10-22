#include "Salaried.h"
#include <iostream>
using namespace std;

void Salaried::writeData(ostream& os)
{
   Super::writeData(os);
   os << monthlySalary << '\n';
}

void Salaried::readData(istream& is)
{
   Super::readData(is);
   is >> monthlySalary; is.get();
}

