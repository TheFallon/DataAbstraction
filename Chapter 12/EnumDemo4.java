/*
	This class demonstrates .equals() and
	.compareTo() and .ordinal() methods of an enumuration
	class.
*/
class EnumDemo4
{
	public static void main(String[] args)
	{
		Cars car1, car2, car3;
		
		// Obtains all ordinal values using .ordinal().
		System.out.println("Here are all the Car constants " +
							"and there ordinal values.");
		for(Cars c : Cars.values())
		{
			System.out.println(c + " " + c.ordinal());
		}
		
		car1 = Cars.BMW;
		car2 = Cars.Audi;
		car3 = Cars.BMW;
		
		// Demonstrates compareTo() and equals()
		if(car1.compareTo(car2) < 0)
		{
			System.out.println(car1 + " comes before " + car2);
		}
		
		if(car1.compareTo(car2) > 0)
		{
			System.out.println(car2 + " comes before " + car1);
		}
		
		if(car2.compareTo(car3) == 0)
		{
			System.out.println(car1 + " equals " + car3);
		}
		
		System.out.println();
		
		if(car1.equals(car2))
		{
			System.out.println("Error");
		}
		
		if(car1.equals(car2))
		{
			System.out.println(car1 + " equals " + car3);
		}
		
		if(car2 == car3)
		{
			System.out.println(car1 + " == " + car3);
		}
	}
}