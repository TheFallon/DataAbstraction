import java.util.HashSet;
/**
	Demonstrate a HashSet.
*/
class HashSetDemo
{
	public static void main(String[] args)
	{
		// Create a HashSet.
		HashSet<String> hs = new HashSet<String>();
		
		// Add elements to the Hash Set.
		hs.add("Alpha");
		hs.add("Beta");
		hs.add("Epsilon");
		hs.add("Eta");
		hs.add("Gamma");
		hs.add("Omega");
		
		System.out.println(hs);
	}
}