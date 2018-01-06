/*
	This program sorts an array of integers.
	First, by the value of their digital roots;
	secondly, by the value of the integer itself
	if the digitl roots are equal. It does this by 
	calling several methods that each perform a 
	different part of the operation.
*/
class DigitalRoot2 {
	
	static int[] digRoot(int[] num) {
		
		int[] digiRoot = new int[num.length];
		int i = 0;
		
		for(i = 0;i < num.length;i++) {
			if(num[i]==0) 
				digiRoot[i] = 0;
			else if(num[i]%9 == 0) 
				digiRoot[i] = 9;
			else 
				digiRoot[i] = num[i]%9;
		}
		return digiRoot;
	}
	
	static void display(int[] n, int[] dr) {
		int i;
		
		System.out.println("Number     Digital Root");
		
		for(i = 0;i < dr.length;i++) {
			if(n[i] > 10) 
				System.out.println("  " + n[i]+ "         " + dr[i]);
			else 
				System.out.println("   " + n[i]+ "         " + dr[i]);
		}
		System.out.println("It works");
	}
	
	static int[] sort(int[] num1, int[] num2) {
		int a, b, temp;
		
		for(a = 1; a < num1.length; a++) {
			for(b = num1.length - 1; b >= a; b--) {
				if(num2[b-1] > num2[b]) {
					
					temp = num1[b-1];
					num1[b-1] = num1[b];
					num1[b] = temp;
					
					temp = num2[b-1];
					num2[b-1] = num2[b];
					num2[b] = temp;
				}
			}
		}
		return num1;
	}

	static int[] resort(int[] num1, int[] num2) {
		int a, b, temp;
		
		for(a = 1; a < num1.length; a++) {
			for(b = num1.length - 1; b >= a; b--) {
				if(num2[b-1] == num2[b] && num1[b-1] > num1[b]) {
					temp = num1[b];
					num1[b] = num1[b-1];
					num1[b-1] = temp;
				}
			}
		}
		return num1;
	}
	
	static void run() {
		int[] nums = {15,31,12,67,81,43};
		int[] dRoot = new int[nums.length];
		
		dRoot = digRoot(nums);
		sort(nums, dRoot);
		sort(dRoot, dRoot);
		resort(nums, dRoot);
		display(nums, dRoot);
	}
	
	public static void main(String[] args) {
		run();
	}
}