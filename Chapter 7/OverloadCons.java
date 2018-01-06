/*
	This class demonstrates the overloaded
	constructors of the Box class.
*/
class OverloadCons
{
	public static void main(String[] args)
	{
		// Create boxes using the various constructors.
		Box myBox = new Box(10,20,15);
		Box myBox2 = new Box();
		Box myCube = new Box(7);
		
		double vol;
		
		// Get the volume of the first box.
		vol = myBox.volume();
		System.out.println("Volume of myBox is " + vol);
		
		vol = myBox2.volume();
		System.out.println("Volume of myBox1 is " + vol);
		
		vol = myCube.volume();
		System.out.println("Volume of myCube is " + vol);
		
	}
}