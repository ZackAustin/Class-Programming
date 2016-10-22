//Create a RESTful web service that can perform the following functions:
//1) Given a Zipcode, return the City and State for that Zipcode.
//2) Given a City and State, return the Zipcodes that are used in that City and State.

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Objects
{
    public class Employee
    {
        private string _firstName;
        private string _lastName;
        private int _empCode;
        private string _designation;

        public Employee()
        { }
        /// <summary>
        /// Property First Name
        /// </summary>
        public string FirstName
        {
            get { return _firstName; }
            set { _firstName = value; }
        }
        /// <summary>
        /// Property Last Name
        /// </summary>
        public string LastName
        {
            get { return _lastName; }
            set { _lastName = value; }
        }
        /// <summary>
        /// Property Employee Code
        /// </summary>
        public int EmpCode
        {
            get { return _empCode; }
            set { _empCode = value; }
        }
        /// <summary>
        /// Property Designation
        /// </summary>
        public string Designation
        {
            get { return _designation; }
            set { _designation = value; }
        }
        /// <summary>
        /// Method - Returns Employee Full Name
        /// </summary>
        /// <returns></returns>
        public string getEmployeeName()
        {
            string fullName = FirstName + ' ' + LastName;
            return fullName;
        }
    }

    public class ZipCode
    {
        private int _zip;
        private string _city;
        private string _state;

        public ZipCode() { }

        public int Zip
        {
            get { return _zip; }
            set { _zip = value; }
        }
        public string City
        {
            get { return _city; }
            set { _city = value; }
        }
        public string State
        {
            get { return _state; }
            set { _state = value; }
        }
    }

    public class Address
    {
        private string _city;
        private string _state;
        private List<int> _zips;

        public Address() { }

        public string City
        {
            get { return _city; }
            set { _city = value; }
        }
        public string State
        {
            get { return _state; }
            set { _state = value; }
        }

        public List<int> Zips
        {
            get { return _zips; }
            set { _zips = value; }
        }
    }
}