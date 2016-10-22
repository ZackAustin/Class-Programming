//Model is a 2D array of objects of type number which are either considered predetermined or userinputted.

//Region: The Model

var sudoku = sudoku || {};
sudoku.sModel = sudoku.sModel || {};

sudoku.sModel.number = function(changeable, name, text)
{
	this.changeable = changeable;
	this.name = name;
	this.text = text;
};

sudoku.sModel.createModelArray = function(rows, columns)
{
	//declare 2-dim array
	var arr = new Array(rows);
	
	for (var i = 0; i < rows; i++)
	{
		arr[i] = new Array(columns);
		
		for (var j = 0; j < columns; j++)
		{
			arr[i][j] = new this.number(true, "userNum", "");
		}
	}
	//initialize model array
	this.mockupModel(arr);
	return arr;
};

sudoku.sModel.mockupModel = function(model)
{
	//Initialize -- later model will be set up by ajax call.
	
	//mockup for predefined numbers
	model[0][0] = new this.number(false, "predetNum", "9");
	model[0][1] = new this.number(false, "predetNum", "1");
	model[0][3] = new this.number(false, "predetNum", "7");
	model[1][1] = new this.number(false, "predetNum", "3");
	model[1][2] = new this.number(false, "predetNum", "2");
	model[1][3] = new this.number(false, "predetNum", "6");
	model[1][5] = new this.number(false, "predetNum", "9");
	model[1][7] = new this.number(false, "predetNum", "8");
	model[2][2] = new this.number(false, "predetNum", "7");
	model[2][4] = new this.number(false, "predetNum", "8");
	model[2][6] = new this.number(false, "predetNum", "9");
	model[3][1] = new this.number(false, "predetNum", "8");
	model[3][2] = new this.number(false, "predetNum", "6");
	model[3][4] = new this.number(false, "predetNum", "3");
	model[3][6] = new this.number(false, "predetNum", "1");
	model[3][7] = new this.number(false, "predetNum", "7");
	model[3][8] = new this.number(false, "predetNum", "9");
	model[4][0] = new this.number(false, "predetNum", "3");
	model[4][8] = new this.number(false, "predetNum", "6");
	model[5][1] = new this.number(false, "predetNum", "5");
	model[5][2] = new this.number(false, "predetNum", "1");
	model[5][4] = new this.number(false, "predetNum", "2");
	model[5][6] = new this.number(false, "predetNum", "8");
	model[5][7] = new this.number(false, "predetNum", "4");
	model[6][2] = new this.number(false, "predetNum", "9");
	model[6][4] = new this.number(false, "predetNum", "5");
	model[6][6] = new this.number(false, "predetNum", "3");
	model[7][1] = new this.number(false, "predetNum", "2");
	model[7][3] = new this.number(false, "predetNum", "3");
	model[7][5] = new this.number(false, "predetNum", "1");
	model[7][6] = new this.number(false, "predetNum", "4");
	model[7][7] = new this.number(false, "predetNum", "9");
	model[8][5] = new this.number(false, "predetNum", "2");
	model[8][7] = new this.number(false, "predetNum", "6");
	model[8][8] = new this.number(false, "predetNum", "1");
	
	//mockup of user inputs
	//model[0][2] = new this.number(true, "userNum", "8");
	//model[2][7] = new this.number(true, "userNum", "1");
	//model[4][3] = new sudoku.sModel.number(true, "userNum", "1");
	//model[4][5] = new this.number(true, "userNum", "1");
};

//generate and initialize model.
sudoku.sModel.model = sudoku.sModel.createModelArray(sudoku.ROWS, sudoku.COLUMNS);

//End of Region: Model