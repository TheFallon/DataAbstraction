import java.util.concurrent.*;
/*
	This class demonstrates the use of a 
	semaphore. God lord how am I ever going
	fully digest and internalize this.
*/
class SemDemo
{
	public static void main(String[] args)
	{
		Semaphore sem = new Semaphore(1);
		
		IncThread increment = new IncThread(sem, "Increment that shit");
		DecThread decrement = new DecThread(sem, "Decrement that shit");
		increment.start();
		decrement.start();
	}
}