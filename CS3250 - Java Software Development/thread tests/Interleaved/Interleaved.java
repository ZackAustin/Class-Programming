public class Interleaved
{
	public static void main(String[] args)
	{
		Thread t1 = new Mythread("Dessert Topping", 10);
		Thread t2 = new Mythread("Floor Wax", 10);
		t1.start();
		t2.start();
	}
}

class Mythread extends Thread
{
	private int count;
	private String name;

	public Mythread(String name, int count)
	{
		this.count = count;
		this.name = name;
		setName(name);
	}

	public void run()
	{
		for (int i = 0; i < count; ++i)
			display();
	}

	void display()
	{
		String s = getName();
		for ( int i = 0; i < s.length(); ++i)
			System.out.print(s.charAt(i));
		System.out.println();
	}
}