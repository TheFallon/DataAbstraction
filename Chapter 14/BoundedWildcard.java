/*
	This program demonstrates the principle of Bounded
	Wild Cards.
*/

// Two-dimensional coordinates
class TwoD {
	int x, y;
	
	TwoD(int a, int b){
		x = a;
		y = b;
	}
}

// Three-dimensional coordinates.
class ThreeD extends TwoD {	
	int z;
	
	ThreeD(int a, int b, int c){
		super(a, b);
		z = c;
	}
}

// Four-dimensional coordinates
class FourD extends ThreeD {
	int t;
	
	FourD(int a, int b, int c, int d){
		super(a, b, c);
		t = d;
	}
}

// This class holds an array of coordinate objects.
class Coords<T extends TwoD> {
	T[] coords;
	
	Coords(T[] o){ coords = o; }
}

// dDemonstrates bounded wildcards.
class BoundedWildcard {
	static void showXY(Coords<?> c){
		System.out.println("X Y Coordinates:");
		for(int i = 0; i < c.coords.length; i++)
			System.out.println(c.coords[i].x + " " + c.coords[i].y);
		System.out.println();
	}
	
	static void showXYZ(Coords<? extends ThreeD> c){
		System.out.println("X Y Z Coordinates:");
		for(int i = 0; i < c.coords.length; i++)
			System.out.println(c.coords[i].x + " " + c.coords[i].y + " " + c.coords[i].z);
		System.out.println();
	}
	
	static void showAll(Coords<? extends FourD> c){
		System.out.println("X Y Z T Coordinates:");
		for(int i = 0; i < c.coords.length; i++)
			System.out.println(c.coords[i].x + " " + c.coords[i].y + " " + c.coords[i].z + " " + c.coords[i].t);
		System.out.println();
	}
	
	public static void main(String[] args){
		TwoD[] td = {
			new TwoD(0, 0),
			new TwoD(7, 9),
			new TwoD(18, 4),
			new TwoD(-1, -23)
		};
		
		Coords<TwoD> tdlocs = new Coords<TwoD>(td);
		
		System.out.println("Contents of tdlocs.");
		// This works because this is a TwoD object.
		
		// This does not because this is not a ThreeD or FourD object.
		showXY(tdlocs);
		// showXYZ(tdlocs);
		// showAll(tdlocs);
		
		// Now create some ForD objects.
		FourD[] fd = {
			new FourD(1, 2, 3, 4),
			new FourD(6, 8, 14, 6),
			new FourD(22, 9, 4, 9),
			new FourD(3, -2, -23, 17)
		};
		
		Coords<FourD> fdlocs = new Coords<FourD>(fd);
		
		System.out.println("Contents of fdlocs.");
		
		// These are all ok.
		showXY(fdlocs);
		showXYZ(fdlocs);
		showAll(fdlocs);
	}
}