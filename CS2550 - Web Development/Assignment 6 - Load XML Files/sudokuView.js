//Region: View

var sudoku = sudoku || {};

sudoku.ROWS = 9;
sudoku.COLUMNS = 9;

sudoku.sView = sudoku.sView || {};

sudoku.sView.genSudokuBoard = function(row, col)
{
	var html = "<table>";
	var initCol = col;
	var colCount = 0;
	var cellClass = "";
	var leftBorderCount = 0;
	var bottomBorderCount = 0;
	
	while (row != 0)
	{
		bottomBorderCount++;
		html += "<tr>";
		colCount = 0;
		for (i = 0; i < col; i++)
		{
			cellClass = "";
			//Every third cell bold left border class.
			if (leftBorderCount == 3)
			{
				cellClass = "boldLeftBorder";
				leftBorderCount = 0;
			}
			
			//Every third row bold bot border class.
			if (bottomBorderCount == 3 && row != 1)
			{
				cellClass += " boldBotBorder";
			}
			
			html += "<td class=\"" + cellClass + "\">" + "</td>";
			leftBorderCount++;
		}
		
		if (bottomBorderCount == 3)
		{
			bottomBorderCount = 0;
		}
		row--;
		html += "</tr>";
		leftBorderCount = 0;
	}
	
	html += "</table>";
	return html;
};

//End of Region: View