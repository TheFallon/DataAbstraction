/*
	This program demonstrates the functionality
	of enumerations of the Type Apple.
*/
class EnumDemo
{
	public static void main(String[] args)
	{
		Apple ap;
		
		ap = Apple.RedDel;
		
		// Output an enum value
		System.out.println("Value of ap: " + ap);
		System.out.println();
		
		ap = Apple.GoldenDel;
		
		// Compare two enum values
		if(ap == Apple.GoldenDel)
		{
			System.out.println("ap contains GoldenDel.\n");
		}
		
		// Use enum to control a swict statement.
		switch(ap)
		{
			case Jonathan:
				System.out.println("Jonathan is Red");
				break;
			case GoldenDel:
				System.out.println("Golden Deilcious is Yellow");
				break;
			case RedDel:
				System.out.println("Red Delicious is Red");
				break;
			case Winesap:
				System.out.println("Winesap is Red");
				break;
			case Cortland:
				System.out.println("Corland is Red");
				break;
		}
	}
}