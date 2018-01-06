import java.util.*;
/*
	Demonstrate the ArrayList class
*/
class ArrayListDemo
{
	public static void main(String[] args)
	{
		// Create an array list.
		ArrayList<String> al = new ArrayList<String>();
		
		System.out.println("Initial size of al: " + al.size());
		
		// Add elements to the ArrayList
		al.add("C");
		al.add("A");
		al.add("E");
		al.add("B");
		al.add("D");
		al.add("F");
		al.add(1, "A2");
		al.add(3, "A4");
		
		System.out.println("Size of al after additions: " + al.size());
		
		// Display the ArrayList.
		System.out.println("Contents of al: " + al);
		
		// Remove elements form the ArrayList.
		al.remove("F");
		al.remove(2);
		
		System.out.println("Size of al after removals: " + al.size());
		
		System.out.println("Contents of al after removals: " + al);
	}
}