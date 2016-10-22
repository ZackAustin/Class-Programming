#ifndef EMPLOYEE_H
#define EMPLOYEE_H

#include <string>
#include <iosfwd>
using std::string;
using std::ostream;
using std::istream;

class EmployeeFactory;

class Employee
{
   int empNumber;
   string address;
   string phoneNumber;
   int deptNumber;
   string name;

protected:
   enum EmpType {SALARIED, SALES, HOURLY, PART_TIME};
   Employee()
   {
      empNumber = deptNumber = 0;
   }
   virtual EmpType getType() const = 0;
   virtual void writeData(ostream&);
   virtual void readData(istream&);
   friend class EmployeeFactory;

public:
   Employee(int empnum, const string& addr, const string& phone, int deptnum, const string& nam)
      : address(addr), phoneNumber(phone), name(nam)
   {
      empNumber = empnum;
      deptNumber = deptnum;
   }
   virtual double calcSalary() const = 0;
   int getEmpNumber() const
   {
      return empNumber;
   }
   string getAddress() const
   {
      return address;
   }
   string getPhoneNumber() const
   {
      return phoneNumber;
   }
   int getDeptNumber() const
   {
      return deptNumber;
   }
   string getName() const
   {
      return name;
   }

   // Persistence functions
   void store(ostream& os)
   {
      writeData(os);
   }
};

#endif

