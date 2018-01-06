/*
	This is the vehicle class, which
	will be used by the main method of 
	other classes
*/
class Vehicle
{
	int passengers;	// number of passengers.
	int fuelCap;	// fuel capacity in gallons.
	int mpg;		// fuel consuption in miles per gallon.
	
	Vehicle(int p, int f, int m)
	{
		passengers = p;
		fuelCap = f;
		mpg = m;
	}
	
	void range()
	{
		System.out.println("Range is: " + fuelCap * mpg);
	}
	
	int range()
	{
		return fuelCap * mpg;
	}
	
	double fuelNeeded(int miles)
	{
		return (double) miles / mpg;
	}
}