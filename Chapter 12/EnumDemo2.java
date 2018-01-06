/*
	This class demonstrates the built in
	methods of enumurations .values() and
	.valuesof()
*/
class EnumDemo2
{
	public static void main(String[] args)
	{
		Apple ap;
		
		System.out.println("Here are all the Apple constants.");
		
		Apple[] allApples = Apple.values();
		
		for(Apple a : allApples)
		{
			System.out.println(a);
		}
		
		System.out.println();
		
		// use valueOf()
		ap = Apple.valueOf("Winesap");
		System.out.println("ap contains: " + ap);
	}
}