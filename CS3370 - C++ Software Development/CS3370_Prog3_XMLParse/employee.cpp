#include "employee.h"

using namespace std;

Employee::Employee(string name, int id, string address, string city, string state, string country, string phone, double salary) : name(name), address(address), city(city), state(state), country(country), phone(phone)
{
	this->id = id;
	this->salary = salary;
}

void Employee::display(ostream& os) const // Write a readable Employee representation to a stream
{
	if (this != nullptr)
	{
		os << "id: " << this->id << '\n' << "name: " + this->name + '\n' +
			"address: " + this->address + '\n' + "city: " + this->city +
			'\n' + "state: " + this->state + '\n' + "country: " + this->country +
			'\n' + "phone: " + this->phone + '\n' + "salary: " << this->salary << '\n' << endl;
	}
}

void Employee::write(ostream& os) const // Write a fixed-length record to current file position
{
	EmployeeRec outbuf;
	strncpy(outbuf.name, this->name.c_str(), 31)[30] = '\0';
	outbuf.id = this->id;
	strncpy(outbuf.address, this->address.c_str(), 26)[25] = '\0';
	strncpy(outbuf.city, this->city.c_str(), 21)[20] = '\0';
	strncpy(outbuf.state, this->state.c_str(), 21)[20] = '\0';
	strncpy(outbuf.country, this->country.c_str(), 21)[20] = '\0';
	strncpy(outbuf.phone, this->phone.c_str(), 21)[20] = '\0';
	outbuf.salary = this->salary;
	os.write(reinterpret_cast<const char*>(&outbuf), sizeof outbuf);
}

void Employee::store(iostream& is) const // Overwrite (or append) record in (to) file
{
	int streamPos = 0;
	is.clear();
	is.seekg(ios_base::beg);
	bool stored = false;
	while (is && stored == false)
	{
		streamPos = is.tellg();
		auto tmpEmp = Employee::read(is);
		if (tmpEmp != nullptr && tmpEmp->id == id)
		{
			is.seekg(streamPos);
			this->write(is);
			stored = true;
		}
		else delete tmpEmp;
	}
	//append end
	if (stored == false)
	{
		is.clear();
		is.seekg(streamPos);
		this->write(is);
	}
}

void Employee::toXML(ostream& os) const // Write XML record for Employee
{
	if (this != nullptr)
	{
		os << "<Employee>\n\t<Name>" + this->name + "</Name>\n\t<ID>" << this->id << "</ID>\n";
		if (this->address != "")
			os << "\t<Address>" + this->address + "</Address>\n";
		if (this->city != "")
			os << "\t<City>" + this->city + "</City>\n";
		if (this->state != "")
			os << "\t<State>" + this->state + "</State>\n";
		if (this->country != "")
			os << "\t<Country>" + this->country + "</Country>\n";
		if (this->phone != "")
			os << "\t<Phone>" + this->phone + "</Phone>\n";
		if (this->salary != 0)
			os << "\t<Salary>" << this->salary << "</Salary>\n";
		os << "</Employee>" << endl;
	}
}

Employee* Employee::read(istream& is) // Read record from current file position
{
	EmployeeRec inbuf;
	is.read(reinterpret_cast<char*>(&inbuf), sizeof inbuf);
	if (is)
	{
		Employee* emp = new Employee(inbuf.name, inbuf.id, inbuf.address, inbuf.city, inbuf.state, inbuf.country, inbuf.phone, inbuf.salary);
		return emp;
	}
	else return nullptr;
}

Employee* Employee::retrieve(istream& is, int id) // Search file for record by id
{
	is.clear();
	is.seekg(ios_base::beg);
	while (is)
	{
		auto tmpEmp = Employee::read(is);
		if (tmpEmp != nullptr && tmpEmp->id == id)
			return tmpEmp;
		else delete tmpEmp;
	}
	return nullptr;
}

Employee* Employee::fromXML(istream& is) // Read the XML record from a stream
{
	string tmpTag, tmpValue, tmpName, tmpAddress, tmpCity, tmpState, tmpCountry, tmpPhone;
	int tmpID = 0;
	double tmpSalary = 0.0;

	tmpTag = Employee::getNextTag(is);
	if (_stricmp(tmpTag.c_str(), "<Employee>") == 0)
	{
		tmpTag = Employee::getNextTag(is);
		
		//get data for object.
		while ((!(_stricmp(tmpTag.c_str(), "</Employee>")) == 0 || _stricmp(tmpTag.c_str(), "<Employee>") == 0) && is)
		{
			if (_stricmp(tmpTag.c_str(), "<name>") == 0)
			{
				if (tmpName == "")
					tmpName = Employee::getNextValue(is);
				else throw runtime_error("Multiple <Name> tags");

				tmpTag = Employee::getNextTag(is);

				if (!(_stricmp(tmpTag.c_str(), "</name>") == 0))
					throw runtime_error("Missing </Name> tag");
			}
			else if (_stricmp(tmpTag.c_str(), "<id>") == 0)
			{
				if (tmpID == 0)
					tmpID = stoi(Employee::getNextValue(is));
				else throw runtime_error("Multiple <ID> tags");

				tmpTag = Employee::getNextTag(is);

				if (!(_stricmp(tmpTag.c_str(), "</ID>") == 0))
					throw runtime_error("Missing </ID> tag");
			}
			else if (_stricmp(tmpTag.c_str(), "<address>") == 0)
			{
				if (tmpAddress == "")
					tmpAddress = Employee::getNextValue(is);
				else throw runtime_error("Multiple <Address> tags");

				tmpTag = Employee::getNextTag(is);

				if (!(_stricmp(tmpTag.c_str(), "</address>") == 0))
					throw runtime_error("Missing </Address> tag");
			}
			else if (_stricmp(tmpTag.c_str(), "<city>") == 0)
			{
				if (tmpCity == "")
					tmpCity = Employee::getNextValue(is);
				else throw runtime_error("Multiple <City> tags");

				tmpTag = Employee::getNextTag(is);

				if (!(_stricmp(tmpTag.c_str(), "</city>") == 0))
					throw runtime_error("Missing </City> tag");
			}
			else if (_stricmp(tmpTag.c_str(), "<state>") == 0)
			{
				if (tmpState == "")
					tmpState = Employee::getNextValue(is);
				else throw runtime_error("Multiple <State> tags");

				tmpTag = Employee::getNextTag(is);

				if (!(_stricmp(tmpTag.c_str(), "</state>") == 0))
					throw runtime_error("Missing </State> tag");
			}
			else if (_stricmp(tmpTag.c_str(), "<country>") == 0)
			{
				if (tmpCountry == "")
					tmpCountry = Employee::getNextValue(is);
				else throw runtime_error("Multiple <Country> tags");

				tmpTag = Employee::getNextTag(is);

				if (!(_stricmp(tmpTag.c_str(), "</country>") == 0))
					throw runtime_error("Missing </Country> tag");
			}
			else if (_stricmp(tmpTag.c_str(), "<phone>") == 0)
			{
				if (tmpPhone == "")
					tmpPhone = Employee::getNextValue(is);
				else throw runtime_error("Multiple <Phone> tags");

				tmpTag = Employee::getNextTag(is);

				if (!(_stricmp(tmpTag.c_str(), "</phone>") == 0))
					throw runtime_error("Missing </Phone> tag");
			}
			else if (_stricmp(tmpTag.c_str(), "<salary>") == 0)
			{
				if (tmpSalary == 0)
					tmpSalary = stod(Employee::getNextValue(is));
				else throw runtime_error("Multiple <Salary> tags");

				tmpTag = Employee::getNextTag(is);

				if (!(_stricmp(tmpTag.c_str(), "</salary>") == 0))
					throw runtime_error("Missing </Salary> tag");
			}
			else throw runtime_error("Invalid tag: " + tmpTag);

			tmpTag = Employee::getNextTag(is);
		}
		//check for </Employee> tag.

		if (!(_stricmp(tmpTag.c_str(), "</Employee>") == 0))
			throw runtime_error("Missing </Employee> tag");

		//check if name and id were set, if so return ptr else delete it and return null.

		if (tmpName == "")
			throw runtime_error("Missing <Name> tag");
		else if (tmpID == 0)
			throw runtime_error("Missing <ID> tag");
		else //it parsed.
			return new Employee(tmpName, tmpID, tmpAddress, tmpCity, tmpState, tmpCountry, tmpPhone, tmpSalary);
	}
	else throw runtime_error("Missing <Employee> tag");

	return nullptr;
}

string Employee::getNextTag(istream& is)
{
	string tmp;
	if (!is.fail())
		getline(is, tmp, '>');
	is.unget();
	tmp += is.get();
	while (iscntrl(is.peek()) || isspace(is.peek()))
		is.get();
	return tmp;
}

string Employee::getNextValue(std::istream& is)
{
	string tmp;
	if (!is.fail())
		getline(is, tmp, '<');
	is.unget();
	while (iscntrl(is.peek()) || isspace(is.peek()))
		is.get();
	return tmp;
}