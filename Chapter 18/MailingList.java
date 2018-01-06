import java.util.LinkedList;
/*
	This class creates a LinkedList of the
	type Address (defined in the Address class)
	and then uses it to store and display Address'.
*/
class MailingList
{
	public static void main(String[] args)
	{
		LinkedList<Address> addy = new LinkedList<Address>();
		
		// Add Address' to the LinkedList.
		addy.add(new Address("Terrence Campbell", "2415 Cedarcrest Pl.",
				 "Valrico", "Florida", "33596"));
		addy.add(new Address("Arron Eckhart", "80 Adams St.",
				 "East Rockaway", "New York", "10158"));
		addy.add(new Address("Courtney Colmery", "3645 Massachusetts Ave.",
			     "East Falls Church", "Virginia", "21050"));
				 
		// Display the address' in the LinkedList.
		for(Address element : addy)
			System.out.println(element + "\n");
		
		System.out.println();
	}
}