//Region: The Controller

function updateCell(cell, modelContents)
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
}

function checkRow(model, cell, row, col)
{
	//check if other numbers on this row has this number.
	for (var i = 0; i < COLUMNS; i++)
	{
		if (i != col && model[row][i].text == cell.innerHTML && cell.innerHTML != "")
		{
			//need to set the error classlist for cell if it isn't set.
			if ((!(cell.classList.contains("userError"))) && model[row][col].name == "userNum")
			{
				cell.classList.add("userError");
				return false;
			}
		}
	}
	return true;
}

function checkColumn(model, cell, row, col)
{
	//check if other numbers on this column has this number.
	for (var j = 0; j < ROWS; j++)
	{
		if (j != row && model[j][col].text == cell.innerHTML && cell.innerHTML != "")
		{
			//need to set the error classlist for cell if it isn't set.
			if ((!(cell.classList.contains("userError"))) && model[row][col].name == "userNum")
			{
				cell.classList.add("userError");
				return false;
			}
		}
	}
	return true;
}

function checkCell(model, cell, row, col)
{
	//first unset the error.
	if (cell.classList.contains("userError"))
		cell.classList.remove("userError");
	
	//check the row
	var check = checkRow(model, cell, row, col);
	if (check == false)
		return false;
	else
	{
		//check the column
		check = checkColumn(model, cell, row, col);
		if (check == false)
			return false;
		else
		{
			//check the block, return check afterwards.
		}
	}
}

//function checkBlock(mode, cell, row, col){}

function checkSolution()
{
	//check all cells
	var table = document.getElementById("generateSudokuBoard");
	var solution = true;
	for (var q = 0; q < ROWS; q++)
	{
		for (var w = 0; w < COLUMNS; w++)
		{
			var gridCell = table.rows[q].cells[w];
			var check = checkCell(model, gridCell, q, w);
			if (check == false)
				solution = false;
		}
	}
	return solution;
}

//End of Region: Controller