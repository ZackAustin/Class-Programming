Zipcode - RESTful Webservice
Zack Austin 2/16/16

Written using C#, ASP.net, SQL Server, ISS, and data from http://simplemaps.com/resources/us-cities-data.

examples: 	http://71.195.212.2:8087/RestWebService/zip?code=84045
		http://71.195.212.2:8087/RestWebService/zip?city=Salt Lake City&state=UT
		http://71.195.212.2:8087/RestWebService/zip?city=Salt Lake Cityyy&state=UTt

structure:  
	1) Given a Zipcode, return the City and State for that Zipcode:
		http://71.195.212.2:8087/RestWebService/zip?code=<zipCode>
		http://71.195.212.2:8087/RestWebService/zip?code=84045

	2) Given a City and State, return the Zipcodes that are used in that City and State:
		http://71.195.212.2:8087/RestWebService/zip?city=<city>&state=<state>
		http://71.195.212.2:8087/RestWebService/zip?city=Salt Lake City&state=UT
