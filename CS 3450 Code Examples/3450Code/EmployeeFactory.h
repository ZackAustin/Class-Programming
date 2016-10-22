#ifndef EMPLOYEE_FACTORY_H
#define EMPLOYEE_FACTORY_H

#include "Employee.h"
#include <iosfwd>

class EmployeeFactory {
   std::istream& source;
public:
   EmployeeFactory(std::istream& in) : source(in) {}
   Employee* retrieve();
};

#endif

