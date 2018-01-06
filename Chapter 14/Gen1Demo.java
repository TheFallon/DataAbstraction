/*
	Demonstrate the generic class Gen1.
*/
class Gen1Demo
{
	public static void main(String[] args)
	{
		// Creat a Gen1 reference for Integers.
		Gen1<Integer> iOb;
		
		// Creat a Gen<Integer> object and assign its 
		// reference to iOb. Notice the use of autoboxing
		// to encapsulate the value 88 within an Integer object.
		iOb = new Gen1<Integer>(65);
		
		// Show the type of data used by iOb.
		iOb.showType();
		
		// Get the value in iOb. 
		// Notice that no cast is needed.
		int v = iOb.getob();
		System.out.println("value: " + v);
		
		System.out.println();
		
		// Create a Gen1 object for Strings.
		Gen1<String> strOb = new Gen1<String>("Gen1 Test");
		
		// Show the type of data used by strOb.
		strOb.showType();
		
		// Get the value of strOb. Again, notice
		// that no cast is needed.
		String str = strOb.getob();
		System.out.println("value: " + str);
	}
}