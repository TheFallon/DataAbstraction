/*
	The body of a loop can be empty.
*/
class Empty3
{
	public static void main(String[] args)
	{
		int i; 
		int sum = 0;
		
		// Sum the number through 5
		for(i = 1; i <= 6; sum += i++) ;
		
		System.out.println("Sum is " + sum);
	}
}