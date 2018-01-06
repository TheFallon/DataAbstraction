/*
	Demonstrate variable-length arguments.
*/
class VarArgs
{
	static void vaTest(String msg, int ... v)
	{
		System.out.print(msg + v.length + 
						 " Contents: ");
		
		for(int x : v)
		{
			System.out.print(x + " ");
		}
		System.out.println();
	}
	
	public static void main(String[] args)
	{
		// Now vaTest can be called without having
		// to create arrays with known sizes.
		vaTest("One VarArg: ",10);
		vaTest("Three VarArgs: ",12,34,56);
		vaTest("No VarAargs: ");
	}
}