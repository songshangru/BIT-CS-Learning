package network_lab1_GBN;


public class PDU {
	//帧长度 5 + 1024 + 2 byte
	
	//类型，1byte
	//	文件开始     0
	//	普通帧	  1 
	//	文件结束     2
	//	（ACK帧）   3
	public int type;
	//帧号，1byte
	public int index;
	//确认帧号，1byte
	public int ack_index;
	//数据段长度，2byte
	public int len;
	//数据段，最大1024byte
	public byte[] data;
	//CRC，2byte
	public int CRC;
	
	//初始化函数
	public PDU() {
		type = 0;
		index = 0;
		ack_index = 0;
		len = 0;
		data = new byte[Main.DataSize];
		CRC = 0;
	}
	
	public void myclone(PDU pdu) {
		this.type = pdu.type;
		this.index = pdu.index;
		this.ack_index = pdu.ack_index;
		this.len = pdu.len;
		this.CRC = pdu.CRC;
		if(pdu.data != null)
			System.arraycopy(pdu.data, 0, this.data, 0, this.len);
		else
			this.data = null;
	}
	
	//将帧转换为二进制字串
	public byte[] todatabyte() {
		byte[] datapac = new byte[len + 7];
		datapac[0] = (byte)(type & 0xff);
		datapac[1] = (byte)(index & 0xff);
		datapac[2] = (byte)(ack_index & 0xff);
		datapac[3] = (byte)((len >> 8) & 0xff);
		datapac[4] = (byte)(len & 0xff);
		for (int i = 0; i < len; i++) {
			datapac[i + 5] = data[i];
		}
		datapac[len + 5] = (byte)((CRC >> 8) & 0xff);
		datapac[len + 6] = (byte)(CRC & 0xff);
		return datapac;
	}
	//将二进制字串转换为该PDU
	public void bytetoPDU(byte[] datapac) {
		type = datapac[0] & 0xff;
		index = datapac[1] & 0xff;
		ack_index = datapac[2] & 0xff;
		len = ((datapac[3] & 0xff) << 8) | (datapac[4] & 0xff);
		for (int i = 0; i < len; i++) {
			data[i] = datapac[i + 5];
		}
		CRC = ((datapac[len + 5] & 0xff) << 8) | (datapac[len + 6] & 0xff);
	}
	//产生crc
	public void crc_gen() {
		CRC = 0;
		byte[] tmpdata = todatabyte();
		int polynomial = 0x11021;
		for (int i = 0; i < tmpdata.length; i++) {
			for (int j = 7; j >= 0; j--) {
				CRC = (CRC << 1) | ((tmpdata[i] >> j) & 1);
				if ((CRC & 0x10000) != 0) {
					CRC ^= polynomial;
				}
			}
		}
	}
	//校验crc
	public boolean crc_verify() {
		byte[] tmpdata = todatabyte();
		int polynomial = 0x11021;
		int tmpCRC = 0;
		for (int i = 0; i < tmpdata.length; i++) {
			for (int j = 7; j >= 0; j--) {
				tmpCRC = (tmpCRC << 1) | ((tmpdata[i] >> j) & 1);
				if ((tmpCRC & 0x10000) != 0) {
					tmpCRC ^= polynomial;
				}
			}
		}
		return tmpCRC == 0;
	}


}
