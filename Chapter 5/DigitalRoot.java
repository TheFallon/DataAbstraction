/*
	This program sorts an array of integers.
	First, by the value of their digital roots;
	secondly, by the value of the integer itself
	if the digitl roots are equal.
*/
class DigitalRoot
{
	static int digRoot(int n)
	{
		if(n==0) 
		{
			return 0;
		}
        else if(n%9 == 0) 
		{
			return 9;
		}
        else
		{
			return n%9;
		}
    
	}
	
	
	public static void main(String[] args)
	{
		
		int[] nums = { 35, 16, 42, 7 };
		int[] dRoot = new int[nums.length];
		
		for(int i = 0; i < nums.length; i++)
		{
			dRoot[i] = digRoot(nums[i]);
		}
		
		int t;
		
		for(int a = 1; a < nums.length; a++)
		{
			for(int b = nums.length - 1; b >= a; b--)
			{
				if(dRoot[b-1] > dRoot[b])
				{
					t = nums[b-1];
					nums[b-1] = nums[b];
					nums[b] = t;
					
					t = dRoot[b-1];
					dRoot[b-1] = dRoot[b];
					dRoot[b] = t;
				}
			}
		}
		
		for(int a = 1; a < nums.length; a++)
		{
			for(int b = nums.length - 1; b >= a; b--)
			{
				if(dRoot[b-1] == dRoot[b] && nums[b-1] > nums[b])
				{
					t = nums[b];
					nums[b] = nums[b-1];
					nums[b-1] = t;
				}
			}
		}
		
		
		
		for(int i = 0; i < nums.length; i++)
		{
			System.out.println(nums[i]);
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
}