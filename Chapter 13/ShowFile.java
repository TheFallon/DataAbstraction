import java.io.*;
/*
	This program accepts a command line argument
	that corresponds to a textfile. It the opens 
	the file and reads the output to the console.
*/
class ShowFile
{
	public static void main(String[] args)
	{
		int i;
		
		// First verify that a file name has been specified.
		if(args.length != 1)
		{
			System.out.println("Usgae: ShowFile filename");
			return;
		}
		
		// Create a FileInputStream object
		// Open the file
		// Read and print it's contents
		// Close the file.
		try(FileInputStream fin = new FileInputStream(args[0]))
		{	
			do
			{
				i = fin.read();
				if(i != -1)
				{
					System.out.print((char) i);
				}
				if(i == 0)
				{
					System.out.println();
				}
				
			}while(i != -1);
		}
		catch(FileNotFoundException e)
		{
			System.out.println("Cannot open file.");
			return;
		}
		catch(IOException e)
		{
			System.out.println("Error reading the file dipstick");
		}
	}
}