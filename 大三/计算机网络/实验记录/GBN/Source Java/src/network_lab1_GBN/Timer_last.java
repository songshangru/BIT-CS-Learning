package network_lab1_GBN;

public class Timer_last extends Thread {
	
	private int timeout;
	
	Timer_last(int tim){
		timeout = tim;
	}
	
	public void run() {
		int sleeptime = timeout;
		try {
			Thread.sleep(sleeptime);
			Main.last_timeout = true;
			return;
			
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
	}

}
