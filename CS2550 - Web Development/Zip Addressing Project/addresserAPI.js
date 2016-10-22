var addresser = addresser || {};

//USED THE ZIPTASTIC API

addresser.getCityState = function()
{
	var getAddress = "http://ziptasticapi.com";
	var providedZip = document.getElementById("zipField").value;
	getAddress = getAddress + "/" + providedZip;
	
	var zipObject =
	{
		country: "",
		state: "",
		city: ""
	};
	
	var request = new XMLHttpRequest();
	
	request.onreadystatechange = function()
	{
		if (request.readyState === 4)
		{
			if (request.status === 200)
			{
				//document.body.className = 'ok'; city and state
				//console.log(request.responseText);
				zipObject = JSON.parse(request.responseText);
				document.getElementById("returnText").value = "City: " + zipObject.city + "\n" + "State: " + zipObject.state;
			}
			else
			{
				//document.body.className = 'error';
			}
		}
	};
	request.open("GET", getAddress, true);
	request.send(null);
	
	
	
	//document.getElementById("returnText").value = "We did it!";
};

addresser.getZipCodes = function()
{
	//alert("here0.1");
	var applicationKey = "jYR7GXrcOiCSutRG1enXk2ZADbnV1rIlqzs7xTklcWeGq6nrlKoFNogqADlB54Wv";
	//var options ={method:"get",ContentType:"text/xml",payload:payload};
	
	var zipObject = [{
		zip: ""
	}];
	
	//alert("here1");
	//GET [url=http://www.webservicex.net/uszip.asmx/GetInfoByState?USState=<string>]http://www.webservicex.net/uszip.asmx/GetInfoByState?USState=<string>[/url]
	var request2 = new XMLHttpRequest();
	
	//var wsdl = SoapService.wsdl("http://www.webservicex.net/geoipservice.asmx?wsdl");
	//var wsdl = SoapService.wsdl("http://www.webservicex.net/uszip.asmx?WSDL");
	
	//var result = UrlFetchApp.fetch(getAddress);
	
	//Use this API to find out possible zip codes for a city.
	//Send a GET request to https://www.zipcodeapi.com/rest/<api_key>/city-zips.<format>/<city>/<state>. 
	
	var getAddress = "https://www.zipcodeapi.com/rest/" + applicationKey + "/city-zips.json/" + "Lehi" + "/" + "Ut";
	alert(getAddress);
	
	//https://www.zipcodeapi.com/rest/gEX2rYvCM8X5XH2fFjbbmSXVZooExeONTMQlKmXxuVDsCFHiZTtmMrhLPGqmVeaP/city-zips.json/Lehi/Ut
	
	//alert("here1.1");
	
	request2.onreadystatechange = function()
	{
		alert("ready state: " + reqest2.readyState);
		//alert("eh?" + request.readyState);
		//alert("status: " + request2.status);
		if (request2.readyState === 4)
		{
			alert("here1.99");
			if (request2.status === 0)
			{
				//document.body.className = 'ok'; city and state
				//console.log(request.responseText);
				alert("here2");
				/*zipObject = JSON.parse(request2.responseText);
				alert("here2.5");
				for (var ke in zipObject)
				{
					if (zipObject.hasOwnProperty(ke))
					{
						document.getElementById("returnText").value += "zip: " + zipObject[ke].zip + "\n";
					}
				}*/
				
			}
			else
			{
				//document.body.className = 'error';
			}
		}
	};
	//alert("here1.5");
	request2.open("GET", getAddress, true);
	request2.setRequestHeader("Access-Control-Allow-Origin","*");
	//alert("here1.75");
	request2.send(null);
	alert("here3");
	alert("final ready state: " + request2.readyState);
	alert("final status: " + request2.status);
};

//GET /uszip.asmx/GetInfoByCity?USCity=string HTTP/1.1

function checkRefresh()
{
	if(document.getElementById("returnText") != " " || document.getElementById("zipField").value != " " 
	|| document.getElementById("cityField").value != " " || document.getElementById("stateField").value != " ")
	{
		document.getElementById("zipField").value = " ";
		document.getElementById("returnText").value = " ";
		document.getElementById("cityField").value = " ";
		document.getElementById("stateField").value = " ";
		
		//other useful things on refreshes
		//GET http://ziptasticapi.com/48867
	}
	
} 