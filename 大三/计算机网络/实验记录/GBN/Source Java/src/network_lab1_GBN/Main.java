package network_lab1_GBN;
import java.util.LinkedList;
import java.util.LinkedHashMap;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Queue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.Scanner;
import java.io.IOException;
import java.io.InputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.File;
import java.io.FileInputStream;
import java.util.Map;


public class Main {
	static int GBNSendPort;
	static int GBNRecvPort;
	static int MaxFrames = 10240;
	static int DataSize;
	static int RateError;
	static int RateLost;
	static int SizeSW;
	static int InitSeqNo;
	static int Timeout;
	static String IP="127.0.0.1";
	static String sendfile;
	static String recvfile;
	static File sendlog;
	static File recvlog;
	
	static Sender sender;
	static Receiver recv_thread;
	
	static Map pdu_timer = new LinkedHashMap<Integer,Timer>();
	static Map buffer = new LinkedHashMap<Integer,Message>();
	
	static boolean ack[];
	
	static int cnt_pdu_read = 0;
	static int cnt_pdu_write = 0;
	static int cnt_buffer=0;              //发送缓冲区计数
	
	static int cnt_send=0;
	static int cnt_recv=0;
	
	static int pdu_expected = 0;			  //期待接收的帧号
	static int ack_expected = 0;              //期待接收的确认帧号
	static int next_pdu_send = 0;          //要发送的帧号
	static int cur_pdu_read = 0;
	
	static int send_end_pdu = -1; 
	static boolean is_sending = true;
	static boolean is_recving = false;
	static boolean is_send_start = false;
	
	static boolean in_timeout = false;
	static boolean last_timeout = false;
	
	static long startTime = -1;
	static long endTime = -1;
	static long activeTime = -1;
	
	
	
	static public PDU[] pdus_read = new PDU[MaxFrames];
	static public PDU[] pdus_write = new PDU[MaxFrames];
	
	public static BlockingQueue<Message> msg = new LinkedBlockingQueue<Message>();
	public static BlockingQueue<Integer> time_lock = new LinkedBlockingQueue<Integer>(1);
	
	static void Readfile() {
		cnt_pdu_read = 0;
		int cnt_byte = 0;
		PDU unit = new PDU();
		byte[] unit_input = new byte[DataSize];
		
		try {
			InputStream input = new FileInputStream(sendfile);
			while((cnt_byte = input.read(unit_input))!=-1) {
				unit.data = unit_input.clone();
				System.arraycopy(unit_input, 0, unit.data, 0, cnt_byte);
				unit.len = cnt_byte;
				unit.index = cnt_pdu_read;
				unit.type = 1;
				unit.ack_index = -1;
				pdus_read[cnt_pdu_read] = new PDU();
				pdus_read[cnt_pdu_read].myclone(unit);
				cnt_pdu_read++;
			}
			input.close();
		}catch(IOException e){
			e.printStackTrace();
		}
	}
	
	static void Writefile() {
		
		PDU pdu = new PDU();
		byte[] file = new byte[cnt_pdu_write * DataSize];
		int len_file = 0;
		for(int i = 0; i < cnt_pdu_write; i++) {
			pdu.myclone(pdus_write[i]);
			System.arraycopy(pdu.data, 0, file, len_file, pdu.len);
			len_file += pdu.len;
		}
		try {
			FileOutputStream output = new FileOutputStream(recvfile);
			output.write(file,0,len_file);
			output.close();
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	static public int inc(int x) {
		x = (x + 1) % (SizeSW + 1);  
		return x;
	}
	
	static public boolean between(int a,int b,int c) {
		if(((a <= b) && (b < c)) 
				|| ((a <= b) && (c < a)) 
				|| ((c < a) && (b < c))) {
			return true;
		}
		return false;
	}
	
	public static void main(String[] args) throws IOException, InterruptedException {
		Scanner scanner = new Scanner(new File("config.json"));
		while(scanner.hasNext()) {
			String type = scanner.next();
			int value = scanner.nextInt();
			if (type.contains("data_size")) {
				DataSize = value;
			}
			if (type.contains("error_rate")) {
				if (value == -1) {
					RateError = 0;
				}
				else {
					RateError = 100 / value;
				}
			}
			if (type.contains("lost_rate")) {
				if (value == -1) {
					RateLost = 0;
				}
				else {
					RateLost = 100 / value;
				}
			}
			if (type.contains("SW_size")) {
				SizeSW = value;
			}
			if (type.contains("init_seq_no")) {
				InitSeqNo = value;
			}
			if (type.contains("time_out")) {
				Timeout = value;
			}
		}
		pdu_timer = new LinkedHashMap<Integer,Timer>();
		buffer = new LinkedHashMap<Integer,Message>();
		ack = new boolean[SizeSW+5];
		startTime = System.currentTimeMillis();

		System.out.println("Start");
		if(args.length == 1 ) {
			if(args[0].equals("1")) {
				GBNSendPort = 40717;
				GBNRecvPort = 40713;
				sendfile = "data/file1.txt";
				recvfile = "data/file1_recv.txt";
				File menu = new File("data/log1(40717)");
				if (!menu.exists()) {
					menu.mkdir();
				}
				sendlog = new File("data/log1(40717)/sendto_40713.txt");
				sendlog.delete();
				sendlog.createNewFile();
				recvlog = new File("data/log1(40717)/recvfrom_40713.txt");
				recvlog.delete();
				recvlog.createNewFile();
				
			}else if(args[0].equals("2")) {
				GBNSendPort = 40713;
				GBNRecvPort = 40717;
				sendfile = "data/file2.txt";
				recvfile = "data/file2_recv.txt";
				File menu = new File("data/log2(40713)");
				if (!menu.exists()) {
					menu.mkdir();
				}
				sendlog = new File("data/log2(40713)/sendto_40717.txt");
				sendlog.delete();
				sendlog.createNewFile();
				recvlog = new File("data/log2(40713)/recvfrom_40717.txt");
				recvlog.delete();
				recvlog.createNewFile();
			}
		}else {
			System.out.println("Wrong Parameter");
		}
		
		System.out.println(GBNSendPort);
		System.out.println(GBNRecvPort);
		
		Readfile();
		recv_thread = new Receiver(GBNRecvPort,IP);
		recv_thread.start();
		sender = new Sender(GBNSendPort,IP);
		startTime = System.currentTimeMillis();
		activeTime = System.currentTimeMillis();
		
		try {
			msg.put(new Message(Type.send_file));
        } catch (InterruptedException e) {
            //e.printStackTrace();
        }
		while(true) {
			wait_for_event();
			create_send_data();
			if((!is_recving && !is_sending)||
			   (System.currentTimeMillis()-activeTime > 4000)) {
				break;
			}
		}
		
		System.out.println("Finished");
		FileOutputStream out = new FileOutputStream(Main.recvlog,true); 
		out.write(("recv_time=" + (endTime - startTime) + "ms\n").getBytes());
		out.close();
		Writefile();
		return;
	}
	
	static void wait_for_event() {
		Message m = new Message(Type.send_file);
		try {
			m = msg.take();
		}catch (InterruptedException e) {
            //e.printStackTrace();
        }
		//System.out.println(m.type);
		try {
			time_lock.put(0);
		}catch (InterruptedException e) {
            //e.printStackTrace();
        }
		if(m.type == Type.recv_data) {
			PDU pdu = new PDU();
			pdu.myclone(m.pdu);
			activeTime = System.currentTimeMillis();
			
			String status = "OK";
			if(pdu.index != pdu_expected) {
				status = "NumErr";
			}
			try {
				FileOutputStream out = new FileOutputStream(recvlog,true); 
				out.write(("recv_num=" + cnt_pdu_write 
						+ ",recv_exp=" + Main.pdu_expected 
						+ ",status=" + status + '\n').getBytes());
				out.close();
			}catch (IOException e) {
				e.printStackTrace();
			}
			
			
			if(pdu.index == pdu_expected) {
				if(pdu.type == 0) {
					is_recving = true;
				}else if(pdu.type == 2) {
					endTime = System.currentTimeMillis();
					is_recving = false;
				}
				pdu_expected = inc(pdu_expected);
				if(pdu.data != null) {
					pdus_write[cnt_pdu_write] = new PDU();
					pdus_write[cnt_pdu_write++].myclone(pdu);
				}
				while(between(ack_expected, pdu.ack_index, next_pdu_send)) {
                    stop_timer(ack_expected);
                    ack[ack_expected] = true;
                    cnt_buffer = cnt_buffer - 1;
                    buffer.remove(ack_expected);
                    ack_expected = inc(ack_expected);
				}
				if(send_end_pdu != -1 && send_end_pdu == ack_expected) {
					is_sending = false;
				}
			}
		}else if(m.type == Type.send_data) {
			activeTime = System.currentTimeMillis();
			int pdu_to_send = m.index_buffer;
			//System.out.println(next_pdu_send);
			
			PDU pdu = new PDU();
			pdu.myclone((PDU)buffer.get(pdu_to_send));
			
			pdu.index = pdu_to_send;
			pdu.ack_index = (pdu_expected + SizeSW) % (SizeSW + 1);
			try {
				FileOutputStream out = new FileOutputStream(sendlog,true); 
				out.write(("send_num=" + pdu.index 
						+ ",send_ack=" + ack_expected 
						+ ",status=" + "NEW" + '\n').getBytes());
				out.close();
				sender.sendPDU(pdu, true);
			}catch (IOException e) {
				e.printStackTrace();
			}
			
		}else if(m.type == Type.time_out) {
			int pdu_index = ack_expected;
			//System.out.println(pdu_index);
			for(int i = 0;i<cnt_buffer;i++) {
				PDU pdu = new PDU();
				//(PDU)buffer.get(pdu_index);
				pdu.myclone((PDU)buffer.get(pdu_index));
				pdu.index = pdu_index;
				pdu.ack_index = (pdu_expected + SizeSW) % (SizeSW + 1);
				try {
					FileOutputStream out = new FileOutputStream(sendlog,true); 
					out.write(("send_num=" + pdu.index 
							+ ",send_ack=" + ack_expected 
							+ ",status=" + "TO" + '\n').getBytes());
					out.close();
					sender.sendPDU(pdu, true);
				}catch (IOException e) {
					e.printStackTrace();
				}
				pdu_index = inc(pdu_index);
			}
			next_pdu_send = pdu_index;
		}
		try {
			time_lock.take();
		}catch (InterruptedException e) {
            //e.printStackTrace();
        }
	}
	
	static void create_send_data() {
		if(cnt_buffer < SizeSW) {
			int buffer_index = next_pdu_send;
			Message m = new Message(Type.send_data,buffer_index);
			PDU pdu = new PDU();
			if(send_end_pdu == -1) {
				if(!is_send_start) {
					is_send_start = true;
					pdu.type = 0;
				}else {
					if(cur_pdu_read < cnt_pdu_read) {
						pdu.myclone(pdus_read[cur_pdu_read++]);
						pdu.type = 1;
					}else {
						send_end_pdu = buffer_index;
						pdu.type = 2;
					}
				}
			}else {
				pdu.type = 1;
			}
			buffer.put(buffer_index, pdu);
			//System.out.println(buffer_index);
			try {
				msg.put(m);
	        } catch (InterruptedException e) {
	            //e.printStackTrace();
	        }
			next_pdu_send = inc(next_pdu_send);
			
			cnt_buffer+=1;
		}
	}
	
	static void stop_timer(int pdu_num) {
		if(pdu_timer.containsKey(pdu_num) == false)
			return;
		((Timer)(pdu_timer.get(pdu_num))).cancel();
	}
	
	static void send_time_out(int pdu_num) {
		try {
			time_lock.put(0);
        } catch (InterruptedException e) {
            //e.printStackTrace();
        }
		
		if(!ack[pdu_num]) {
			try {
				msg.put(new Message(Type.time_out));
	        } catch (InterruptedException e) {
	            //e.printStackTrace();
	        }
		}
		
		try {
			time_lock.take();
        } catch (InterruptedException e) {
            //e.printStackTrace();
        }
	}
	
	static void start_timer(int pdu_num) {
		stop_timer(pdu_num);
		ack[pdu_num]=false;
		Timer t = new Timer();
		Task_send_timeout task = new Task_send_timeout(pdu_num);
		pdu_timer.put(pdu_num,t);
		((Timer)(pdu_timer.get(pdu_num))).schedule(task, Timeout);;
	}
}

class Task_send_timeout extends TimerTask{
	int pdu_num;
	Task_send_timeout(int n){
		pdu_num = n;
	}
    @Override
    public void run() {
        Main.send_time_out(pdu_num);
    }	
}
