import java.io.*;
/*
	This program uses the FileOutpuStream
	and FileOutputStream classes to copy 
	the contents of one file to a new file.
*/
class CopyFile
{
	public static void main(String[] args) throws IOException
	{
		int i;
		
		// First confirm that a file name has been passed
		// on the command line.
		if(args.length != 2)
		{
			System.out.println("Usage: CopyFile inputFile outputFile");
			return;
		}
		
		// Copy the file.
		try(FileInputStream fin = new FileInputStream(args[0]); FileOutputStream fout = new FileOutputStream(args[1]))
		{
			do
			{
				i = fin.read();
				if(i != -1) 
				{
					fout.write(i);
				}
			} while(i != -1);
		}
		catch(IOException e)
		{
			System.out.println("I/O error: " + e);
		}
	}
}