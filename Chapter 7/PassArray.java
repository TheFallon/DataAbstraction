/*
	Use an array to pass a variable number 
	of arguments to a method. This is the 
	old style approach to varable length
	arguments.
*/
class PassArray
{
	static void vaTest(int[] v)
	{
		System.out.print("Number of arguments: " + v.length +
						 " Contents: ");
		
		for(int x : v)
		{
			System.out.print(x + " ");
		}
		System.out.println();
	}
	
	public static void main(String[] args)
	{
		// An array must be created to hold the
		// arguments.
		int[] n1 = {45};
		int[] n2 = {23,45,67};
		int[] n3 = {};
		
		vaTest(n1); // 1 arg
		vaTest(n2); // 3 args
		vaTest(n3); // No args
	}
}