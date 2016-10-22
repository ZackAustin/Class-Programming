#include "Sales.h"
#include <iostream>
using namespace std;

void Sales::writeData(ostream& os)
{
   Super::writeData(os);
   os << monthlySales << '\n';
   os << commission << '\n';
}

void Sales::readData(istream& is)
{
   Super::readData(is);
   is >> monthlySales; is.get();
   is >> commission; is.get();
}

