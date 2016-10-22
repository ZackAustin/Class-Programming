import java.io.*;
import java.util.*;

public class Item implements Serializable
{
	protected AdventureMap.Location itemLocation;
	protected String name;
	
	public Item(AdventureMap.Location loc, String name)
	{
		itemLocation = loc;
		this.name = name.trim();
	}

	public Item(Item item)
	{
		this.itemLocation = item.itemLocation;
		this.name = item.name;
	}

	public String toString()
    {
    	return name + ".\n";
    }
}