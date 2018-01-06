/*
	This class serves as the blue print for
	object that can be instantiated by other
	classes to calculate an arrray of digital
	roots, and then organize the integers in the
	array, firstly, by the value of their digital 
	root, and seconddarirly by the value of the
	integer if their digital roots are equal.
*/
class DigitalRoot3{
	private static int[] numbers;
	private static int[] digRoot;
	
	DigitalRoot3(int[] num) {
		numbers = num;
	}
	
	public static void calcRoot(){
		int i;
		
		digRoot = new int[numbers.length];
		for(i = 0;i < numbers.length;i++){
			if(numbers[i]==0)
				digRoot[i] = 0;
			else if(numbers[i]%9==0)
				digRoot[i] = 9;
			else
				digRoot[i] = numbers[i]%9;
		}
	}
	
	public static void sort() {
		int a, b, temp;
		
		for(a = 1; a < numbers.length; a++) {
			for(b = numbers.length - 1; b >= a; b--) {
				if(digRoot[b-1] > digRoot[b]) {
					
					temp = numbers[b-1];
					numbers[b-1] = numbers[b];
					numbers[b] = temp;
					
					temp = digRoot[b-1];
					digRoot[b-1] = digRoot[b];
					digRoot[b] = temp;
				}
			}
		}
	}
	
	public static void sortDRoot() {
		int a, b, temp;
		
		for(a = 1; a < digRoot.length; a++) {
			for(b = digRoot.length - 1; b >= a; b--) {
				if(digRoot[b-1] > digRoot[b]) {
					
					temp = digRoot[b-1];
					digRoot[b-1] = digRoot[b];
					digRoot[b] = temp;
					
				}
			}
		}
	}
	
	public static void resortNums() {
		int a, b, temp;
		
		for(a = 1; a < numbers.length; a++) {
			for(b = numbers.length - 1; b >= a; b--) {
				if(digRoot[b-1] == digRoot[b] && numbers[b-1] > numbers[b]) {
					temp = numbers[b];
					numbers[b] = numbers[b-1];
					numbers[b-1] = temp;
				}
			}
		}
	}
	
	public static void display() {
		int i;
		
		System.out.println("Number     Digital Root");
		
		for(i = 0;i < numbers.length;i++) {
			if(numbers[i] > 10) 
				System.out.println("                  " + numbers[i]+ "         " + digRoot[i]);
			else 
				System.out.println("                   " + numbers[i]+ "         " + digRoot[i]);
		}
	}
}