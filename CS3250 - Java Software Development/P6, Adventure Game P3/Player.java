import java.io.*;
import java.util.*;

public class Player implements Serializable
{
	protected AdventureMap map;
	protected ArrayList<Item> items;
	
	public Player(AdventureMap map)
	{
		this.map = map;
		items = new ArrayList<>();
	}

	protected String direction(String input)
	{
		String output = "";
		input = input.toLowerCase().trim();
		if (input.charAt(0) == 'g')
			{
				//Split for Possible Direction.
				String[] splitInput = input.split(" ");

				//east
				if (splitInput.length > 1 && splitInput[1].charAt(0) == 'e')
				{
					if (map.playerLocation.column >= 0 && map.playerLocation.column < map.columnDimension - 1)
					{
						output = "Moving east...";
						map.playerLocation.column++;
					}
					else output = "You can't go that far east.";
				}
				//west
				else if (splitInput.length > 1 && splitInput[1].charAt(0) == 'w')
				{
					if (map.playerLocation.column > 0 && map.playerLocation.column <= map.columnDimension - 1)
					{
						output = "Moving west...";
						map.playerLocation.column--;
					}
					else output = "You can't go that far west.";
				}
				//south
				else if (splitInput.length > 1 && splitInput[1].charAt(0) == 's')
				{
					if (map.playerLocation.row >= 0 && map.playerLocation.row < map.rowDimension - 1)
					{
						output = "Moving south...";
						map.playerLocation.row++;
					}
					else output = "You can't go that far south.";
				}
				//north
				else if (splitInput.length > 1 && splitInput[1].charAt(0) == 'n')
				{
					if (map.playerLocation.row > 0 && map.playerLocation.row <= map.rowDimension - 1)
					{
						output = "Moving north...";
						map.playerLocation.row--;
					}
					else output = "You can't go that far north.";
				}
				else if (splitInput.length > 1)
					output = "You can't go that way.";
			}
			return output;
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
					display += map.getTerrain(new AdventureMap.Location(i, j));
			}
			display += "\n";
		}
		return display;
	}

	protected String inventory()
	{
		String itemsInInventory = "";
		Iterator it = items.iterator();
		while (it.hasNext())
		{
			Item curItem = (Item) it.next();
			itemsInInventory += curItem.name + "\n";
		}
		String inventoryText = "You are carrying:\n";
		if (itemsInInventory.equals(""))
			inventoryText = "No Items In Inventory.\n";
		else inventoryText += itemsInInventory;
		return inventoryText;
	}

	protected void moveItem(String input, ArrayList<Item> grabsItem, ArrayList<Item> dropsItem)
	{
		String inputType = input.toLowerCase().trim();
		if (inputType.charAt(0) == 't' || inputType.charAt(0) == 'd')
		{
			String[] splitInput = input.split(" ");

			if (splitInput.length > 1)
			{
				boolean foundItem = false;
				Iterator it = dropsItem.iterator();
				while (it.hasNext() && foundItem == false)
				{
					Item curItem = (Item) it.next();

					String itemName = "";
					for (int i = 1; i < splitInput.length; i++)
						itemName += splitInput[i] + " ";

					itemName = itemName.trim();

					if (curItem.name.equals(itemName))
					{
						curItem.itemLocation = new AdventureMap.Location(map.playerLocation.row, map.playerLocation.column);
						grabsItem.add(curItem);
						dropsItem.remove(curItem);
						foundItem = true;
					}
				}
			}
		}
	}

	protected String checkItemsAtLocation()
	{
		ArrayList<Item> itemsAtLoc = map.checkMapForItems();
		Iterator it = itemsAtLoc.iterator();
		String itemsOnMapText = "";
		String theItems = "";

		while (it.hasNext())
		{
			itemsOnMapText = "Items at this Location:\n";
			Item curItem = (Item) it.next();
			theItems += curItem.toString();
		}
		if (!(theItems.equals("")))
			itemsOnMapText = "Items at this Location (" + map.playerLocation + "):\n" + theItems + "\n";
		return itemsOnMapText;
	}

	protected void SaveGame()
	{

	}

	protected void LoadGame()
	{

	}

	public String toString()
	{
		//return map + displayPlayerVisibility(map.visibility);
		return map + "";
	}
}