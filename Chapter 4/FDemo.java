/*
	This class demonstrates Java garbage
	collection and the finalize method, it
	is utilized by the finalize class.
*/
class FDemo
{
	int x;
	
	FDemo(int i)
	{
		x = i;
	}
	
	// called when an object is destroyed
	protected void finalize()
	{
		System.out.println("Finalizing " + x);
	}
	
	// generates an object that is immidiately destroyed.
	void generator(int i)
	{
		FDemo o = new FDemo(i);
	}
}