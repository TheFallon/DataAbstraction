package problem3.programming;



public class CalendarDate {
	private final int MAX_MONTH = 12;
	private int maxDay;
	private Integer day;
	private Integer month;
	private Integer year;
	
	
	public CalendarDate(int month, int day, int year) throws MonthException, DayException {
		this.maxDay = setMaxDays(month, year);
		validateDate(day, month);
		this.day = day;
		this.month = month;
		this.year = year;
		
		
	}
	
	private int setMaxDays(int month, int year) {
		int maxDays = 0;
		if(month == 1 || month == 3 || month == 5 || month == 7 ||
							month == 8 || month == 10 || month == 12) {
			maxDays = 31;
		}
		
		if(month == 4 || month == 6 || month == 9 || month == 11 ){
			maxDays = 30;
		}
		
		if(month == 2) {
			if(year % 4 == 0 && year % 100 != 0) {
				maxDays = 29;
			}
			else if(year % 4 == 0 && year % 100 == 0 && year % 400 == 0) {
				maxDays = 29;
			}
			else {
				maxDays = 28;
			}
		}
		return maxDays;
	}
	
	public void validateDate(int day, int month) throws DayException, MonthException {
		if(month > this.MAX_MONTH) {
			throw new MonthException("Month is out of range");
		}
		if(day > this.maxDay) {
			throw new DayException("Day is out of range");
		}
	}
	
	public void incrementDate() {
		if(day < maxDay) {
			day++;
		}
		else if(day == maxDay && month < MAX_MONTH ) {
			month++;
			day = 1;
			setMaxDays(month, year);
		}
		else if(day == maxDay && month == MAX_MONTH) {
			day = 1;
			month = 1;
			year++;
			maxDay = 31;
		}
	}
	
	public String getDate() {
		StringBuilder sb = new StringBuilder();
		sb.append(month.toString() + "/");
		sb.append(day.toString() + "/");
		sb.append(year.toString());
		 
		return sb.toString();
	 }
	
	private int calculateDOW() {
		
		int dayOfWeek;		// Integer to return to caller.
		int YEAR;			// The shifted year in 4 digit format.
		double DOW = 0;		// Integer representation of the day of week.
		double year;		// The year in 2 digit format.
		double century;		// The century in 2 digit format.
		double day;			// The day in number format.
		double month = 0;		// The month in number format.
		
		
		// Set the value of YEAR equal to the 
		// year. Shift it down by one if the month
		// is January or February.
		if(this.month == 1 || this.month == 2) {
			YEAR = this.year - 1;
		}
		else {
			YEAR = this.year;
		}
		
		// Set the century equal to the first two 
		// digits of the current year.
		century = YEAR / 100;
		
		// Set the year equal to the remainder of
		// the current year / 100.
		year = YEAR % 100;
		
		// Set day equal to the current day.
		day = this.day;
		
		// Set month equal to the current month
		// shifted down by two.
		if(this.month > 2) {
			month = this.month - 2;
		}
		else if (this.month == 1 || this.month == 2) {
			month = this.month + 10;
		}
		/*
		System.out.println(day);
		System.out.println(month);
		System.out.println(century);
		System.out.println(year);
		System.out.println(YEAR);
		*/
		// Calculate a numerical representation of
		// the day of the week.
		DOW = (day + ((2.6 * month) - 0.2) + year + ((year / 4) + (century / 4)) - (2 * century));
		
		// Cast the day of week to an integer value.
		dayOfWeek = (int)DOW;
		
		// Get the remainder of the dayOfWeek divided by 7.
		dayOfWeek = dayOfWeek % 7;
		
		
		
		// If day of week < 0, add seven to that number.
		if(dayOfWeek < 0 && dayOfWeek >= -7) {
			dayOfWeek += 7;
		}
		
		if(dayOfWeek < -7) {

			dayOfWeek = 0;
		}
		
		System.out.print(dayOfWeek + " ");
		
		return dayOfWeek;
	}
	
	public void getLongDate() {
		int DOW = calculateDOW();
		String day = "";
		
		switch(DOW) {
		case 0 :
			day = "Sunday";
			break;
		case 1 :
			day = "Monday";
			break;
		case 2 :
			day = "Tuesday";
			break;
		case 3 :
			day = "Wednesday";
			break;
		case 4 :
			day = "Thursday";
			break;
		case 5 :
			day = "Friday";
			break;
		case 6 :
			day = "Saturday";
			break;
		}
		
		System.out.println(day);
	}
	
	
	
	
	
	
	
	
}
