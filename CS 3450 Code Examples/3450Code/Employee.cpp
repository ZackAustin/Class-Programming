#include "Employee.h"
#include "Salaried.h"
#include "Sales.h"
#include "Hourly.h"
#include "PartTime.h"
#include <iostream>
#include <cassert>
using namespace std;

void Employee::writeData(ostream& os)
{
   os << getType() << '\n';
   os << empNumber << '\n';
   os << address << '\n';
   os << phoneNumber << '\n';
   os << deptNumber << '\n';
   os << name << '\n';
}


void Employee::readData(istream& is)
{
   is >> empNumber; is.get();
   getline(is, address);
   getline(is, phoneNumber);
   is >> deptNumber; is.get();
   getline(is, name);
   assert(is);
}
