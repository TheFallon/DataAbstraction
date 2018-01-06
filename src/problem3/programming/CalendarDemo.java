package problem3.programming;

public class CalendarDemo  {
	public static void main(String[] args) throws MonthException, DayException {
		CalendarDate date = new CalendarDate(1,1,2018);
		
		for(int i = 0; i < 365; i++) {
			
			date.getLongDate();
			date.incrementDate();
			System.out.println();
		}
		
		
	}
}
