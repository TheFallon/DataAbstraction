import java.io.*;
/*
	This program reads lines of input
	as opposed to simply characters.
*/
class BRReadLines
{
	public static void main(String[] args) throws IOException
	{
		// Creates a buffered reader.
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		
		String str;
		System.out.println("Enter lines of text.");
		System.out.println("Enter 'stop' to quit.");
		
		do
		{
			str = br.readLine();
			System.out.println(str);
		}while(!str.equals("stop"));
	}
}