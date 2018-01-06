/*
	This is a simple generic class. T represents
	the type of object that will be created when
	this class is used by a calling class.
*/
class Gen1<T>
{
	T ob; // Declare an object of type T.
	
	// Pass the constructor a reference
	// to an object of type T.
	Gen1(T o)
	{
		ob = o;
	}
	
	// Return ob
	T getob()
	{
		return ob;
	}
	
	// Show type of T.
	void showType()
	{
		System.out.println("Type of T is " + 
							ob.getClass().getName());
	}
}