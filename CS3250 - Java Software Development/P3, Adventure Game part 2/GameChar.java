public class GameChar
{
	private Map map;
	private final int VISIBILITY = 1;
	public GameChar(Map map)
	{
		this.map = map;
	}

	public boolean direction(String input)
	{
		input = input.toLowerCase().trim();
		if (input.charAt(0) == 'g')
			{
				//Split for Possible Direction.
				String[] splitInput = input.split(" +");

				//east
				if (splitInput.length > 1 && splitInput[1].charAt(0) == 'e')
				{
					if (map.playerLocation.column >= 0 && map.playerLocation.column < map.columnDimension - 1)
					{
						System.out.println("Moving east...");
						map.playerLocation.column++;
					}
					else System.out.println("You can't go that far east.");
				}
				//west
				else if (splitInput.length > 1 && splitInput[1].charAt(0) == 'w')
				{
					if (map.playerLocation.column > 0 && map.playerLocation.column <= map.columnDimension - 1)
					{
						System.out.println("Moving west...");
						map.playerLocation.column--;
					}
					else System.out.println("You can't go that far west.");
				}
				//south
				else if (splitInput.length > 1 && splitInput[1].charAt(0) == 's')
				{
					if (map.playerLocation.row >= 0 && map.playerLocation.row < map.rowDimension - 1)
					{
						System.out.println("Moving south...");
						map.playerLocation.row++;
					}
					else System.out.println("You can't go that far south.");
				}
				//north
				else if (splitInput.length > 1 && splitInput[1].charAt(0) == 'n')
				{
					if (map.playerLocation.row > 0 && map.playerLocation.row <= map.rowDimension - 1)
					{
						System.out.println("Moving north...");
						map.playerLocation.row--;
					}
					else System.out.println("You can't go that far north.");
				}
				else if (splitInput.length > 1)
					System.out.println("You can't go that way.");
				return true;
			}
			else return false;
	}

	private String displayPlayerVisibility(int playerVision)
	{
		int startRow = map.playerLocation.row - playerVision;
		int startColumn = map.playerLocation.column - playerVision;
		int endRow = map.playerLocation.row + playerVision;
		int endColumn = map.playerLocation.column + playerVision;
		int displayCounter = 0;
		String display = "\n";

		for (int i = startRow; i <= endRow; i++)
		{
			for (int j = startColumn; j <= endColumn; j++)
			{
				//out of bounds
				if (i < 0 || i >= map.rowDimension || j < 0 || j >= map.columnDimension)
					display += "X";
				else
					display += map.getTerrain(new Map.Location(i, j));
			}
			display += "\n";
		}
		return display;
	}

	public void inventory()
	{
		System.out.println("You are carrying:\nbrass lantern\nrope\nrations\nstaff");
	}

	public String toString()
	{
		return map + displayPlayerVisibility(VISIBILITY);
	}
}