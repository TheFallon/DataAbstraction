/*
	This class demonstrates overloading 
	methods with variable-length arguments.
*/
class VarArgs2
{
	static void vaTest(int ... v)
	{
		System.out.print("vaTest(int ... v): " +
						 "Number of args: " + v.length +
						 " Contents: ");
		
		for(int x : v)
		{
			System.out.print(x + " ");
		}
		System.out.println();
	}
	
	static void vaTest(boolean ... v)
	{
		System.out.print("vaTest(boolean ... v): " +
						 "Number of args: " + v.length +
						 " Contents: ");
		
		for(boolean x : v)
		{
			System.out.print(x + " ");
		}
		System.out.println();
	}
	 
	static void vaTest(String msg, int ... v)
	{
		System.out.print("vaTest(String msg, int ... v): " +
						 msg + v.length +
						 " Contents: ");
		
		for(int x : v)
		{
			System.out.print(x + " ");
		}
		System.out.println();
	}
	
	public static void main(String[] args)
	{
		vaTest(1,2,3);
		vaTest(true,false,true,true);
		vaTest("Testing ", 3, 5, 6);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}