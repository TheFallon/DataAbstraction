/*
	This class works in conjunction with the
	CallMe class to demonstrate the principle of
	synchronization.
*/
class Caller implements Runnable
{
	String msg;
	CallMe target;
	Thread t;
	
	public Caller(CallMe targ, String s)
	{
		target = targ;
		msg = s;
		t = new Thread(this);
		t.start();
	}
	
	public void run()
	{
		target.call(msg);
	}
}