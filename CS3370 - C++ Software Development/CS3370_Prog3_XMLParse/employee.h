#include <iostream>
#include <stdexcept>
#include <string>
#include <istream>
#include <cctype>

#pragma once
class Employee
{
	std::string name;
	int id;
	std::string address;
	std::string city;
	std::string state;
	std::string country;
	std::string phone;
	double salary;
public:
	Employee(std::string, int, std::string, std::string, std::string, std::string, std::string, double);
	void display(std::ostream&) const; // Write a readable Employee representation to a stream
	void write(std::ostream&) const; // Write a fixed-length record to current file position
	void store(std::iostream&) const; // Overwrite (or append) record in (to) file
	void toXML(std::ostream&) const; // Write XML record for Employee
	static Employee* read(std::istream&); // Read record from current file position
	static Employee* retrieve(std::istream&,int); // Search file for record by id
	static Employee* fromXML(std::istream&); // Read the XML record from a stream
	static std::string getNextTag(std::istream&);
	static std::string getNextValue(std::istream&);
	void setSalary(double d) { this->salary = d; }
};

struct EmployeeRec
{
	char name[31];
	int id;
	char address[26];
	char city[21];
	char state[21];
	char country[21];
	char phone[21];
	double salary;
};