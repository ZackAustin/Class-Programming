#ifndef PARTTIME_H
#define PARTTIME_H

#include "Hourly.h"
using std::istream;
using std::ostream;

class EmployeeFactory;

class PartTime : public Hourly
{
   typedef Hourly Super;
   friend class EmployeeFactory;

   // Data
   int maxHours;

protected:
   PartTime()
   {
      maxHours = 0;
   }
   EmpType getType() const
   {
      return PART_TIME;
   }
   void writeData(ostream&);
   void readData(istream&);

public:
   PartTime(int empnum, const string& addr, const string& phone, int deptnum, const string& nam,
            double rate, double worked, int max)
      : Hourly(empnum, addr, phone, deptnum, nam, rate, worked)
   {
      maxHours = max;
   }
   double calcSalary() const
   {
      double worked = getHoursWorked();
      double hours = (worked > maxHours) ? maxHours : worked;
      return deduct(calcHourly(hours));
   }
};

#endif

