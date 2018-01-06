import java.util.Scanner;

class Scanning
{
	public static void main(String[] args)
	{
		Scanner scan = new Scanner(System.in);
		
		System.out.println();
		String s = scan.nextLine();
		
		System.out.println();
		int i = scan.nextInt();
		
		System.out.println();
		double d = scan.nextDouble();
		
		System.out.println("String: " + s);
		System.out.println("Integer: " + i);
		System.out.println("Double: " + d);
	}
}