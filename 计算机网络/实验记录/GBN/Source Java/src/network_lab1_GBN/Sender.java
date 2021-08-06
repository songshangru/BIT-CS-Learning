package network_lab1_GBN;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;
import java.util.Random;

public class Sender {
	int ports;
	InetAddress inet;
	DatagramSocket socket;
	
	Sender(int ps ,String ip) throws IOException {
		socket = new DatagramSocket();
		ports = ps;
		inet = InetAddress.getByName(ip);
	}
	
	public void sendPDU(PDU pdu, boolean genError) throws IOException{
		pdu.crc_gen();
		Main.start_timer(pdu.index);
		byte[] data = pdu.todatabyte();
	
		if (genError) {
			Random r = new Random();
			int ran1 = r.nextInt(100);
			if (ran1 < Main.RateLost) {	//Ä£Äâ¶ªÊ§Ö¡
				return;
			}
			
			int ran2 = r.nextInt(100);
			if (ran2 < Main.RateError) { //Ä£Äâ´íÎóÖ¡
				int ran3 = r.nextInt(data.length);
				if (ran3 <= 4) {
					ran3 = 5;
				}
				int ran4 = r.nextInt(8);
				data[ran3] ^= (1 << ran4);
			}
		}
		
		DatagramPacket datapac = new DatagramPacket(data,data.length,inet,ports);
		socket.send(datapac);
		
	}
	
	
}
