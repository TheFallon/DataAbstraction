/*
	This class creates an enumeration class, and 
	gives it an instance variable, a constructor, 
	and member methods.
*/
enum Cars
{
	Mercedes(48000), BMW(52000), Lexus(44000), Audi(62000);
	
	private int price; // price of each car
	
	Cars(int p)
	{
		price = p;
	}
	
	int getPrice()
	{
		return price;
	}
}