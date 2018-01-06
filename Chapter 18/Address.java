/*
	A class defining data for a mailing
	list.
*/
class Address
{
	private String name;
	private String street;
	private String city;
	private String state;
	private String zipCode;
	
	Address(String n, String s, String c, 
			String st, String zip)
	{
		name = n;
		street = s;
		city = c;
		state = st;
		zipCode = zip;
	}
	
	public String toString()
	{
		return name + "\n" + 
			   street + "\n" +
			   city + ", " + state +
			   "\n" + zipCode;
	}
}