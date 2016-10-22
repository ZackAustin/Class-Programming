public class Independent
{
	public static void main(String[] args)
	{
		Thread t1 = new MyThread("DessertTopping", 8);
		Thread t2 = new MyThread("FloorWax", 4);
		t1.start();
		t2.start();
	}
}

class MyThread extends Thread
{
	private int count;
	public MyThread(String name, int count)
	{
		super(name); // Optional thread name
		this.count = count;
	}
	public void run()
	{
		for (int i = 0; i < count; ++i)
			System.out.println(getName());
	}
}