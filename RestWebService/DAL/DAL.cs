using System;
using Objects;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;


//Create a RESTful web service that can perform the following functions:
//1) Given a Zipcode, return the City and State for that Zipcode.
//2) Given a City and State, return the Zipcodes that are used in that City and State.

namespace DAL
{
    public class DAL
    {
        private SqlConnection conn;
        private static string connString;
        private SqlCommand command;       
        private static List<Employee> empList;
        private static List<ZipCode> zipList;
        private static Address address;
        private ErrorHandler.ErrorHandler err;

        public DAL(string _connString)
        {
            err = new ErrorHandler.ErrorHandler();
            connString = _connString;            
        }
        /// <summary>
        /// Database INSERT - Add an Employee
        /// </summary>
        /// <param name="emp"></param>
        public void AddEmployee(Employee emp)
        {
            try
            {
                using (conn)
                {
                    //using parametirized query
                    string sqlInserString =
                    "INSERT INTO Employee (FirstName, LastName, ID, Designation) VALUES (@firstName, @lastName, @ID, @designation)";
                   
                    conn = new SqlConnection(connString);
                    
                    command = new SqlCommand();
                    command.Connection = conn;
                    command.Connection.Open();
                    command.CommandText = sqlInserString;
                    
                    SqlParameter firstNameparam = new SqlParameter("@firstName", emp.FirstName);
                    SqlParameter lastNameparam = new SqlParameter("@lastName", emp.LastName);
                    SqlParameter IDparam = new SqlParameter("@ID", emp.EmpCode);
                    SqlParameter designationParam = new SqlParameter("@designation", emp.Designation);

                    command.Parameters.AddRange(new SqlParameter[]{firstNameparam,lastNameparam,IDparam,designationParam});
                    command.ExecuteNonQuery();
                    command.Connection.Close();
                    
                }
            }
            catch (Exception ex)
            {
                err.ErrorMessage = ex.Message.ToString();
                throw;
            }
        }
        /// <summary>
        /// Database UPDATE - Update an Employee
        /// </summary>
        /// <param name="emp"></param>
        public void UpdateEmployee(Employee emp)
        {
            try
            {
                using (conn)
                {
                    string sqlUpdateString =
                    "UPDATE Employee SET FirstName=@firstName, LastName=@LastName, Designation=@Designation WHERE ID=@ID ";

                    conn = new SqlConnection(connString);

                    command = new SqlCommand();
                    command.Connection = conn;
                    command.Connection.Open();
                    command.CommandText = sqlUpdateString;

                    SqlParameter firstNameparam = new SqlParameter("@firstName", emp.FirstName);
                    SqlParameter lastNameparam = new SqlParameter("@lastName", emp.LastName);
                    SqlParameter IDparam = new SqlParameter("@ID", emp.EmpCode);
                    SqlParameter designationParam = new SqlParameter("@designation", emp.Designation);

                    command.Parameters.AddRange(new SqlParameter[] { firstNameparam, lastNameparam, IDparam, designationParam });
                    command.ExecuteNonQuery();
                    command.Connection.Close();
                }
            }
            catch (Exception ex)
            {
                err.ErrorMessage = ex.Message.ToString();
                throw;
            }
        }
       /// <summary>
       /// Database DELETE - Delete an Employee
       /// </summary>
       /// <param name="iD"></param>
        public void DeleteEmployee(int iD)
        {
            try
            {
                using (conn)
                {
                    string sqlDeleteString =
                    "DELETE FROM Employee WHERE ID=@ID ";

                    conn = new SqlConnection(connString);

                    command = new SqlCommand();
                    command.Connection = conn;
                    command.Connection.Open();
                    command.CommandText = sqlDeleteString;

                    SqlParameter IDparam = new SqlParameter("@ID", iD);
                    command.Parameters.Add(IDparam);
                    command.ExecuteNonQuery();
                    command.Connection.Close();
                }
            }
            catch (Exception ex)
            {
                err.ErrorMessage = ex.Message.ToString();
                throw;
            }
        }
        /// <summary>
        /// Database SELECT - Get an employee
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public Employee GetEmployee(int ID)
        {
            try
            {
                if (empList==null)
                {
                    empList = GetEmployees();
                }
                // enumerate through all employee list
                // and select the concerned employee
                foreach (Employee emp in empList)
                {
                    if (emp.EmpCode==ID)
                    {
                        return emp;
                    }
                }
                return null;
            }
            catch (Exception ex)
            {
                err.ErrorMessage = ex.Message.ToString();
                throw;
            }
        }
        /// <summary>
        /// Method - Get list of all employees
        /// </summary>
        /// <returns>Employee</returns>
        private List<Employee> GetEmployees()
        {
            try
            {
                using (conn)
                {
                    empList = new List<Employee>();

                    conn = new SqlConnection(connString);

                    string sqlSelectString = "SELECT * FROM Employee";
                    command = new SqlCommand(sqlSelectString, conn);
                    command.Connection.Open();

                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        Employee emp = new Employee();
                        emp.FirstName = reader[0].ToString();
                        emp.LastName = reader[1].ToString();
                        emp.EmpCode = Convert.ToInt16(reader[2]);
                        emp.Designation = reader[3].ToString();
                        empList.Add(emp);
                    }
                    command.Connection.Close();
                    return empList;
                }
            }
            catch (Exception ex)
            {
                err.ErrorMessage = ex.Message.ToString();
                throw;
            }
        }

        public ZipCode GetZipCode(int zipCode)
        {
            try
            {
                zipList = getZipCodes(zipCode);

                // enumerate through all zip list
                // and select the concerned zip
                foreach (ZipCode zip in zipList)
                {
                    if (zip.Zip == zipCode)
                    {
                        return zip;
                    }
                }
                return null;
            }
            catch (Exception ex)
            {
                err.ErrorMessage = ex.Message.ToString();
                throw;
            }
        }
        private List<ZipCode> getZipCodes(int zipCode)
        {
            try
            {
                using (conn)
                {
                    zipList = new List<ZipCode>();
                    conn = new SqlConnection(connString);
                    string sqlSelectString = "SELECT * FROM zips WHERE zip = " + zipCode.ToString() + ";";
                    command = new SqlCommand(sqlSelectString, conn);
                    command.Connection.Open();

                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        ZipCode zip = new ZipCode();
                        zip.Zip = Convert.ToInt32(reader[0]);
                        zip.State = reader[1].ToString();
                        zip.City = reader[2].ToString();
                        zipList.Add(zip);
                    }
                    command.Connection.Close();
                    return zipList;
                }
            }
            catch (Exception ex)
            {
                err.ErrorMessage = ex.Message.ToString();
                throw;
            }
        }

        public Address getCityState(string city, string state)
        {
            try
            {
                using (conn)
                {
                    bool readHappened = false;
                    address = null;
                    conn = new SqlConnection(connString);
                    string sqlSelectString = "SELECT * FROM zips WHERE city = '" + city + "' AND  state = '" + state + "'";
                    command = new SqlCommand(sqlSelectString, conn);
                    command.Connection.Open();

                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        if (readHappened == false)
                        {
                            address = new Address();
                            address.City = city;
                            address.State = state;
                            address.Zips = new List<int>();
                        }
                        readHappened = true;
                        address.Zips.Add(Convert.ToInt32(reader[0]));
                    }
                    command.Connection.Close();
                    return address;
                }
            }
            catch (Exception ex)
            {
                err.ErrorMessage = ex.Message.ToString();
                throw;
            }
        }
        /// <summary>
        /// Get Exception if any
        /// </summary>
        /// <returns> Error Message</returns>
        public string GetException()
        {
            return err.ErrorMessage.ToString();
        }
    }
}
