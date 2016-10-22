import java.util.*;
import java.io.*;

public class Search
{ 
  private static final int MAX_WORDS = 200;
  private static Scanner fin = null;
  private static Puzzle gameGrid = null;
	public static void main (String[] args)
	{
		readFile(args);
    int gridSize = 0, gridRow = 0, wordCount = 0;
    String firstLine = "", nextWord = "";
    boolean gridSetUp = false, success = false;

    //Setup puzzle.
    if (fin.hasNextLine())
    {
      firstLine = fin.nextLine();
      gridSize = firstLine.length();
    }

    gameGrid = new Puzzle(new String[gridSize], gridSize);
      //Read until a blankline to setup grid.
    gameGrid.setGridRow(firstLine, gridRow++);

    while (gridSetUp == false)
    {
      //Each search keyword.
      String inputLine = fin.nextLine();
      if (inputLine.equals(""))
        gridSetUp = true;
      else
        gameGrid.setGridRow(inputLine, gridRow++);
    }

    System.out.println();
    for (int i = 0; i < gameGrid.grid.length; i++)
      System.out.println(gameGrid.grid[i]);
    System.out.println();

    nextWord = fin.nextLine();
    success = searchWord(nextWord);

    //Here let's call Search on a keyword at a time.

    while (fin.hasNextLine() && wordCount < MAX_WORDS)
    {
      nextWord = fin.nextLine();
      success = searchWord(nextWord);
      wordCount++;
    }
	}

	public static void readFile(String[] args)
	{
    boolean success = false;
    while (success == false)
    {
    	try
    	{
        if (args.length > 0)
        	fin = new Scanner(new File(args[0]));
        success = true;
    	}
    	catch (FileNotFoundException x)
    	{
        	System.out.println("File open failed.");
          x.printStackTrace();
          System.exit(0);   // TERMINATE THE PROGRAM
    	}
    }
	}

  public static boolean searchWord(String word)
  {
    boolean success = false;
    if (gameGrid != null)
    {
      success = gameGrid.horizontalLTR(word);
      if (success == false)
        success = gameGrid.horizontalRTL(word);
      if (success == false)
        success = gameGrid.verticalTTB(word);
      if (success == false)
        success = gameGrid.verticalBTT(word);
      if (success == false)
        success = gameGrid.diagonals(word);
      if (success == false)
        System.out.println(word + " not found");
    }
    return success;
  }
}