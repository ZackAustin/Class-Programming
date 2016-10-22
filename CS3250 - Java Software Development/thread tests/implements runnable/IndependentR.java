public class IndependentR
{
	public static void main(String[] args)
	{
		Thread t1 = new Thread(new MyTask("Dessert Topping", 8));
		Thread t2 = new Thread(new MyTask("FloorWax", 4));
		t1.start();
		t2.start();
	}
}

class MyTask implements Runnable
{
	private int count;
	private String name;

	public MyTask(String name, int count)
	{
		this.count = count;
		this.name = name;
	}

	public void run()
	{
		for (int i = 0; i < count; ++i)
			System.out.println(name);
	}
}