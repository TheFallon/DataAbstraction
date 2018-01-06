import java.util.LinkedList;
/*
	Demonstrate LinkedList
*/
class LinkedListDemo
{
	public static void main(String[] args)
	{
		// Create a LinkedList
		LinkedList<String> ll = new LinkedList<String>();
		
		// Add elements to the LinkedList
		ll.add("F");
		ll.add("B");
		ll.add("D");
		ll.add("E");
		ll.add("C");
		ll.add("G");
		ll.addFirst("Z");
		ll.addLast("A");
		
		ll.add(1, "A2");
		
		System.out.println("Original contents of ll: " + ll);
		
		// Remove elements from the LinkedList
		
		ll.remove("F");
		ll.remove(2);
		
		System.out.println("Contents of ll after deletion: " + ll);
		
		// Remove first and last elements os ll.
		ll.removeLast();
		ll.removeFirst();
		
		System.out.println("ll after removing the first and last elements: " + ll);
		
		// Get and set a value.
		String val = ll.get(2);
		ll.set(2, val + " Changed");
		
		System.out.println("ll after changes: " + ll);
	}
}