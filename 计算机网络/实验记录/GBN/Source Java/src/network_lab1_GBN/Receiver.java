package network_lab1_GBN;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.DatagramSocket;
import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.SocketException;

public class Receiver extends Thread{
	int portr;
	InetAddress inet;
	DatagramSocket socket;
	
	Receiver(int pr ,String ip) throws IOException {
		socket = new DatagramSocket(pr);
		portr = pr;
		inet = InetAddress.getByName(ip);
	}
	
	public void run() {
		PDU pdu_unit = new PDU();
		byte[] databuf = new byte[Main.DataSize+7];
		while(true) {
			try {
				DatagramPacket datapac = new DatagramPacket(databuf,Main.DataSize+7);
				socket.receive(datapac);
				
				byte[] data = datapac.getData();
				pdu_unit.bytetoPDU(data);
//				for(int i=0;i<10;i++)
//						System.out.print(data[i]);
//					System.out.println();
				//System.out.println(data.length);
				if(pdu_unit.crc_verify() == true) {
					
					//接收帧正确
					PDU pdu_recv = new PDU();
					pdu_recv.myclone(pdu_unit);
					//System.out.println("!!!");
					Message m = new Message(Type.recv_data,pdu_recv);
					try {
						Main.msg.put(m);
			        } catch (InterruptedException e) {
			            //e.printStackTrace();
			        }
					//System.out.println("RecvThread: "+pdu_unit.index+" "+pdu_unit.type);
					
				}else {
					FileOutputStream out = new FileOutputStream(Main.recvlog,true); 
					out.write(("recv_num=" + "unk" + ",recv_exp=" + Main.pdu_expected + ",status=" + "DataErr" + '\n').getBytes());
					out.close();
					//接收帧错误
					//Main.queue_event.add(EventType.cksum_err);
				}
			}catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
