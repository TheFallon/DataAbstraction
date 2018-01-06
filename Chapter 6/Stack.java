/*
	This class defines an integer stack that can 
	hold ten values
*/
class Stack
{
	int stck[] = new int[10];
	int tos;
	
	Stack()
	{
		tos = -1;
	}
	
	// Push an intem onto the stack.
	void push(int item)
	{
		if(tos==9)
		{
			System.out.println("Stack is full");
		}
		else
		{
			stck[++tos] = item;
		}
	}
	
	int pop()
	{
		if(tos < 0)
		{
			System.out.println("Stack underflow");
			return 0;
		}
		else
		{
			return stck[tos--];
		}
	}
}