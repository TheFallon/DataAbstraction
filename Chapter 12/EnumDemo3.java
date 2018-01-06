/*
	This class demonstrates the Cars enumuration
	class which conatins instance variables, a constructor,
	and a get method.
*/
class EnumDemo3
{
	public static void main(String[] args)
	{
		Cars car;
		
		// Displays the price of an Audi.
		System.out.println("An Audi costs " +
						   Cars.Audi.getPrice() +
						   " dollars. \n");
						   
		// Display all of the Cars and prices
		System.out.println("All car prices");
		for(Cars c : Cars.values())
		{
			System.out.println(c + " costs " + c.getPrice() +
							   " dollars.");
		}
	}
}