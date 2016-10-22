var login = login || {};

login.validateLogin = function()
{
    var userName = document.getElementById("username").value;
    var userData = "userName=" + userName;
	var userPassword = document.getElementById("userPassword").value;
	var passwordData = "password=" + userPassword;
	var data = userData + "&" + passwordData;
    var localRequest = new XMLHttpRequest();
	
	//userName=Harpo&password=swordfish

	//data will look like userName=Harpo&password=swordfish
	
    // PASSING false AS THE THIRD PARAMETER TO open SPECIFIES SYNCHRONOUS
    localRequest.open("POST", "http://universe.tc.uvu.edu/cs2550/assignments/PasswordCheck/check.php", false);
    localRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    localRequest.send(data);
	
	//NAME	PASSWORD
	//Harpo	swordfish
	//Groucho	horsefeathers
	//Bilbo	baggins
	//Sam	gamgee
	//Luke	usetheforce
	//asd	dsa

    // NOTE THAT THE status WILL NOT BE 200 IF THE REQUEST IS FOR A
    // LOCAL FILE.
    if (localRequest.status == 200)
	{
		var dataDiv = document.getElementById("validationText");

		// FOR MORE INFORMATION ABOUT JSON SEE http://json.org
		var responseJson = JSON.parse(localRequest.responseText);
		
		if (responseJson.result != "valid")
		{
			//invalid, error, stay on page, error message
			
			dataDiv.innerHTML = responseJson.result + " username or password.";
		}
		else
		{
			//valid, display game page.
			if (this.supports_html5_storage)
			{
				localStorage["cs2550timestamp"] = userName + " " + responseJson.timestamp;
			}
			window.open("sudokuGame.html");
			self.close();
		}
    }
}

login.supports_html5_storage = function()
{
	try
	{
		return 'localStorage' in window && window['localStorage'] !== null;
	}
	catch (e)
	{
		return false;
	}
}

