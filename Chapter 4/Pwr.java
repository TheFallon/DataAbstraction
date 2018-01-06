/*
	This class demonstrates the use of the "this"
	keyword, although it is not a necessary part
	of this class or the one which utilizes it.
*/
class Pwr
{
	double b;
	int e;
	double val;
	
	Pwr(double base, int exp)
	{
		this.b = base;
		this.e = exp;
		
		this.val = 1;
		
		if(exp==0)
		{
			return;
		}
		
		for( ; exp > 0; exp--)
		{
			this.val = this.val * base;
		}
		
		double get_Power()
		{
			return this.val;
		}
	}
}