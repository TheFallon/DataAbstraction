/*
	This class demonstrates the recursive method
	in the RecTest class
*/
class Recursion2
{
	public static void main(String[] args)
	{
		//Create an array with a length of 10.
		RecTest ob = new RecTest(10);
		int i;
		
		// Load the array with values
		for(i = 0;i < 10;i++)
		{
			ob.values[i] = i;
		}
		
		// Print the values of the array.
		ob.printArray(10);
	}
}