/*
	This class is the blueprint for a Queue, and
	will be utilized by other classes to create
	Queue objects.
*/
class Queue
{
	char q[];  // This array holds the queue.
	int putLoc, getLoc; // The put and get indices.
	
	Queue(int size)
	{
		q = new char[size]; // Allocates memory for the queue.
		putLoc = getLoc = 0;
	}
	
	// put a character into the queue.
	void put(char ch)
	{
		if(putLoc == q.length)
		{
			System.out.println(" - Queue is full.");
			return;
		}
		
		q[putLoc++]= ch;
	}
	
	// get a character from the queue
	char get()
	{
		if(getLoc == putLoc)
		{
			System.out.println(" - Queue is empty.");
			return (char) 0;
		}
		
		return q[getLoc++];
	}
}