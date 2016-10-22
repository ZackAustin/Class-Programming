import java.io.*;
import java.util.*;

public class Map
{
	static class Location
	{
		public int row;
		public int column;

		public Location(int row, int column)
		{
			this.row = row;
			this.column = column;
		}

		public String toString()
		{
			return row + "," + column;
		}
	}

	private Scanner fin = null;
	private String[] levelMap;
	protected Location playerLocation;
	protected int columnDimension, rowDimension;

	public Map(String[] args)
	{
		this.readMapFile(args);
		this.playerLocation = new Location(0, 0);
	}

	public void readMapFile(String[] args)
	{
    	try
    	{
        	if (args.length > 0)
        		fin = new Scanner(new File(args[0]));

        	String input = fin.nextLine();
        	String[] firstLine = input.split(" ");
        	int initRow = Integer.parseInt(firstLine[0]);
        	int initCol = Integer.parseInt(firstLine[1]);
        	
        	if (initCol >= 0)
				columnDimension = initCol;
			else columnDimension = 0;
			if (initRow >= 0)
				rowDimension = initRow;
			else rowDimension = 0;

			this.levelMap = new String[initRow];

			for (int i = 0; i < initRow; i++)
				this.levelMap[i] = fin.nextLine();
    	}
    	catch (Exception x)
    	{
        	System.out.println("File open failed.");
        	x.printStackTrace();
        	System.exit(0);   // TERMINATE THE PROGRAM
    	}
    }

    public char getTerrain(Location playerLoc)
    {
    	return levelMap[playerLoc.row].charAt(playerLoc.column);
    }

    public String toString()
    {
    	return playerLocation + " in terrain " + getTerrain(playerLocation);
    }
}