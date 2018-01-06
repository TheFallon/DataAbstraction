/*
	Move more out of the for Loop.
*/
class Empty2
{
	public static void main(String[] args)
	{
		int i;
		
		i = 0; // initialization occurs outside the loop.
		for( ;i < 10; )
		{
			System.out.println("Pass #" + i);
			i++;
		}
	}
}