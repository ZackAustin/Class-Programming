import java.io.*;
import java.util.*;
import javax.swing.*;

public class Adventure
{	
	//GUI Frame.
	private static GameUI frame;
	public static final int GRID_SIZE = 25;
	public static final int ROW_SIZE = 5;
	public static final int COLUMN_SIZE = 5;

	public static void main(String[] args)
	{
		AdventureMap adventureMap = new AdventureMap(args);
		Player player = new Player(adventureMap);

		//add a gui frame from other java file.
		frame = new GameUI("Adventure Game", player);
	}	
}