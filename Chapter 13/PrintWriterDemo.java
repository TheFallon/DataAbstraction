import java.io.*;
/*
	This program demsonstrates using PrintWriter
	for handling console output.
*/
public class PrintWriterDemo
{
	public static void main(String[] args)
	{
		PrintWriter pw = new PrintWriter(System.out, true);
		
		pw.println("This is a String");
		int i = -7;
		pw.println(i);
		double d = 4.5e-7;
		pw.println(d);
	}
}