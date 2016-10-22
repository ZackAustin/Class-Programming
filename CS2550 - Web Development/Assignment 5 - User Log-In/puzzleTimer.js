//Puzzle Timer -- Controller Region

var sudoku = sudoku || {};

//timer variables

sudoku.timeElapsedSec = 0;
sudoku.timeElapsedMin = 0;
sudoku.timeElapsedHour = 0;
sudoku.timerObject;

sudoku.sController = sudoku.sController || {};

sudoku.sController.startTimer = function()
{
	sudoku.timeElapsedSec = 0;
	sudoku.timeElapsedMin = 0;
	sudoku.timeElapsedHour = 0;
	sudoku.timerObject = setInterval(sudoku.sController.timerUpdate, 999);
	//sudoku.timerObject();
};

sudoku.sController.timerUpdate = function()
{
	sudoku.timeElapsedSec++;
	if (sudoku.timeElapsedSec > 59)
	{
		sudoku.timeElapsedMin++;
		sudoku.timeElapsedSec = 0;
		
		if (sudoku.timeElapsedMin > 59)
		{
			sudoku.timeElapsedHour++;
			sudoku.timeElapsedMin = 0;
		}
	}

	var outputString = "";
	if (sudoku.timeElapsedHour > 0)
		outputString += sudoku.timeElapsedHour + "h ";
	if (sudoku.timeElapsedMin > 0)
		outputString += sudoku.timeElapsedMin + "m ";
	outputString += sudoku.timeElapsedSec + "s";
	
	var outputTime = document.getElementById("timerWrap");
	
	outputTime.innerHTML = "Time Elapsed: " + outputString;
};

sudoku.sController.endTimer = function()
{
	sudoku.timeElapsedSec = 0;
	sudoku.timeElapsedMin = 0;
	sudoku.timeElapsedHour = 0;
	
	//if (sudoku.timerObject != "null" && sudoku.timerObject != "undefined")
	clearInterval(sudoku.timerObject);
};