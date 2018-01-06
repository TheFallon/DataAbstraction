/*
	This class implements overloaded constructors
*/
class Overloaded
{
	public static void main(String[] args)
	{
		OverloadDemo ob = new OverloadDemo();
		double result;
		
		// Call all versions of text().
		ob.test();
		ob.test(10);
		ob.test(10, 20);
		result = ob.test(123.25);
		System.out.println("Result of ob.test(123.54): " + result);
	}
}