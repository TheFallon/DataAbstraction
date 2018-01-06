/*
	This class demonstrates overloaded constructors
*/
class Box
{
	double width, height, depth;
	
	Box(Box ob)
	{
		width = ob.width;
		height = ob.height;
		depth = ob.depth;
	}
	
	Box(double w, double h, double d)
	{
		width = w;
		height = h;
		depth = d;
	}
	
	Box()
	{
		width = -1;		// -1 indicates an uninitialized box.
		height = -1;
		depth = -1;
	}
	
	Box(double len)
	{
		width = height = depth = len;
	}
	
	double volume()
	{
		return height*width*depth;
	}
}