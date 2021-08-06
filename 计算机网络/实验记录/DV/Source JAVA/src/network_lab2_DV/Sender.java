package network_lab2_DV;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.util.Scanner;

public class Sender extends Thread {
	//向目标端口循环发送信息的线程类
	
	public int[] ports = new int[Main.maxRouterNum];
	public int neighborNum;
	public int sequence;
	InetAddress inet;
	DatagramSocket socket;
	
	Sender(String filename, String ip) throws Exception{
		socket = new DatagramSocket();
		File file = new File(filename);
		Scanner scan = new Scanner(file);
		neighborNum = 0;
		while(scan.hasNext()) {
			scan.next();
			scan.next();
			ports[neighborNum] = scan.nextInt();
			neighborNum++;
		}
		scan.close();
		inet = InetAddress.getByName(ip);
		sequence = 0;
	}
	
	public void send(Message m[], int length) throws Exception {
		String str = length + " ";
		for (int i = 0; i < length; i++) {
			str += m[i].SrcNode + " ";
			str += m[i].DestNode + " ";
			str += m[i].NeighborNode + " ";
			str += m[i].Distance + " ";
		}
		byte[] data = str.getBytes();
		for (int i = 0; i < neighborNum; i++) {
			DatagramPacket datapac = new DatagramPacket(data, data.length, inet, ports[i]);
			socket.send(datapac);
		}
	}
	
	public void print() throws Exception {
		sequence++;
		System.out.print("## Sent. Source Node = " + Main.router.localIndex + ";");
		System.out.println(" Sequence Number = " + sequence);
		for (int i = 0; i < Main.router.routerTable.size(); i++) {
			System.out.print("DestNode = " + Main.router.routerTable.get(i).DestNode + ";");
			System.out.print("Distance = " + Main.router.routerTable.get(i).Distance + ";");
			System.out.println("Neighbor = " + Main.router.routerTable.get(i).Neighbor);
		}
		FileOutputStream out = new FileOutputStream(Main.sendlog,true); 
		out.write(("## Sent. Source Node = " + Main.router.localIndex + ";").getBytes());
		out.write((" Sequence Number = " + sequence + "\n").getBytes());
		for (int i = 0; i < Main.router.routerTable.size(); i++) {
			out.write(("DestNode = " + Main.router.routerTable.get(i).DestNode + "; ").getBytes());
			out.write(("Distance = " + Main.router.routerTable.get(i).Distance + "; ").getBytes());
			out.write(("Neighbor = " + Main.router.routerTable.get(i).Neighbor + "\n").getBytes());
		}
		out.write("\n".getBytes());
		out.close();
	}
	
	public void run() {
		while(true) {
			try {
				sleep(Main.Frequency);//
				if(Main.pause == true) {//System.out.println("!!!");
					continue;
				}
				print();
				Message[] m = new Message[Main.router.routerTable.size()];
				for (int i = 0; i < Main.router.routerTable.size(); i++) {
					m[i] = new Message();
					m[i].SrcNode = Main.router.localIndex;
					m[i].DestNode = Main.router.routerTable.get(i).DestNode;
					m[i].NeighborNode = Main.router.routerTable.get(i).Neighbor;
					m[i].Distance = Main.router.routerTable.get(i).Distance;
				}
				send(m, m.length);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
