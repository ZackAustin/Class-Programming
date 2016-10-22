#include "PartTime.h"
#include <iostream>
using namespace std;

void PartTime::writeData(ostream& os)
{
   Super::writeData(os);
   os << maxHours << '\n';
}

void PartTime::readData(istream& is)
{
   Super::readData(is);
   is >> maxHours; is.get();
}

