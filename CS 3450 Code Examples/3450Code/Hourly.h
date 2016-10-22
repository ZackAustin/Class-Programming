#ifndef HOURLY_H
#define HOURLY_H

#include "Employee.h"
using std::istream;
using std::ostream;

class EmployeeFactory;

class Hourly : public Employee
{
   typedef Employee Super;
   friend class EmployeeFactory;

   // Data
   double hourlyRate;
   double hoursWorked;

protected:
   // Default constructor and persistence overrides
   Hourly()
   {
      hourlyRate = hoursWorked = 0;
   }
   EmpType getType() const
   {
      return HOURLY;
   }
   void writeData(ostream&);
   void readData(istream&);

   // Other important stuff
   double calcHourly(double hours) const
   {
      return hours > 40 ? ((hours-40)*1.5 + 40) * hourlyRate : hours * hourlyRate;
   }
   static double deduct(double gross)
   {
      return gross * 0.725;
   }

public:
   Hourly(int empnum, const string& addr, const string& phone, int deptnum, const string& nam,
          double rate, double worked)
      : Employee(empnum, addr, phone, deptnum, nam)
   {
      hourlyRate = rate;
      hoursWorked = worked;
   }
   double calcSalary() const
   {
      return deduct(calcHourly(hoursWorked));
   }
   double getHoursWorked() const
   {
      return hoursWorked;
   }
   double getHourlyRate() const
   {
      return hourlyRate;
   }
};


#endif
