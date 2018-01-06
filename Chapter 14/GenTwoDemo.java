/*
	This program demonstrates the TwoGen
	class which accepts two type parameters.
*/
class GenTwoDemo
{
	public static void main(String[] args)
	{
		GenTwo<Integer, String> tgObj =
			new GenTwo<Integer, String>(88, "Generics");
		
		// Show the types.
		tgObj.showTypes();
		
		// Obtain and show values.
		int v = tgObj.getOb1();
		System.out.println("value: " + v);
		
		String str = tgObj.getOb2();
		System.out.println("value: " + str);
	}
}