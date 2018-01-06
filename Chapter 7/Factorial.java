/*
	This class is a simple exmaple of recursion,
	which is used to calculate factorials.
*/
class Factorial
{
	// Create a recursive method
	int fact(int num)
	{
		int result;
		
		if(num == 1)
		{
			return 1;
		}
		
		result = fact(num -1) * num;
		return result;
	}
}