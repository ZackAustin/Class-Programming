import java.io.*;
import java.util.*;

public class Adventure
{
	public static void main (String[] args)
	{
		Scanner in = new Scanner(System.in);
		String inputLine = "-999";
		Map AdventureMap = new Map(args);
		GameChar player = new GameChar(AdventureMap);

		while (inputLine.toLowerCase().trim().charAt(0) != 'q')
		{
			//Read Input.
			inputLine = in.nextLine();

			//Map Locations.
			if (player.direction(inputLine)){}
			//inventory
			else if (inputLine.toLowerCase().trim().charAt(0) == 'i')
				player.inventory();
			else if (inputLine.toLowerCase().trim().charAt(0) != 'q')
				System.out.println("Invalid command: " + inputLine);
			else System.out.println("Farewell");

			System.out.println("You are at location " + player);
		}
	}
}