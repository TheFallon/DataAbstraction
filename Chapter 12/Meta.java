import java.lang.annotation.*;
import java.lang.reflect.*;

/**
	This class demonstrates the use of annotation's
	as used by the Java language, not by development
	and deployment tools.
*/

// Ann annotation type declaration.
@Retention(RetentionPolicy.RUNTIME)
@interface MyAnno
{
	String str();
	int val();
}

class Meta
{
	// Annotate myMeth
	@MyAnno(str = "Annotation Example . . . biyatch", val = 101)
	public static void myMeth()
	{
		Meta ob = new Meta();
		
		// Obtain the annotation for this method
		// and display the value of its member.
		try
		{
			// First, get a class object that represents
			// this class
			Class<?> c = ob.getClass();
			
			// Now, get a method object that rpresents
			// this method.
			Method m = c.getMethod("myMeth");
			
			// Next, get the annotation for this class.
			MyAnno anno = m.getAnnotation(MyAnno.class);
			
			// Finally, display the values.
			System.out.println(anno.str() + " " + anno.val());
		}
		catch(NoSuchMethodException exc)
		{
			System.out.println("Sorry that shit don't exist.");
		}
	}
	
	public static void main(String[] args)
	{
		myMeth();
	}
}