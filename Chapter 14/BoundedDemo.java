/*
	This prgram demonstrates the stats class
	which has accepts a type which is bounded
	by the Number class and its subclasses.
*/
class BoundedDemo
{
	public static void main(String[] args)
	{
		Integer[] inums = {1,2,3,4,5,6,7,8,9,10};
		Stats<Integer> iob = new Stats<Integer>(inums);
		double v = iob.average();
		System.out.println("The average of iob is: " + v);
		
		Double[] dnums = {3.52,2.65,2.89,8.34,1.89,10.04,4.67,7.82,5.43,2.76};
		Stats<Double> iob2 = new Stats<Double>(dnums);
		double w = iob2.average();
		System.out.println("The average of iob2 is: " + w);
		
		Float[] fnums = {1.0F,2.0F,3.0F,4.0F,5.0F,6.0F,7.0F,8.0F,9.0F,10.0F};
		Stats<Float> iob3 = new Stats<Float>(fnums);
		double x = iob3.average();
		System.out.println("The average of iob3 is: " + x);
		
		// See which arrays have the same average.
		System.out.print("The averages of iob and iob2 are ");
		if(iob.sameAvg(iob2))
			System.out.println("the same.");
		else
			System.out.println("different.");
		
		System.out.print("The averages of iob and iob3 are ");
		if(iob.sameAvg(iob3))
			System.out.println("the same");
		else
			System.out.println("different.");

	}
}