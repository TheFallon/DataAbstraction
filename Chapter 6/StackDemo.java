/*
	This class demonstrates the Stack
	class by creating two Stack objects,
	filling them with values, and then 
	popping them
*/
class StackDemo
{
	public static void main(String[] args)
	{
		Stack myStack1 = new Stack();
		Stack myStack2 = new Stack();
		
		//Push some numbers on the stacks.
		for(int i = 0; i < 10; i++)
		{
			myStack1.push(i);
		}
		for(int i = 10; i < 20; i++)
		{
			myStack2.push(i);
		}
		
		// Pop the numbers numbers off the stacks.
		System.out.println("Stack in myStack1");
		for(int i = 0;i<10;i++)
		{
			System.out.println(myStack1.pop());
		}
		
		System.out.println("Stack in myStack1");
		for(int i = 0;i<10;i++)
		{
			System.out.println(myStack2.pop());
		}
		
	}
}