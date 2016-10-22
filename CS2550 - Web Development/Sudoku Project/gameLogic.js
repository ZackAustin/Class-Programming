//Game Logic -- Controller Region

var sudoku = sudoku || {};
sudoku.sController = sudoku.sController || {};

sudoku.sController.checkRow = function(model, cell, row, col)
{
	var text = model[row][col].text;

	//check if other numbers on this row has this number.
	for (var i = 0; i < sudoku.COLUMNS; i++)
	{
		if (i != col)
		{
			if (model[row][i].text == text && text != "")
			{
					//checks if the cell is user-inputted, and set's it, since an error occured in this row.
				var checkError = this.checkGridViewError(model, cell, row, col);
					if (checkError)
						return false;
			}
		}
	}
	return true;
};

sudoku.sController.checkColumn = function(model, cell, row, col)
{
	var text = model[row][col].text;

	//check if other numbers on this column has this number.
	for (var j = 0; j < sudoku.ROWS; j++)
	{
		if (j != row)
		{
			if (model[j][col].text == text && text != "")
			{
					//checks if the cell is user-inputted, and set's it, since an error occured in this column.
				var checkError = this.checkGridViewError(model, cell, row, col);
					if (checkError)
						return false;
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
	var text = model[row][col].text;
	
	for (var i = blockObject.rowObject.rs; i <= blockObject.rowObject.re; i++)
	{
		for (var j = blockObject.colObject.cs; j <= blockObject.colObject.ce; j++)
		{
			if (i != row && j != col)
			{
				if (model[i][j].text == text && text != "")
				{
					//checks if the cell is user-inputted, and set's it, since an error occured in this block.
					var checkError = this.checkGridViewError(model, cell, row, col);
					if (checkError)
						return false;
				}
			}
		}
	}
	return true;
};

sudoku.sController.checkCell = function(model, cell, row, col)
{
	var check = this.checkRow(model, cell, row, col);
	if (check == false)
		return false;
	else
	{
		check = this.checkColumn(model, cell, row, col);
		if (check == false)
			return false;
		else return this.checkBlock(model, cell, row, col);
	}
};

sudoku.sController.checkSolution = function()
{
	//check all cells, solution object is used for knowing when a puzzle is finished.
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
			this.unsetCellViewError(gridCell);
			var check = this.checkCell(sudoku.sModel.model, gridCell, q, w);
			this.resetCellBGCStyle(gridCell, q, w);
			
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