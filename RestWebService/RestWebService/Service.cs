using System;
using System.IO;
using System.Xml;
using System.Xml.Serialization;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RestWebService
{
    public class Service:IHttpHandler
    {
        #region Private Members

        private Objects.Employee emp;
        private DAL.DAL dal;
        private string connString;
        private ErrorHandler.ErrorHandler errHandler;
        private Objects.ZipCode zip;
        private Objects.Address address;

        #endregion

        #region Handler
        bool IHttpHandler.IsReusable
        {
            get { throw new NotImplementedException(); }
        }

        void IHttpHandler.ProcessRequest(HttpContext context)
        {
            try
            {
                string url = Convert.ToString(context.Request.Url);
                connString = "Data Source=Zack;Initial Catalog=Company;Integrated Security=True";
                dal = new DAL.DAL(connString);
                
                errHandler = new ErrorHandler.ErrorHandler();

                //Handling CRUD
                switch (context.Request.HttpMethod)
                {
                    case "GET":
                        //Perform READ Operation                   
                        READ(context);
                        break;
                    case "POST":
                        //Perform CREATE Operation
                        CREATE(context);
                        break;
                    case "PUT":
                        //Perform UPDATE Operation
                        UPDATE(context);
                        break;
                    case "DELETE":
                        //Perform DELETE Operation
                        DELETE(context);
                        break;
                    default:
                        break;
                }
            }
            catch (Exception ex)
            {
                
                errHandler.ErrorMessage = ex.Message.ToString();
                context.Response.Write(errHandler.ErrorMessage);                
            }
        }

        #endregion Handler

        #region CRUD Functions
        /// <summary>
        /// GET Operation
        /// </summary>
        /// <param name="context"></param>
        private void READ(HttpContext context)
        {
            //HTTP Request - //http://server.com/virtual directory/employee?id={id}
            //http://localhost/RestWebService/employee      //.net/server.php?city=<city>&state=<state>
            try
            {
                string path = context.Request.Path.Substring(context.Request.Path.LastIndexOf('/') + 1);

                if (path == "employee")
                    readEmployee(context);
                else if (path == "zip")
                    readAddress(context);
            }
            catch (Exception ex)
            {
                WriteResponse("\nError in READ\n");
                errHandler.ErrorMessage = dal.GetException();
                errHandler.ErrorMessage = ex.Message.ToString();
            }            
        }
        /// <summary>
        /// POST Operation
        /// </summary>
        /// <param name="context"></param>
        private void CREATE(HttpContext context)
        {
            try
            {
                // HTTP POST sends name/value pairs to a web server
                // dat is sent in message body

                //The most common use of POST, by far, is to submit HTML form data to CGI scripts.
                
                // This Post task handles cookies and remembers them across calls. 
                // This means that you can post to a login form, receive authentication cookies, 
                // then subsequent posts will automatically pass the correct cookies. 
                // The cookies are stored in memory only, they are not written to disk and 
                // will cease to exist upon completion of the build.
              
                // The POST Request structure - Typical POST Request
                // POST /path/script.cgi HTTP/1.0
                // From: frog@jmarshall.com
                // User-Agent: HTTPTool/1.0
                // Content-Type: application/x-www-form-urlencoded
                // Content-Length: 32

                // home=Cosby&favorite+flavor=flies

                // Extract the content of the Request and make a employee class
                // The message body is posted as bytes. read the bytes            
            }
            catch (Exception ex)
            {

                WriteResponse("Error in CREATE");
                errHandler.ErrorMessage = dal.GetException();
                errHandler.ErrorMessage = ex.Message.ToString();                
            }
        }
        /// <summary>
        /// PUT Operation
        /// </summary>
        /// <param name="context"></param>
        private void UPDATE(HttpContext context)
        {
            //The PUT Method

            // The PUT method requests that the enclosed entity be stored
            // under the supplied URL. If the URL refers to an already 
            // existing resource, the enclosed entity should be considered
            // as a modified version of the one residing on the origin server. 
            // If the URL does not point to an existing resource, and that 
            // URL is capable of being defined as a new resource by the 
            // requesting user agent, the origin server can create the 
            // resource with that URL.
            // If the request passes through a cache and the URL identifies 
            // one or more currently cached entities, those entries should 
            // be treated as stale. Responses to this method are not cacheable.


            // Common Problems
            // The PUT method is not widely supported on public servers 
            // due to security concerns and generally FTP is used to 
            // upload new and modified files to the webserver. 
            // Before executing a PUT method on a URL, it may be worth 
            // checking that PUT is supported using the OPTIONS method.
            
            try
            {
                // context.Response.Write("Update");
                // Read the data in the message body of the PUT method
                // The code expects the employee class as data to be updated

            }
            catch (Exception ex)
            {

                WriteResponse("Error in CREATE");
                errHandler.ErrorMessage = dal.GetException();
                errHandler.ErrorMessage = ex.Message.ToString();                
            }
        }
        /// <summary>
        /// DELETE Operation
        /// </summary>
        /// <param name="context"></param>
        private void DELETE(HttpContext context)
        {
            try
            {
               
            }
            catch (Exception ex)
            {
                
                WriteResponse("Error in CREATE");
                errHandler.ErrorMessage = dal.GetException();
                errHandler.ErrorMessage = ex.Message.ToString();                
            }
        }


        //HTTP Request Type - GET"
        //Performing Operation - READ"
        //Data sent via query string
        //POST - Data sent as name value pair and resides in the <form section> of the browser

        private void readEmployee(HttpContext context)
        {
            try
            {
                emp = null;
                int employeeCode = Convert.ToInt16(context.Request["id"]);
                emp = dal.GetEmployee(employeeCode);
                if (emp == null)
                    context.Response.Write(employeeCode + "\nNo Employee Found\n");

                string serializedEmployee = Serialize(emp);

                context.Response.ContentType = "text/xml";
                if (emp == null)
                    WriteResponse("No Employee Data Found for Id: " + employeeCode);
                else  WriteResponse(serializedEmployee);
            }
            catch (Exception ex)
            {
                WriteResponse("\nError in Employee READ\n" + ex.Message.ToString());
                errHandler.ErrorMessage = dal.GetException();
                errHandler.ErrorMessage = ex.Message.ToString();
            }   
        }

        private void readAddress(HttpContext context)
        {
            try
            {
                string qString = context.Request.QueryString.ToString();

                if (qString.Contains("code="))
                    readZip(context);
                else if (qString.Contains("city=") && qString.Contains("&") && qString.Contains("state="))
                    readCityState(context);
            }
            catch (Exception ex)
            {
                WriteResponse("\nError in Address READ\n" + ex.Message.ToString());
                errHandler.ErrorMessage = dal.GetException();
                errHandler.ErrorMessage = ex.Message.ToString();
            }
        }

        private void readZip(HttpContext context)
        {
            try
            {
                zip = null;
                int zipCode = Convert.ToInt32(context.Request["code"]);
                zip = dal.GetZipCode(zipCode);

                //string serializedZipCode = SerializeZipCode(zip);
                string serializedZipCode = "<?xml version=\"1.0\" encoding=\"utf-8\"?><ZipCode>";

                context.Response.ContentType = "text/xml";
                if (zip == null)
                {
                    serializedZipCode = serializedZipCode + "<Zip>" + zipCode + "</Zip>" + "<Error> No Zip Data found </Error></ZipCode>";
                    WriteResponse(serializedZipCode);
                }
                    
                else
                {
                    serializedZipCode = serializedZipCode + "<Zip>" + zip.Zip.ToString()+"</Zip><City>" + zip.City + "</City><State>" + zip.State +" </State></ZipCode>";
                    WriteResponse(serializedZipCode);
                }
            }
            catch (Exception ex)
            {
                WriteResponse("\nError in Zip READ\n" + ex.Message.ToString());
                errHandler.ErrorMessage = dal.GetException();
                errHandler.ErrorMessage = ex.Message.ToString();
            } 
        }

        private void readCityState(HttpContext context)
        {
            try
            {
                address = null;
                string city = context.Request["city"].ToString();
                string state = context.Request["state"].ToString();

                address = dal.getCityState(city, state);

                //string serializedAddressCode = SerializeAddressCode(address);
                string serializedAddressCode = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Address>";
                context.Response.ContentType = "text/xml";
                if (address == null)
                {
                    serializedAddressCode = serializedAddressCode + "<City>" + city + "</City>" + "<State>" + state + "</State>" + "<Error> No Address Data found </Error></Address>";
                    WriteResponse(serializedAddressCode);
                }

                else
                {
                    serializedAddressCode = serializedAddressCode + "<City>" + address.City + "</City><State>" + address.State + "</State><Zips>";
                    foreach(int element in address.Zips)
                        serializedAddressCode = serializedAddressCode + "<int>" + element.ToString() + "</int>";
                    serializedAddressCode = serializedAddressCode + "</Zips></Address>";
                    WriteResponse(serializedAddressCode);
                }
            }
            catch (Exception ex)
            {
                WriteResponse("\nError in cityState READ\n" + ex.Message.ToString());
                errHandler.ErrorMessage = dal.GetException();
                errHandler.ErrorMessage = ex.Message.ToString();
            } 
        }

        #endregion

        #region Utility Functions
        /// <summary>
        /// Method - Writes into the Response stream
        /// </summary>
        /// <param name="strMessage"></param>
        private static void WriteResponse(string strMessage)
        {
            HttpContext.Current.Response.Write(strMessage);            
        }

        /// <summary>
        /// Method - Deserialize Class XML
        /// </summary>
        /// <param name="xmlByteData"></param>
        /// <returns></returns>
        private Objects.Employee Deserialize(byte[] xmlByteData)
        {
            try
            {
                XmlSerializer ds = new XmlSerializer(typeof(Objects.Employee));
                MemoryStream memoryStream = new MemoryStream(xmlByteData);
                Objects.Employee emp = new Objects.Employee();
                emp = (Objects.Employee)ds.Deserialize(memoryStream);
                return emp;
            }
            catch (Exception ex)
            {
                
                errHandler.ErrorMessage = dal.GetException();
                errHandler.ErrorMessage = ex.Message.ToString();
                throw;
            }
        }

        /// <summary>
        /// Method - Serialize Class to XML
        /// </summary>
        /// <param name="emp"></param>
        /// <returns></returns>
        private String Serialize(Objects.Employee emp)
        {
            try
            {
                String XmlizedString = null;
                XmlSerializer xs = new XmlSerializer(typeof(Objects.Employee));
                //create an instance of the MemoryStream class since we intend to keep the XML string 
                //in memory instead of saving it to a file.
                MemoryStream memoryStream = new MemoryStream();
                //XmlTextWriter - fast, non-cached, forward-only way of generating streams or files 
                //containing XML data
                XmlTextWriter xmlTextWriter = new XmlTextWriter(memoryStream, Encoding.UTF8);
                //Serialize emp in the xmlTextWriter
                xs.Serialize(xmlTextWriter, emp);
                //Get the BaseStream of the xmlTextWriter in the Memory Stream
                memoryStream = (MemoryStream)xmlTextWriter.BaseStream;
                //Convert to array
                XmlizedString = UTF8ByteArrayToString(memoryStream.ToArray());
                return XmlizedString;
            }
            catch (Exception ex)
            {
                errHandler.ErrorMessage = ex.Message.ToString();
                throw;
            }           
        }

        private String SerializeZipCode(Objects.ZipCode zip)
        {
            try
            {
                String XmlizedString = null;
                XmlSerializer xs = new XmlSerializer(typeof(Objects.ZipCode));
                //create an instance of the MemoryStream class since we intend to keep the XML string 
                //in memory instead of saving it to a file.
                MemoryStream memoryStream = new MemoryStream();
                //XmlTextWriter - fast, non-cached, forward-only way of generating streams or files 
                //containing XML data
                XmlTextWriter xmlTextWriter = new XmlTextWriter(memoryStream, Encoding.UTF8);
                //Serialize emp in the xmlTextWriter
                xs.Serialize(xmlTextWriter, zip);
                //Get the BaseStream of the xmlTextWriter in the Memory Stream
                memoryStream = (MemoryStream)xmlTextWriter.BaseStream;
                //Convert to array
                XmlizedString = UTF8ByteArrayToString(memoryStream.ToArray());
                return XmlizedString;
            }
            catch (Exception ex)
            {
                WriteResponse("\nError in Zip SERIALIZE\n" + ex.Message.ToString());
                errHandler.ErrorMessage = ex.Message.ToString();
                throw;
            }  
        }

        private String SerializeAddressCode(Objects.Address address)
        {
            try
            {
                String XmlizedString = null;
                XmlSerializer xs = new XmlSerializer(typeof(Objects.Address));
                //create an instance of the MemoryStream class since we intend to keep the XML string 
                //in memory instead of saving it to a file.
                MemoryStream memoryStream = new MemoryStream();
                //XmlTextWriter - fast, non-cached, forward-only way of generating streams or files 
                //containing XML data
                XmlTextWriter xmlTextWriter = new XmlTextWriter(memoryStream, Encoding.UTF8);
                //Serialize emp in the xmlTextWriter
                xs.Serialize(xmlTextWriter, address);
                //Get the BaseStream of the xmlTextWriter in the Memory Stream
                memoryStream = (MemoryStream)xmlTextWriter.BaseStream;
                //Convert to array
                XmlizedString = UTF8ByteArrayToString(memoryStream.ToArray());
                return XmlizedString;
            }
            catch (Exception ex)
            {
                WriteResponse("\nError in Zip SERIALIZE\n" + ex.Message.ToString());
                errHandler.ErrorMessage = ex.Message.ToString();
                throw;
            }  
        }

        /// <summary>
        /// To convert a Byte Array of Unicode values (UTF-8 encoded) to a complete String.
        /// </summary>
        /// <param name="characters">Unicode Byte Array to be converted to String</param>
        /// <returns>String converted from Unicode Byte Array</returns>
        private String UTF8ByteArrayToString(Byte[] characters)
        {
            UTF8Encoding encoding = new UTF8Encoding();
            String constructedString = encoding.GetString(characters);
            return (constructedString);
        }

        #endregion
    }
}
