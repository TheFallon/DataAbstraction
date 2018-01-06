/*
	This class creates a DigitalRoot object,
	and then uses it to calcuate and sort an
	array of digital roots.
*/
class DigitalRootDemo
{
	static void run()
	{
		int[] numbers = {81,22,33,15,11,14};
		DigitalRoot3 dRoot = new DigitalRoot3(numbers);
		dRoot.calcRoot();
		System.out.print("Before sorting: ");
		dRoot.display();
		dRoot.sort();
		dRoot.sortDRoot();
		dRoot.resortNums();
		System.out.println();
		System.out.print("After sorting: ");
		dRoot.display();
	}
	
	public static void main(String[] args)
	{
		run();
	}
}