//Grid Logic and Control -- Region: The Controller

var sudoku = sudoku || {};
sudoku.sController = sudoku.sController || {};

sudoku.sController.onclickHandling = function()
{
	//alert("we clicked a cell!");
	//set cell bgc
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
		
		//cell.innerHTML = modelContents.text;
		
		//add onclick handlers and text fields for these cells.
		
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
				//alert(sudoku.sModel.model[cell.parentNode.rowIndex][cell.cellIndex].text);
			}
			else
			{
				//invalid keypress, let's ignore it basically by resetting the text field's value.
				this.value = "";
			}
			
			//set model text value.
			sudoku.sModel.model[cell.parentNode.rowIndex][cell.cellIndex].text = this.value;
			
			//set outputDiv of cell.
			var outputter = document.getElementById("lastModifiedCell");
			var outText = this.value;
			if (outText == "")
				outText = "nothing";
			outputter.innerHTML = "Cell from row " + cell.parentNode.rowIndex + ", column " + cell.cellIndex + " modified to " + outText + ".";
		};
		//field.width("10");
		cell.appendChild(field);
		cell.onclick = sudoku.sController.onclickHandling;
		//cell.onclick = function() {alert("clicked a cell.");};
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
	//first unset the error.
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
	
	//output information of solution object to div.
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
		
		//make text fields read only.
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
		{
			table.rows[i].deleteCell(j);
		}
	}

	//table.innerHTML = "";
	//var outputter = document.getElementById("lastModifiedCell");
	//outputter.innerHTML = table.innerHTML + " table's html";
};

sudoku.sController.newPuzzle = function()
{
	var selectedList1 = document.getElementById("newPuzzles");
	var selectedDiffItem = selectedList1.options[selectedList1.selectedIndex].text;

	var selectedList2 = document.getElementById("newPuzzleNumber");
	var selectedNumItem = selectedList2.options[selectedList2.selectedIndex].text;
	
	//output to div what we selected.
	var outputter = document.getElementById("lastModifiedCell");
	outputter.innerHTML = selectedDiffItem + " " + selectedNumItem + " option selected. Setting up Puzzle.";

	this.deleteEntireTable();
	this.endTimer();

	var fileName = "Puzzle Files/" + selectedDiffItem + " " + selectedNumItem + ".xml";

	this.showSudokuBoard(fileName);
};

sudoku.sController.showSudokuBoard = function(xmlFile)
{
	//generate grid
	var tableDiv = document.getElementById("generateSudokuBoard");
	tableDiv.innerHTML = sudoku.sView.genSudokuBoard(sudoku.ROWS, sudoku.COLUMNS);

	sudoku.sModel.model = sudoku.sModel.createModelArray(sudoku.ROWS, sudoku.COLUMNS, xmlFile);

	this.readStorage();
	
	//update all cells with model information
	for (var i = 0; i < sudoku.ROWS; i++)
	{
		for (var j = 0; j < sudoku.COLUMNS; j++)
		{
			var gridCell = tableDiv.rows[i].cells[j];
			this.initCell(gridCell, sudoku.sModel.model[i][j]);
		}
	}
	
	//mockup and test if model loads in correctly. Will call this function on button clicks.
	//sudoku.sController.checkSolution();
	this.startMove();
	this.startTimer();
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

sudoku.sController.readStorage = function()
{
	var dataDiv = document.getElementById("usernameStorage");
	if (this.supports_html5_storage)
	{
		if (localStorage.getItem("cs2550timestamp") === null){}
		else dataDiv.innerHTML = "Welcome " + localStorage["cs2550timestamp"];
	}
}

sudoku.sController.removeStorage = function()
{
	var dataDiv = document.getElementById("usernameStorage");
	if (this.supports_html5_storage)
	{
		localStorage.removeItem("cs2550timestamp");
		dataDiv.innerHTML = "Welcome " + localStorage["cs2550timestamp"];
	}
}

//End of Region: Controller