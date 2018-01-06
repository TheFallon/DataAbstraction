import java.util.concurrent.*;
/*
	This classes constructor accepts a semaphore object 
	as a parameter, which is then used to regulate access
	to the shared resource class with Threads from the
	DecThread class.
*/
class IncThread implements Runnable
{
	String name;
	Semaphore sem;
	
	IncThread(Semaphore s, String n)
	{
		sem = s;
		name = n;
	}
	
	public void run()
	{
		System.out.println("Starting: " + name);
		
		try
		{
			// First acquire a permit.
			System.out.println(name + " is waiting for a permit.");
			sem.acquire();
			System.out.println(name + " gets  a permit.");
			
			// Now access the shared resource.
			for(int i=0;i < 5;i++)
			{
				Shared.count++;
				System.out.println(name  + ": " + Shared.count);
				
				// Now, alloow a context switch -- if that is possible.
				Thread.sleep(10);
			}
		}
		catch(InterruptedException exc)
		{
			System.out.println(exc);
		}
		
		
		System.out.println(name + " releases the permit.");
		sem.release();
	}
}