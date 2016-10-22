//Grid Logic and Control -- Region: The Controller

var sudoku = sudoku || {};
sudoku.sController = sudoku.sController || {};

sudoku.puzzlesPerDifficulty = 3;
sudoku.newPuzzleRecentlyLoaded = true;
sudoku.prevPuzzleWasLoaded = false;
sudoku.currentPuzzleName = "";

sudoku.sController.saveStatusChanged = function()
{
	//occurs when either select options for new puzzles are selected.
	//This value acts as a boolean flag for whether we call the save command, and set true on newPuzzle() button clicks.
	sudoku.newPuzzleRecentlyLoaded = false;
};

sudoku.sController.onclickHandling = function()
{
	if (this.classList.contains("userError"))
	{
		this.style.backgroundColor = "Orchid";
		var cellsField = this.lastChild;
		cellsField.style.backgroundColor = "Orchid";
	}
	else
	{
		this.style.backgroundColor = "LightSteelBlue";
		var cellsField = this.lastChild;
		cellsField.style.backgroundColor = "LightSteelBlue";		
	}
	var cellRow = this.parentNode.rowIndex;
	var cellCol = this.cellIndex;
	
	//unset any other cells bgc
	var tableDiv = document.getElementById("generateSudokuBoard");
	for (var i = 0; i < sudoku.ROWS; i++)
	{
		for (var j = 0; j < sudoku.COLUMNS; j++)
		{
			if (i != cellRow || j != cellCol)
			{
				var gridCell = tableDiv.rows[i].cells[j];
				gridCell.style.backgroundColor = "";
				if (gridCell.hasChildNodes() && gridCell.classList.contains("userNum"))
				{
					var cellsField2 = gridCell.lastChild;
					cellsField2.style.backgroundColor = "";
				}
			}
		}
	}
	var outputter = document.getElementById("lastModifiedCell");
	outputter.innerHTML = "Cell from row " + this.parentNode.rowIndex + ", column " + this.cellIndex + " selected.";
};

sudoku.sController.initCell = function(cell, modelContents)
{
	if (modelContents.name == "predetNum")
	{
		if (!(cell.classList.contains("predetNum")))
			cell.classList.add("predetNum");
		cell.innerHTML = modelContents.text;
	}
	else if (modelContents.name == "userNum")
	{
		if (!(cell.classList.contains("userNum")))
			cell.classList.add("userNum");
				
		//add onclick handlers and text fields for this cell.
		var field = document.createElement("input");
		field.classList.add("userNum");
		field.value = modelContents.text;
		field.size = "1";
		field.maxLength = "1";
		field.min = "1";
		field.max = "9";
		field.classList.add("numfield");
		//this function is an update cell.
		field.onkeyup = function()
		{
			var cell = this.parentNode;
			if (this.value == "1" || this.value == "2" || this.value == "3" || this.value == "4" ||
			this.value == "5" || this.value == "6" || this.value == "7" || this.value == "8" || this.value == "9")
			{
				//valid keypress, grab parent (the cell), grab it's row and column, then set the model of that row and column to value.
				sudoku.sModel.model[cell.parentNode.rowIndex][cell.cellIndex].text = this.value;
			}
			else
			{
				//invalid keypress, let's ignore it basically by resetting the text field's value.
				this.value = "";
			}
			sudoku.sModel.model[cell.parentNode.rowIndex][cell.cellIndex].text = this.value;
			
			var outputter = document.getElementById("lastModifiedCell");
			var outText = this.value;
			if (outText == "")
				outText = "nothing";
			outputter.innerHTML = "Cell from row " + cell.parentNode.rowIndex + ", column " + cell.cellIndex + " modified to " + outText + ".";
		};
		cell.appendChild(field);
		cell.onclick = sudoku.sController.onclickHandling;
	}
};

sudoku.sController.checkGridViewError = function(model, cell, row, col)
{
	if ((!(cell.classList.contains("userError"))) && model[row][col].name == "userNum")
	{
		cell.classList.add("userError");
		var cellsField = cell.lastChild;
		cellsField.classList.add("userError");
		return true;
	}
};

sudoku.sController.unsetCellViewError = function(cell)
{
	//first unset the error, as we're going to reanalyze the grid.
	if (cell.classList.contains("userError"))
	{
		cell.classList.remove("userError");
		var cellsField = cell.lastChild;
		cellsField.classList.remove("userError");
	}
};

sudoku.sController.resetCellBGCStyle = function(gridCell, q, w)
{
	if (sudoku.sModel.model[q][w].name == "userNum")
	{
		gridCell.style.backgroundColor = "";
		var cellsField = gridCell.lastChild;
		cellsField.style.backgroundColor = "";
	}
	else gridCell.style.backgroundColor = "";
};
				
sudoku.sController.updateModel = function()
{
	var table = document.getElementById("generateSudokuBoard");
	//ensure up to date model.
	for (var i = 0; i < sudoku.ROWS; i++)
	{
		for (var j = 0; j < sudoku.COLUMNS; j++)
		{
			var gridCell = table.rows[i].cells[j];
			var text = "";
			if (gridCell.hasChildNodes() && gridCell.classList.contains("userNum"))
			{
				var cellsField = gridCell.lastChild;
				text = cellsField.value;
			}
			else text = gridCell.innerHTML;
			sudoku.sModel.model[i][j].text = text;
		}
	}
};

sudoku.sController.checkPuzzle = function()
{
	this.updateModel();
	var puzzleSolved = this.checkSolution();
	var outputter = document.getElementById("lastModifiedCell");
	
	if (puzzleSolved.solution == true && puzzleSolved.numberCorrect > 0)
		outputter.innerHTML = "No errors in puzzle so far.<br>" + puzzleSolved.numberCorrect + " spaces with no value.";
	else if (puzzleSolved.solution == true && puzzleSolved.numberCorrect == 0)
	{
		//if no errors and no spaces left, the puzzle is solved. Stop the timer.
		this.endTimer();
		var str = "How are you doing today?";
		var timer = document.getElementById("timerWrap");
		var divText = timer.innerHTML;
		var timerText = divText.split(" ");
		//ignore 1st 2.
		divText = "";
		for (var i = 2; i < timerText.length; i++)
			divText += timerText[i] + " ";
		outputter.innerHTML = "Puzzle solved in: " + divText;
		
		//make text fields read only. I did this just for copy pasting into text files for easier xml generation..
		this.endPuzzleInput();
	}
	else
	{
		outputter.innerHTML = "Puzzle is incorrect and has " + puzzleSolved.numberIncorrect + " errors. " + puzzleSolved.numberCorrect + " spaces with no value.";
		for (var i = 0; i < puzzleSolved.numberIncorrect; i++)
			outputter.innerHTML += "<br> Error at: " + puzzleSolved.wrongRow[i] + ", " + puzzleSolved.wrongColumn[i] + ".";
	}
};

sudoku.sController.endPuzzleInput = function()
{
	var table = document.getElementById("generateSudokuBoard");
	
	for (var i = 0; i < sudoku.ROWS; i++)
	{
		for (var j = 0; j < sudoku.COLUMNS; j++)
		{
			var gridCell = table.rows[i].cells[j];
			if (gridCell.hasChildNodes() && gridCell.classList.contains("userNum"))
			{
				gridCell.lastChild.disabled = true;
				gridCell.innerHTML = gridCell.lastChild.value;
				gridCell.classList.remove("userNum");
				gridCell.classList.add("predetNum");
				gridCell.onclick = null;
				sudoku.sModel.model[i][j].name = "predetNum";
				sudoku.sModel.model[i][j].changeable = false;
			}
		}
	}
};

sudoku.sController.deleteEntireTable = function()
{
	var table = document.getElementById("generateSudokuBoard");
	for (var i = sudoku.ROWS - 1; i >= 0; i--)
	{
		for (var j = sudoku.COLUMNS - 1; j >= 0; j--)
			table.rows[i].deleteCell(j);
	}
};

sudoku.sController.newPuzzle = function()
{
	this.checkIfGameWasLoaded();

	//This function is called after hitting the new puzzle button, and so the user is not longer working on a loaded puzzle.
	sudoku.prevPuzzleWasLoaded = false;

	var selectedList1 = document.getElementById("newPuzzles");
	var selectedDiffItem = selectedList1.options[selectedList1.selectedIndex].text;
	var selectedList2 = document.getElementById("newPuzzleNumber");
	var selectedNumItem = selectedList2.options[selectedList2.selectedIndex].text;
	sudoku.currentPuzzleName = selectedDiffItem + " " + selectedNumItem;

	var outputter = document.getElementById("lastModifiedCell");
	outputter.innerHTML = selectedDiffItem + " " + selectedNumItem + " option selected. Setting up Puzzle.";

	this.deleteEntireTable();
	this.endTimer();

	var fileName = "Puzzle Files/" + selectedDiffItem + " " + selectedNumItem + ".xml";
	sudoku.newPuzzleRecentlyLoaded = true;
	this.showSudokuBoard(fileName);
};

sudoku.sController.showSudokuBoard = function(xmlFile)
{
	//generate grid
	var tableDiv = document.getElementById("generateSudokuBoard");
	tableDiv.innerHTML = sudoku.sView.genSudokuBoard(sudoku.ROWS, sudoku.COLUMNS);

	sudoku.sModel.model = sudoku.sModel.createModelArray(sudoku.ROWS, sudoku.COLUMNS, xmlFile);
	
	//Initialze each cell's functionality by whether it's a predetermined or user-inputted number.
	for (var i = 0; i < sudoku.ROWS; i++)
	{
		for (var j = 0; j < sudoku.COLUMNS; j++)
		{
			var gridCell = tableDiv.rows[i].cells[j];
			this.initCell(gridCell, sudoku.sModel.model[i][j]);
		}
	}
	this.startTimer();
	this.checkForSavedGames();
};

sudoku.sController.setDefaultPuzzleSelection = function()
{
	//set defaults for browser refreshes to be 'Easy Puzzle 1', this is called on body loads.
	var selectedList1 = document.getElementById("newPuzzles");
	selectedList1.value = selectedList1.options[0].value;
	var selectedList2 = document.getElementById("newPuzzleNumber");
	selectedList2.value = selectedList2.options[0].value;
	sudoku.currentPuzzleName = "Easy Puzzle 1";
	this.showSudokuBoard('Puzzle Files/Easy Puzzle 1.xml');
};

sudoku.sController.supports_html5_storage = function()
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

//check if we need to update local storage for a game if browser is closed / reloaded.
window.onbeforeunload = function(e)
{
	sudoku.sController.checkIfGameWasLoaded();
};

//End of Region: Controller