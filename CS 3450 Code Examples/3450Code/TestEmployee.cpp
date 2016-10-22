#include <iostream>
#include <fstream>
#include <cstddef>      // For size_t
#include <cassert>
#include "Employee.h"   // redundant, but good form
#include "Salaried.h"
#include "Sales.h"
#include "Hourly.h"
#include "PartTime.h"
#include "EmployeeFactory.h"
using namespace std;

void storeEmployee(ostream& os, Employee* pEmp)
{
   pEmp->store(os);
   delete pEmp;
}

void makeDatabase(const char* fname)
{
   // Open output file
   ofstream outf(fname);
   assert(outf);
   
   // Write placeholder for counter
   outf << 0 << endl;

   // Create each kind of employee
   storeEmployee(outf, new Salaried(1, "1600 Pennsylvania Ave.", "123-4567", 100, "Laura Bush", 50000));
   storeEmployee(outf, new Sales(2, "34 Drury Lane", "890-1234", 200, "Muffin Man", 40000, 165000, .4));
   storeEmployee(outf, new Hourly(3, "27 Downing Street", "567-8901", 300, "Tony Blair", 34.50, 50));
   storeEmployee(outf, new PartTime(4, "7734 Upside Down Street", "234-5678", 400, "Mephistopheles", 22, 30, 25));

   // Rewind and store actual count
   outf.seekp(0, ios::beg);
   outf << 4 << endl;
}

size_t readDatabase(const char* fname, Employee**& emps)
{
   ifstream inf(fname);
   EmployeeFactory factory(inf);
   assert(inf);
   size_t nemps;
   inf >> nemps;
   emps = new Employee*[nemps];
   for (size_t i = 0; i < nemps; ++i)
      emps[i] = factory.retrieve();
   return nemps;
}

void printCheck(const Employee* emp)
{
   cout.setf(ios::fixed, ios::floatfield);
   cout.precision(2);
   cout.setf(ios::showpoint);
   cout << "Employee #" << emp->getEmpNumber() << ": " << emp->getName() << endl;
   cout << emp->getAddress() << " " << emp->getPhoneNumber() << endl;
   cout << "Department: " << emp->getDeptNumber() << endl;
   cout << "Amount of this check: $" << emp->calcSalary() << endl;
}

void doPayroll(Employee* emps[], size_t nemps)
{
   for (size_t i = 0; i < nemps; ++i)
   {
      printCheck(emps[i]);
      cout << endl;
   }
}

void freeDatabase(Employee* emps[], size_t nemps)
{
   for (size_t i = 0; i < nemps; ++i)
      delete emps[i];
   delete emps;
}

int main()
{
   const char* fname = "employee2.dat";
   makeDatabase(fname);
   Employee** pEmps;
   size_t nemps = readDatabase(fname, pEmps);
   doPayroll(pEmps, nemps);
   freeDatabase(pEmps, nemps);
}

/* Output:
Employee #1: Laura Bush
1600 Pennsylvania Ave. 123-4567
Department: 100
Amount of this check: $33630.00

Employee #2: Muffin Man
34 Drury Lane 890-1234
Department: 200
Amount of this check: $44391.60

Employee #3: Tony Blair
27 Downing Street 567-8901
Department: 300
Amount of this check: $1375.69

Employee #4: Mephistopheles
7734 Upside Down Street 234-5678
Department: 400
Amount of this check: $398.75
*/

