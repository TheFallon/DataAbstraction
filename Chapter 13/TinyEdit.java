import java.io.*;
/*
	This program also reads lines of text from the
	console and reprints then. I don't know why it
	is called "TinyEdit," as I don't see any editing
	going on.
*/
class TinyEdit
{
	public static void main(String[] args) throws IOException
	{
		// Create a BufferedReader to read console I/O
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		
		int size = 100;
		String[] str = new String[size];
		
		System.out.println("Enter lines of text");
		System.out.println("Enter 'stop' to quit");
		for(int i = 0; i < size; i++)
		{
			str[i] = br.readLine();
			if(str[i].equals("stop")) break;
		}
		
		System.out.println("\nHere is your file:");
		
		for(int i = 0; i < size; i++)
		{
			if(str[i].equals("stop")) break;
			System.out.println(str[i]);
		}
	}
}