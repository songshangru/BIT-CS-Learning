package network_lab2_DV;

public class Timer extends Thread {
	public String neighbor;
	private boolean recv;
	Timer(String s){
		neighbor = s;
		recv = false;
	}
	
	public void run() {
		while(true) {
			recv = false;
			try {
				sleep(Main.MaxValidTime);
				if (recv == false) {
					Main.event.add(EventType.time_out);
					Main.recv.add(neighbor);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public void receive() {
		recv = true;
	}
	
}
