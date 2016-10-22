//Game Logic -- Controller Region

var sudoku = sudoku || {};
sudoku.sController = sudoku.sController || {};

sudoku.sController.checkRow = function(model, cell, row, col)
{
	//check if other numbers on this row has this number.
	for (var i = 0; i < sudoku.COLUMNS; i++)
	{
		if (i != col)
		{
			var text = this.getCellText(cell);
			
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
			var text = this.getCellText(cell);
			
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

sudoku.sController.createRowObject = function(row)
{
	//rowObject is a row-index ranged object.
	var rowStart = 0, rowEnd = 0;
	if (row == 0 || row  == 3 || row == 6)
	{
		rowStart = row;
		rowEnd = row + 2;
	}
	else if (row == 1 || row == 4 || row == 7)
	{
		rowStart = row - 1;
		rowEnd = row + 1;
	}
	else
	{
		rowStart = row - 2;
		rowEnd = row;
	}
	var rowObject =
	{
		rs: rowStart,
		re: rowEnd
	};
	return rowObject;
};

sudoku.sController.createColumnObject = function(col)
{
	//columnObject is a column-index ranged object.
	var colStart = 0, colEnd = 0;
	if (col == 0 || col  == 3 || col == 6)
	{
		colStart = col;
		colEnd = col + 2;
	}
	else if (col == 1 || col == 4 || col == 7)
	{
		colStart = col - 1;
		colEnd = col + 1;
	}
	else
	{
		colStart = col - 2;
		colEnd = col;
	}
	var colObject =
	{
		cs: colStart,
		ce: colEnd
	};
	return colObject;
};

sudoku.sController.createBlockObject = function(row, col)
{
	//blockObject represents index ranges for a specific 3x3 block-check against.
	var blockObject =
	{
		rowObject: this.createRowObject(row),
		colObject: this.createColumnObject(col)
	};
	return blockObject;
};

sudoku.sController.checkBlock = function(model, cell, row, col)
{
	var blockObject = this.createBlockObject(row, col);
	
	for (var i = blockObject.rowObject.rs; i <= blockObject.rowObject.re; i++)
	{
		for (var j = blockObject.colObject.cs; j <= blockObject.colObject.ce; j++)
		{
			if (i != row && j != col)
			{
				var text = this.getCellText(cell);
				
				if (model[i][j].text == text && text != "")
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
			return this.checkBlock(model, cell, row, col);
		}
	}
};