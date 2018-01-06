import java.util.Random;
/*
	This class solves the selection problem;
	finding the kth value of an array of N size.
	It aslo displays a table of the running
	times for various values of N.
*/
class SelectionProblem
{
	public static void main(String[] args)
	{
		int n = Integer.parseInt(args[0]); 	// The number of integers to be sorted.
		int k = n / 2;					    // The position of the element we are looking to find.
		int[] nums = new int[n];		// An array to hold the numbers we are looking to sort.
		Random rand = new Random(n);		    // Random varaiable to populate the nums array.
		
		// Poulate the array with Random integers.
		for(int i = 0; i < n; i++)
		{
			nums[i] = rand.nextInt(n) + 1;
			System.out.println(nums[i]);
		}
		
		// Aquire and display the starting of the application
		// before starting the SelectionSort algorithm.
		long startTime = System.currentTimeMillis();
		System.out.println(startTime);
	}
	
	public int[] selectionSort(int[] nums, int k)
	{
		int min = k;
		
		return nums;
	}
}