RESTful web app - Zipcode lookup

Usage:

*Place args directly into URL

	- Lookup by zipcode
		# http://zipcode.azurewebsites.net/server.php?zipcode=<zipcode>
		# zipcode can include leading zeroes : 02861 == 2861
		# returns city and state in browser window: [city, state]
		
	- Lookup by city and state
		# http://zipcode.azurewebsites.net/server.php?city=<city>&state=<state>
		# state is the abbreviated version: Utah -> UT
		# returns zipcode(s)
		
Tools Used:
	- PHP (Connecting to and Retrieving information from database)
	- MySQL (Stores zipcode data retrieved from: http://simplemaps.com/resources/us-cities-data)
	- Microsoft Azure (Deploying and managing app)