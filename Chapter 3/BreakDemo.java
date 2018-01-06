/*
	Using break to exit a loop.
*/
class BreakDemo
{
	public static void main(String[] args)
	{
		int num;
		
		num = 100;
		
		// loop while i-squared is less than num
		for(int i = 0; i < num; i++)
		{
			
			if(i*i >= num) 
			{
				break; // terminate the loop if i*i > num
			}
			
			
			System.out.println(i + " ");
		}
		System.out.println("Loop complete");
	}
}