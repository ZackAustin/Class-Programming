#ifndef SALES_H
#define SALES_H

#include "Salaried.h"
using std::istream;
using std::ostream;

class EmployeeFactory;

class Sales : public Salaried
{
   typedef Employee Super;
   friend class EmployeeFactory;
      
   // Data
   double monthlySales;
   double commission;

protected:
   // Default constructor and persistence overrides
   Sales()
   {
      monthlySales = commission = 0;
   }
   EmpType getType() const
   {
      return SALES;
   }
   void writeData(ostream&);
   void readData(istream&);

public:
   Sales(int empnum, const string& addr, const string& phone, int deptnum, const string& nam,
         double monthly, double sales, double comm)
      : Salaried(empnum, addr, phone, deptnum, nam, monthly)
   {
      monthlySales = sales;
      commission = comm;
   }
   double calcSalary() const
   {
      double gross = getMonthlySalary();
      double commGross = monthlySales * commission;
      if (commGross > gross)
         gross = commGross;
      return deduct(gross);
   }
};

#endif
