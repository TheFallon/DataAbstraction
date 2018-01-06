/*
	This class creates implements multithreading
	via the runnable API.
*/
class Caller2 implements Runnable
{
	String msg;
	CallMe2 target;
	Thread t;
	
	public Caller2(CallMe2 targ, String s)
	{
		target = targ;
		msg = s;
		t = new Thread(this);
		t.start();
	}
	
	// This method synchronizes calls to the
	// call method of the CallMe2 class
	public void run()
	{
		// This is a synchronized block
		synchronized(target) // <-- Notice the CallMe2 object resides inside the parameter list
		{					 
			target.call(msg);
		}
	}
}