// Illustrates Visitor
import java.io.*;
import java.util.*;

public class GumballMachine
{
	final static int SOLD_OUT = 0;
	final static int NO_QUARTER = 1;
	final static int HAS_QUARTER = 2;
	final static int SOLD = 3;

	int state = SOLD_OUT;
	int count = 0;

	public GumballMachine (int count) {
		this.count = count;
		if (count > 0) {
			state = NO_QUARTER;
		}
	}

	public void insertQuarter() {
		if (state == HAS_QUARTER) {
			System.out.println ("You can't insert another quarter");
		} else if (state == NO_QUARTER) {
			state = HAS_QUARTER;
			System.out.println ("You inserted a quarter");
		} else if (state == SOLD_OUT) {
			System.out.println ("You can't insert a quarter, the machine is sold out");
		} else if (state == SOLD) {
			System.out.println ("Please wait, we're already giving you a gumball");
		}
	}

	public void ejectQuarter() {
		if (state == HAS_QUARTER) {
			System.out.println ("Quarter returned");
			state = NO_QUARTER;
		} else if (state == NO_QUARTER) {
			System.out.println ("You haven't inserted a quarter");
		} else if (state == SOLD_OUT) {
			System.out.println ("You can't eject, you haven't inserted a quarter yet");
		} else if (state == SOLD) {
			System.out.println ("Sorry, you already turned the crank");
		}
	}

	public void turnCrank() {
		if (state == HAS_QUARTER) {
			System.out.println ("You turned ...");
			state = SOLD;
			dispense();
		} else if (state == NO_QUARTER) {
			System.out.println ("You turned, but there's no quarter");
		} else if (state == SOLD_OUT) {
			System.out.println ("You turned, but there are no gumballs");
		} else if (state == SOLD) {
			System.out.println ("Turning twice doesn't get you another gumball");
		}
	}

	public void refill(int newgums)
	{
		if (state == SOLD_OUT)
		{
			if (newgums > 0)
			{
				count = newgums;
				state = NO_QUARTER;
			}
		}
		else if (state == NO_QUARTER)
		{
			count += newgums;
		}
		else
		{
			System.out.println("Can't refill at the moment");
		}
	}

	public void dispense() {
		if (state == SOLD) {
			System.out.println ("A gumball comes rolling out of the slot");
			count = count - 1;
			if (count == 0) {
				System.out.println ("Oops, out of gumballs");
				state = SOLD_OUT;
			} else {
				state = NO_QUARTER;
			}
		} else if (state == NO_QUARTER) {
			System.out.println ("You need to pay first");
		} else if (state == SOLD_OUT) {
			System.out.println ("NO gumball dispensed");
		} else if (state == HAS_QUARTER) {
			System.out.println ("No Gumball dispensed");
		}
	}

	//
	// Add refill() method here
	//

	public String toString() {
		String st = "Unknown state";
		if (state == SOLD_OUT) {
			st = "Machine is sold out";
		}
		else if (state == NO_QUARTER)
		{
			st = "Machine is waiting for a quarter";
		}
		else if (state == HAS_QUARTER)
		{
			st = "Machine is waiting for crank to be turned";
		}
		else if (state == SOLD)
		{
			st = "Machine is ready to dispense";
		}
		return "\nMighty Gumball Inc." + "\n" +
			"Inventory: " + count + " gumballs\n" +
			st + "\n";
	}
}

