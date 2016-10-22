import java.util.*;

public class Adventure
{
	public static final int COLUMN_MAX = 4, ROW_MAX = 4;

	public static void main (String[] args)
	{
		Scanner in = new Scanner(System.in);
		String inputLine = "-999";
		Grid AdventureMap = new Grid(4,4);

		while (inputLine.toLowerCase().trim().charAt(0) != 'q')
		{
			//Read Input.
			inputLine = in.nextLine();

			//Map Locations.
			if (playerDirection(inputLine.toLowerCase().trim(), AdventureMap)){}
			//inventory
			else if (inputLine.toLowerCase().trim().charAt(0) == 'i')
				System.out.println("You are carrying:\nbrass lantern\nrope\nrations\nstaff");
			else if (inputLine.toLowerCase().trim().charAt(0) != 'q')
				System.out.println("Invalid command: " + inputLine);
			else System.out.println("Farewell");

			System.out.println("You are at location " + AdventureMap.rowPos + "," + AdventureMap.columnPos);
		}
	}

	public static Boolean playerDirection(String input, Grid map)
	{
			if (input.charAt(0) == 'g')
			{
				//Split for Possible Direction.
				String[] splitInput = input.split(" +");

				//east
				if (splitInput.length > 1 && splitInput[1].charAt(0) == 'e')
				{
					if (map.columnPos >= 0 && map.columnPos < map.columnDimension)
					{
						System.out.println("Moving east...");
						map.columnPos++;
					}
					else System.out.println("You can't go that far east.");
				}
				//west
				else if (splitInput.length > 1 && splitInput[1].charAt(0) == 'w')
				{
					if (map.columnPos > 0 && map.columnPos <= map.columnDimension)
					{
						System.out.println("Moving west...");
						map.columnPos--;
					}
					else System.out.println("You can't go that far west.");
				}
				//south
				else if (splitInput.length > 1 && splitInput[1].charAt(0) == 's')
				{
					if (map.rowPos >= 0 && map.rowPos < map.rowDimension)
					{
						System.out.println("Moving south...");
						map.rowPos++;
					}
					else System.out.println("You can't go that far south.");
				}
				//north
				else if (splitInput.length > 1 && splitInput[1].charAt(0) == 'n')
				{
					if (map.rowPos > 0 && map.rowPos <= map.rowDimension)
					{
						System.out.println("Moving north...");
						map.rowPos--;
					}
					else System.out.println("You can't go that far north.");
				}
				else if (splitInput.length > 1)
					System.out.println("You can't go that way.");
				return true;
			}
			else return false;
	}
}

class Grid
{
	public int columnPos, rowPos, columnDimension, rowDimension;
	public Grid(int initCol, int initRow)
	{
		columnPos = 0;
		rowPos = 0;
		if (initCol >= 0 && initCol <= Adventure.COLUMN_MAX)
			columnDimension = initCol;
		else columnDimension = 0;
		if (initRow >= 0 && initRow <= Adventure.ROW_MAX)
			rowDimension = initRow;
		else rowDimension = 0;
	}
}