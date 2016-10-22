//Region: View

var ROWS = 9;
var COLUMNS = 9;

function showSudokuBoard()
{
	//generate grid
	var tableDiv = document.getElementById("generateSudokuBoard");
	tableDiv.innerHTML = genSudokuBoard(ROWS, COLUMNS);
	
	//update all cells with model information
	for (var i = 0; i < ROWS; i++)
	{
		for (var j = 0; j < COLUMNS; j++)
		{
			var gridCell = tableDiv.rows[i].cells[j];
			updateCell(gridCell, model[i][j]);
		}
	}
	
	//mockup and test if model loads in correctly. Will call this function on button clicks.
	checkSolution();
}

function genSudokuBoard(row, col)
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
}

//End of Region: View