//SuperHero Animation -- Controller Region

var sudoku = sudoku || {};

//animation variables
sudoku.heroImg, sudoku.heroDivWidth;
sudoku.heroLeft;
sudoku.margin = 10;

sudoku.sController = sudoku.sController || {};

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