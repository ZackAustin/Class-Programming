//Save / Load Game Using Local Storage -- Region: The Controller

var sudoku = sudoku || {};
sudoku.sController = sudoku.sController || {};

sudoku.sController.saveGame = function()
{
	if (this.supports_html5_storage())
	{
		var saveGameObject =
		{
			mod: sudoku.sModel.model,
			sec: sudoku.timeElapsedSec,
			min: sudoku.timeElapsedMin,
			hour: sudoku.timeElapsedHour
		};
		var outputter = document.getElementById("lastModifiedCell");

		localStorage.setItem(sudoku.currentPuzzleName, JSON.stringify(saveGameObject));
		outputter.innerHTML = sudoku.currentPuzzleName + " has been saved.";
	}
	else
	{
		var outputter = document.getElementById("lastModifiedCell");
		outputter.innerHTML = "Sorry, Local Storage is disabled on this browser.";
	}
	this.checkForSavedGames();
};

sudoku.sController.checkForSavedGames = function()
{
	if (this.supports_html5_storage())
	{
		this.checkPuzzles("Easy");
		this.checkPuzzles("Medium");
		this.checkPuzzles("Hard");
	}
};

sudoku.sController.checkPuzzles = function(difficulty)
{
	if (this.supports_html5_storage())
	{
		var gameList = document.getElementById("gamelist");
		for (var i = 1; i <= sudoku.puzzlesPerDifficulty; i++)
		{
			var searchItemName = difficulty + " Puzzle " + i;
			if (localStorage.getItem(searchItemName) === null) {}
			else
			{
				var itemExists = false;
				for (var j = 0; j < gameList.length; j++)
				{
					if (gameList.options[j].value == searchItemName)
						itemExists = true;
				}
				if (!itemExists)
					gameList.appendChild(new Option(searchItemName, searchItemName));
			}
		}
	}
};

sudoku.sController.loadPuzzle = function()
{
	this.checkIfGameWasLoaded();

	if (this.supports_html5_storage())
	{
		var gameList = document.getElementById("gamelist");
		var selectedOption = gameList.options[gameList.selectedIndex].value;
		var outputter = document.getElementById("lastModifiedCell");

		if (selectedOption != "")
		{
			var loadObject = JSON.parse(localStorage.getItem(selectedOption));
			this.loadSudokuBoard(loadObject);
			//this.checkPuzzle();
			outputter.innerHTML = selectedOption + " has been loaded.";
			sudoku.prevPuzzleWasLoaded = true;
			sudoku.currentPuzzleName = selectedOption;
		}
		else outputter.innerHTML = "Please select a valid puzzle name to load from the drop down list.";
	}
	else outputter.innerHTML = "Sorry, local storage is disabled for your browser.";
};

sudoku.sController.checkIfGameWasLoaded = function()
{
	//check if we were previously working on a loaded puzzle, so we can update the timer associated with it.
	if (sudoku.prevPuzzleWasLoaded && this.supports_html5_storage())
	{
		var saveGameObject =
		{
			mod: sudoku.sModel.model,
			sec: sudoku.timeElapsedSec,
			min: sudoku.timeElapsedMin,
			hour: sudoku.timeElapsedHour
		};
		localStorage.setItem(sudoku.currentPuzzleName, JSON.stringify(saveGameObject));
		return true;
	}
	else return false;
};

sudoku.sController.loadSudokuBoard = function(loadObject)
{
	this.deleteEntireTable();
	this.endTimer();

	var tableDiv = document.getElementById("generateSudokuBoard");
	tableDiv.innerHTML = sudoku.sView.genSudokuBoard(sudoku.ROWS, sudoku.COLUMNS);

	sudoku.sModel.model = loadObject.mod;
	//Initialze each cell's functionality by whether it's a predetermined or user-inputted number.
	for (var i = 0; i < sudoku.ROWS; i++)
	{
		for (var j = 0; j < sudoku.COLUMNS; j++)
		{
			var gridCell = tableDiv.rows[i].cells[j];
			this.initCell(gridCell, sudoku.sModel.model[i][j]);
		}
	}

	sudoku.timeElapsedSec = loadObject.sec;
	sudoku.timeElapsedMin = loadObject.min;
	sudoku.timeElapsedHour = loadObject.hour;
	this.startTimer();
};

sudoku.sController.removeAllSavedGames = function()
{
	if (this.supports_html5_storage())
	{
		var outputter = document.getElementById("lastModifiedCell");
		outputter.innerHTML = "";
		this.removeGamesOfDifficulty("Easy");
		this.removeGamesOfDifficulty("Medium");
		this.removeGamesOfDifficulty("Hard");
		outputter.innerHTML += "All puzzle files of local storage have been removed.";
	}
};

sudoku.sController.removeGamesOfDifficulty = function(difficulty)
{
	if (this.supports_html5_storage())
	{
		var gameList = document.getElementById("gamelist");
		for (var i = 1; i <= sudoku.puzzlesPerDifficulty; i++)
		{
			var searchItemName = difficulty + " Puzzle " + i;
			if (localStorage.getItem(searchItemName) === null) {}
			else
			{
				localStorage.removeItem(searchItemName);
				for (var j = 0; j < gameList.length; j++)
				{
					if (gameList.options[j].value == searchItemName)
					{
						gameList.remove(j);
						var outputter = document.getElementById("lastModifiedCell");
						outputter.innerHTML += searchItemName + " has been removed.<br>";
					}
				}
			}
		}
	}
};