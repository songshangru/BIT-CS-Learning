package network_lab2_DV;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;


//循环接收消息的线程类
public class Receiver extends Thread {
	int portr;
	InetAddress inet;
	DatagramSocket socket;
	
	Receiver(int _portr ,String ip) throws IOException {
		socket = new DatagramSocket(_portr);
		portr = _portr;
		inet = InetAddress.getByName(ip);
	}
	
	public void run() {
		byte[] databuf = new byte[1024];
		while(true) {
			try {
				if(Main.pause == true) {
					//continue;
				}
				DatagramPacket datapac = new DatagramPacket(databuf, 1024);
				socket.receive(datapac);
				byte[] data = datapac.getData();
				String str = new String(data);
				Main.event.add(EventType.receive_message);
				Main.recv.add(str);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
