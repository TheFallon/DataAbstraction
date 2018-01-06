/*
	This class conatins a single method 
	which will be called within a synchronized,
	multithreaded, program.
*/
class CallMe2
{
	void call(String msg)
	{
		System.out.print("[" + msg);
		try
		{
			Thread.sleep(1000);
		}
		catch(InterruptedException e)
		{
			System.out.println("Interrupted.");
		}
		System.out.println("]");
		try
		{
			Thread.sleep(500);
		}
		catch(InterruptedException e)
		{
			System.out.println("Interrupted.");
		}
		System.out.println("Oh fuck yeah, another thread!!");
		try
		{
			Thread.sleep(500);
		}
		catch(InterruptedException e)
		{
			System.out.println("Interrupted.");
		}
	}
}