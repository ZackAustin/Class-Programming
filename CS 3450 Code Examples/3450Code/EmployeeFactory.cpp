#include "EmployeeFactory.h"
#include "Salaried.h"
#include "Hourly.h"
#include "Sales.h"
#include "PartTime.h"
#include <iostream>
using namespace std;

Employee* EmployeeFactory::retrieve()
{
   Employee* p;
   int type;
   source >> type;

   switch(static_cast<Employee::EmpType>(type))
   {
   case Employee::SALARIED:
      p = new Salaried;
      break;
   case Employee::SALES:
      p = new Sales;
      break;
   case Employee::HOURLY:
      p = new Hourly;
      break;
   case Employee::PART_TIME:
      p = new PartTime;
      break;
   }

   p->readData(source);
   return p;
}



