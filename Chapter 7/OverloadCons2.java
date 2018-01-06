/*
	Demonstrate the constructor, in the Box
	class, which creates a new object and sets
	its class variables equal to the value of 
	the class variables of an object of the Box
	class by passing an object to the constructor.
*/
class OverloadCons2
{
	public static void main(String[] args)
	{
		// Create boxes using the various constructors.
		Box myBox = new Box(10,20,15);
		Box myBox2 = new Box(7);
		Box myCube = new Box();
		
		Box myClone = new Box(myBox); // Create a copy of box 1.
		
		double vol;
		
		vol = myBox.volume();
		System.out.println("Volume of myBox " + vol);
		
		vol = myBox2.volume();
		System.out.println("Volume of myBox1 " + vol);
		
		vol = myCube.volume();
		System.out.println("Volume of myCube " + vol);
		
		vol = myClone.volume();
		System.out.println("Volume of myClone " + vol);
	}
}