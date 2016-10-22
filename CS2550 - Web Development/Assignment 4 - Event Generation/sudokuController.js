//Region: The Controller

var sudoku = sudoku || {};
sudoku.sController = sudoku.sController || {};

//animation variables
sudoku.heroImg, sudoku.heroDivWidth;
sudoku.heroLeft;
sudoku.margin = 10;

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
		//this function is an updateCell.
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

sudoku.sController.updateCell = function(cell, modelContents)
{
	cell.innerHTML = modelContents.text;
	
	if (modelContents.name == "predetNum")
	{
		if (!(cell.classList.contains("predetNum")))
			cell.classList.add("predetNum");
	}
	else if (modelContents.name == "userNum")
	{
		if (!(cell.classList.contains("userNum")))
			cell.classList.add("userNum");
	}
	//alert("cell contents are: " + cell.innerHTML + "\nmodels contents are: " + model.name + " " + model.text + "\n");
};

sudoku.sController.checkRow = function(model, cell, row, col)
{
	//check if other numbers on this row has this number.
	for (var i = 0; i < sudoku.COLUMNS; i++)
	{
		if (i != col)
		{
			var text = "";
			
			if (cell.classList.contains("userNum"))
				text = cell.lastChild.value;
			else text = cell.innerHTML;
			
			if (model[row][i].text == text && text != "")
			{
				//need to set the error classlist for cell if it isn't set.
				if ((!(cell.classList.contains("userError"))) && model[row][col].name == "userNum")
				{
					cell.classList.add("userError");
					var cellsField = cell.lastChild;
					cellsField.classList.add("userError");
					return false;
				}
			}
		}
	}
	return true;
};

sudoku.sController.checkColumn = function(model, cell, row, col)
{
	//check if other numbers on this column has this number.
	for (var j = 0; j < sudoku.ROWS; j++)
	{
		if (j != row)
		{
			var text = "";
			
			if (cell.classList.contains("userNum"))
				text = cell.lastChild.value;
			else text = cell.innerHTML;
			
			if (model[j][col].text == text && text != "")
			{
				//need to set the error classlist for cell if it isn't set.
				if ((!(cell.classList.contains("userError"))) && model[row][col].name == "userNum")
				{
					cell.classList.add("userError");
					var cellsField = cell.lastChild;
					cellsField.classList.add("userError");
					return false;
				}
			}
		}
	}
	return true;
};

sudoku.sController.checkCell = function(model, cell, row, col)
{
	//first unset the error.
	if (cell.classList.contains("userError"))
	{
		cell.classList.remove("userError");
		var cellsField = cell.lastChild;
		cellsField.classList.remove("userError");
	}
	
	//check the row
	var check = this.checkRow(model, cell, row, col);
	if (check == false)
		return false;
	else
	{
		//check the column
		check = this.checkColumn(model, cell, row, col);
		if (check == false)
			return false;
		else
		{
			//check the block, return check afterwards.
		}
	}
	return true;
};

//function checkBlock(mode, cell, row, col){}

sudoku.sController.checkSolution = function()
{
	//check all cells
	var table = document.getElementById("generateSudokuBoard");
	var solutionObject = {
		solution: true,
		numberIncorrect: 0,
		numberCorrect: 0,
		wrongRow: [],
		wrongColumn: []
	};
	
	for (var q = 0; q < sudoku.ROWS; q++)
	{
		for (var w = 0; w < sudoku.COLUMNS; w++)
		{
			var gridCell = table.rows[q].cells[w];
			var check = this.checkCell(sudoku.sModel.model, gridCell, q, w);
			
			if (sudoku.sModel.model[q][w].name == "userNum")
			{
				gridCell.style.backgroundColor = "";
				var cellsField = gridCell.lastChild;
				cellsField.style.backgroundColor = "";
				
			}
			else gridCell.style.backgroundColor = "";
			
			if (check == false)
			{
				solutionObject.solution = false;
				solutionObject.wrongRow[solutionObject.numberIncorrect] = q;
				solutionObject.wrongColumn[solutionObject.numberIncorrect] = w;
				solutionObject.numberIncorrect += 1;
			}
			
			if (sudoku.sModel.model[q][w].text == "")
				solutionObject.numberCorrect += 1;
		}
	}
	return solutionObject;
};

sudoku.sController.checkPuzzle = function()
{
	var puzzleSolved = this.checkSolution();
	
	//output information of solution object to div.
	var outputter = document.getElementById("lastModifiedCell");
	
	if (puzzleSolved.solution == true && puzzleSolved.numberCorrect > 0)
		outputter.innerHTML = "Puzzle is correct so far.<br>" + puzzleSolved.numberCorrect + " spaces with no value.";
	else if (puzzleSolved.solution == true && puzzleSolved.numberCorrect == 0)
	{
		//if no errors and no spaces left, the puzzle is solved. Stop the timer.
		outputter.innerHTML = "Puzzle solved in: No timer set up yet.";
	}
	else
	{
		outputter.innerHTML = "Puzzle is incorrect and has " + puzzleSolved.numberIncorrect + " errors. " + puzzleSolved.numberCorrect + " spaces with no value.";
		for (var i = 0; i < puzzleSolved.numberIncorrect; i++)
			outputter.innerHTML += "<br> Error at: " + puzzleSolved.wrongRow[i] + ", " + puzzleSolved.wrongColumn[i] + ".";
	}
};

sudoku.sController.newPuzzle = function()
{
	var selectedList = document.getElementById("newPuzzles");
	var selectedItem = selectedList.options[selectedList.selectedIndex].text;
	
	//output to div what we selected.
	var outputter = document.getElementById("lastModifiedCell");
	outputter.innerHTML = selectedItem + " puzzle difficulty option selected. Ajax calls to setup a new puzzle will happen later.";
};

sudoku.sController.startMove = function()
{
    sudoku.heroImg = document.getElementById("shImg");

    var heroDiv = document.getElementById("superhero");
    sudoku.heroDivWidth = heroDiv.offsetWidth;

    sudoku.heroLeft = 0;
    setTimeout(sudoku.sController.moveHeroRight, 20);
};

sudoku.sController.moveHeroRight = function()
{
    sudoku.heroLeft += 25;
    sudoku.heroImg.style.left = sudoku.heroLeft + "px";

    if (sudoku.heroLeft < sudoku.heroDivWidth - sudoku.heroImg.width - sudoku.margin)
		setTimeout(sudoku.sController.moveHeroRight, 20);
	else
		setTimeout(sudoku.sController.moveHeroLeft, 20);
}

sudoku.sController.moveHeroLeft = function()
{
	sudoku.heroLeft -= 5;
	sudoku.heroImg.style.left = sudoku.heroLeft + "px";
	
	if (sudoku.heroLeft > 610)
		setTimeout(sudoku.sController.moveHeroLeft, 20);
};

//End of Region: Controller