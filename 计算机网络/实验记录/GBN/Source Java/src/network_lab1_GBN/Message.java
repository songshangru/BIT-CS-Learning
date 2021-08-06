package network_lab1_GBN;

enum Type{
	recv_data,
	send_data,
	time_out,
	send_file
}

public class Message {
	Type type;
	PDU pdu;
	int index_buffer;
	
	Message(Type t){
		type = t;
		pdu = new PDU();
		index_buffer = -1;
	}
	
	Message(Type t, PDU p){
		type = t;
		pdu = new PDU();
		pdu.myclone(p);
		index_buffer = -1;
	}
	
	Message(Type t, int i){
		type = t;
		pdu = new PDU();
		index_buffer = i;
	}
	
}
