/*
	This class demonstrates the use of bounded
	types in generic classes. Type paraemters
	must of the type Number or one of its
	subclasses.
*/
class Stats<T extends Number>
{
	T[] nums;	// array of Number or one of its subclasses.
	
	// Pass the constructor a reference to
	// an array of type number or one of
	// its subclasses.
	Stats(T[] o)
	{
		nums = o;
	}
	
	// Return type double in all cases.
	double average()
	{
		double sum  = 0.0;
		
		for(int i = 0; i < nums.length; i++)
		{
			sum += nums[i].doubleValue();
		}
		
		return sum / nums.length;
	}
	
	// Determine if two averages are the same.
	boolean sameAvg(Stats<?> ob)
	{
		if(average() == ob.average())
			return true;
		return false;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}