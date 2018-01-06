import java.util.ArrayList;
/*
	Convert an ArrayList to an array
*/
class ArrayListToArray
{
	public static void main(String[] args)
	{
		// Create an integer ArrayList.
		ArrayList<Integer> al = new ArrayList<Integer>();
		
		// Aadd elements to the array list.
		al.add(1);
		al.add(2);
		al.add(3);
		al.add(4);
		al.add(5);
		
		System.out.println();
		
		// Get the array
		Integer[] ia = new Integer[al.size()];
		ia = al.toArray(ia);
		
		int sum = 0;
		
		// Sum the array.
		for(int i : ia) sum += i;
		
		System.out.println("Sum is: " + sum);
	}
}