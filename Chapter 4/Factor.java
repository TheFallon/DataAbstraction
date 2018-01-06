/*
	This class contains a value returning
	that accepts two parameters and returns
	a boolean value. The method determines if 
	one value is a factor of another.
*/
class Factor
{
	boolean isFactor(int a, int b)
	{
		if((b % a) == 0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
}