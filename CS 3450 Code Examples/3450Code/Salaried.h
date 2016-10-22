#ifndef SALARIED_H
#define SALARIED_H

#include "Employee.h"
using std::istream;
using std::ostream;

class EmployeeFactory;

class Salaried : public Employee
{
   typedef Employee Super;
   friend class EmployeeFactory;

   // Data
   double monthlySalary;

protected:
   // Default constructor and persistence overrides
   Salaried()
   {
      monthlySalary = 0;
   }
   EmpType getType() const
   {
      return SALARIED;
   }
   void writeData(ostream&);
   void readData(istream&);

   // Other important stuff
   static double deduct(double gross)
   {
      return gross * 0.6726;
   }

public:
   Salaried(int empnum, const string& addr, const string& phone, int deptnum, const string& nam,
            double monthly)
      : Employee(empnum, addr, phone, deptnum, nam)
   {
      monthlySalary = monthly;
   }
   double calcSalary() const
   {
      return deduct(monthlySalary);
   }
   double getMonthlySalary() const
   {
      return monthlySalary;
   }
};


#endif
