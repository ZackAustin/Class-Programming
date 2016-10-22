import java.io.*;
import java.util.*;

public class AdventureMap implements Serializable
{
	static class Location implements Serializable
	{
		public int row;
		public int column;

		public Location(int row, int column)
		{
			this.row = row;
			this.column = column;
		}

		public boolean equals(Object o)
		{
			if (o == this)
				return true;
			if (!(o instanceof Location))
				return false;
			Location other = (Location) o;

			if (this.row == other.row && this.column == other.column)
				return true;
			return false;
		}

		public String toString()
		{
			return row + "," + column;
		}
	}

	private transient Scanner fin = null;
	protected String mapName;
	protected String[] levelMap;
	protected Location playerLocation;
	protected int columnDimension, rowDimension;
	protected int visibility;

	protected String itemFile;
	protected ArrayList<Item> mapItems;

	protected Map<String, String> tileMap;
	protected int tileHeight;
	protected int tileWidth;

	public AdventureMap(String[] args)
	{
		mapItems = new ArrayList<>();
		this.mapName = args[0];
		this.readMapFile(args);
		this.playerLocation = new Location(0, 0);
		visibility = 2;
	}

	public void readMapFile(String[] args)
	{
    	try
    	{
        	if (args.length > 0)
        		fin = new Scanner(new File(mapName));

        	//map dimensions
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

			//read map
			for (int i = 0; i < initRow; i++)
				this.levelMap[i] = fin.nextLine();

			//read in maptile sizes for image painter.
			String tileSizeLine = fin.nextLine();
			String[] tileSize = tileSizeLine.split(" ");
			int th = Integer.parseInt(tileSize[0]);
			int tw = Integer.parseInt(tileSize[1]);
			tileHeight = th;
			tileWidth = tw;

			//read and associate item file to map file.

			itemFile = fin.nextLine();

			//read in tile displays.
			tileMap = new HashMap<String, String>();
			int tileCounter = 0;
			while (fin.hasNextLine())
			{
				String nextTileLine = fin.nextLine();
				String[] tileTokens = nextTileLine.split(";");

				if (tileTokens.length > 1)
				{
					tileMap.put(tileTokens[0], tileTokens[2]);
				}
			}

			fin.close();

			//read itemfile
			readItemFile(itemFile);
    	}
    	catch (Exception x)
    	{
        	System.out.println("File open failed.");
        	x.printStackTrace();
        	System.exit(0);   // TERMINATE THE PROGRAM
    	}
    }

    private void readItemFile(String fn)
    {
    	try
    	{
    		fin = new Scanner(new File(fn));

    		while (fin.hasNextLine())
    		{
    			String nextInputLine = fin.nextLine();
    			String[] nextItem = nextInputLine.split(";");

    			int itemRow = Integer.parseInt(nextItem[0]);
    			int itemColumn = Integer.parseInt(nextItem[1]);
    			String itemName = nextItem[2];
    			mapItems.add(new Item(new AdventureMap.Location(itemRow, itemColumn), itemName));
    		}

    		fin.close();
    	}
    	catch (IOException e)
    	{
    		System.out.println("File open failed.");
    		e.printStackTrace();
    		System.exit(0);
    	}
    }

    public char getTerrain(Location playerLoc)
    {
    	return levelMap[playerLoc.row].charAt(playerLoc.column);
    }

    protected ArrayList<Item> checkMapForItems()
    {
    	ArrayList<Item> itemsAtPlayerLocation = new ArrayList<>();
    	Iterator mapItem = mapItems.iterator();

    	while (mapItem.hasNext())
    	{
    		Item curItem = (Item)mapItem.next();
    		if (curItem.itemLocation.equals(playerLocation))
				itemsAtPlayerLocation.add((Item)curItem);
    	}

    	return (ArrayList<Item>)itemsAtPlayerLocation;
    }

    public String toString()
    {
    	return playerLocation + " in terrain " + getTerrain(playerLocation) + ".";
    }
}