// Author:		Zack Austin
// Class:		CS 3370
// Date:		3/9/14
// Program:		XML Employee Parsing - String and Stream Processing

#include "employee.h"
#include <fstream>
#include <vector>
#include <memory>

using namespace std;

int main(int argc, char* argv[])
{
	//1) Obtain the name of an XML file to read from the command line (argv[1]). Print an error message and halt
	//the program if there is no command-line argument provided.

	if (argc > 1)
	{
		fstream cmdLineXML(argv[1], ifstream::in, ios::binary);

		//2) Read each XML record in the file by repeatedly calling Employee::fromXML, which creates an Employee
		//object on-the-fly, and store it in a vector of Employee pointers (you may use smart pointers).

		vector<unique_ptr<Employee>> emps;
		try
		{
			while (cmdLineXML)
				emps.push_back(unique_ptr<Employee>(Employee::fromXML(cmdLineXML)));
		}
		catch (runtime_error& it)
		{
			cout << it.what();
			return 1;
		}

		//3) Loop through your vector and print to cout the Employee data for each object (using the display member
		//function).

		for (size_t i = 0; i < emps.size(); i++)
			emps[i]->display(cout);

		//4) The next step is to create a new file of fixed-length Employee records. This is explained below. Write the
		//records for each employee to your new file (call it “employee.bin”) in the order they appear in your vector.
		//Open this file as an fstream object with both read and write capability, and in binary format.

		fstream fixedLengthRecords("employee.bin", ios::trunc | ios::in | ios::out | ios::binary);

		for (size_t i = 0; i < emps.size(); i++)
			emps[i]->write(fixedLengthRecords);

		//5) Clear your vector in preparation for the next step.

		emps.clear();
		fixedLengthRecords.seekp(ios_base::beg);

		//6) Traverse the file by repeated calls to Employee::read, filling your newly emptied vector with Employee
		//pointers for each record read.

		while (fixedLengthRecords)
			emps.push_back(unique_ptr<Employee>(Employee::read(fixedLengthRecords)));

		//7) Loop through your vector and print to cout an XML representation of each Employee using
		//Employee::toXML.

		for (size_t i = 0; i < emps.size(); i++)
			emps[i]->toXML(cout);

		//8) Search the file for the Employee with id 12345 using Employee::retrieve.
		
		Employee* retrievedEmp = Employee::retrieve(fixedLengthRecords, 12345);

		//9) Change the salary for the retrieved object to 150000.0
		if (retrievedEmp != nullptr)
		{
			retrievedEmp->setSalary(150000.0);

			//10) Write the modified Employee object back to file using Employee::store

			retrievedEmp->store(fixedLengthRecords);

			//11) Retrieve the object again by id (12345) and print its salary to verify that the file now has the updated salary.

			retrievedEmp = Employee::retrieve(fixedLengthRecords, 12345);
			cout << "\nFound:\n";
			retrievedEmp->display(cout);
			delete retrievedEmp;
		}
		//12) Create a new Employee object of your own with a new, unique id, along with other information.

		cout << "Creating Employee with own unique id '54321' and other information...\n";
		Employee* newEmp = new Employee("Gerald Doh", 54321, "9000 N. 9000 W. Mayan Street", "Charming", "California", "USA", "450-054-3433", 9000);

		//13) Store it in the file using Employee::store.

		newEmp->store(fixedLengthRecords);
		delete newEmp;

		//14) Retrieve the record with Employee::retrieve and display it to cout.

		auto retrieveRecord = Employee::retrieve(fixedLengthRecords, 54321);
		cout << "\nRetrieved:\n";
		retrieveRecord->display(cout);
		delete retrieveRecord;
	}
	else
	{
		cout << "No CMD Line Argument Provided.";
		return 1;
	}

	return 0;
}