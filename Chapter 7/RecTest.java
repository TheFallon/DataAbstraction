/*
	This class uses a recursive method
	to print out the values of an array.
*/
class RecTest
{
	int[] values;
	
	RecTest(int i)
	{
		values = new int[i];
	}
	
	// display the array recursively, this could
	// have been done with a for loop.
	void printArray(int i)
	{
		if(i==0) return;
		else printArray(i-1);
		
		System.out.println("[" + (i-1) + "]" + values[i-1]);
	}
}