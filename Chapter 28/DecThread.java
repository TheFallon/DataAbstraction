import java.util.concurrent.*;
/*
	This classes constructor also accepts 
	a semaphore as an argument, which is used 
	to coordinate access to the shared resource
	class
*/
class DecThread implements Runnable
{
	String name;
	Semaphore sem;
	
	DecThread(Semaphore s, String n)
	{
		sem = s;
		name = n;
	}
	
	public void run()
	{
		System.out.println("Starting: " + name);
		
		try
		{
			// First acquire the permit.
			System.out.println(name + " is waiting for a permit.");
			sem.acquire();
			System.out.println(name + " has acquired a permit.");
			
			// Now decrement the shared resource
			for(int i=0; i < 5; i++)
			{
				Shared.count--;
				System.out.println(name + ": " + Shared.count);
				
				// Now allow the context switch -- if possible.
				Thread.sleep(10);
			}
		}
		catch(InterruptedException exc)
		{
			System.out.println(exc);
		}
		
		// Release the permit.
		System.out.println(name + " releases the permit.");
		sem.release();
	}
}











