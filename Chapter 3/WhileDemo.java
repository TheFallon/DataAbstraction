/*
	Demonstrate the While loop.
*/
class WhileDemo
{
	public static void main(String[] args)
	{
		char ch;
		
		// print the alphabet using the while loop
		ch = 'a';
		while(ch <= 'z')
		{
			System.out.print(" " + ch);
			ch++;
		}
	}
}