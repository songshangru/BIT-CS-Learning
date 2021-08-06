#include<bitset>
using namespace std;

struct Head{
    uint16_t len=0;
    uint8_t type = -1;
    uint8_t seq = -1;
    uint8_t ack = -1;
};

class Frame{
public:
    Head h;
    string info="";//数据内容
	//添加CRC后缀 
	Frame& operator=(const Frame& f){
		this->h = f.h;
		this->info = f.info;
		return *this;
	} 
    void gen()
	{
        auto crc = crc_gen(info.data(), info.length());
        info.resize(info.length() + 2);
        *(uint16_t*)(info.data() + info.length() - 2) = crc;
    }
	//验证CRC是否正确，并去掉crc 
    bool verify()
	{
        uint16_t reminder = *(uint16_t*)(info.data() + info.length() - 2);
        info = info.substr(0, info.length() - 2);
        bool res = crc_verify(info.data(), info.length(), reminder);
        return res;
    }

private:
	const uint16_t poly = 0x1021;//defined by CRC-CCITT
	const uint16_t init = 0xffff;

	uint16_t crc_gen(const char *info, int len)
	{
	    uint16_t hold = init;
	    uint16_t divider = poly;
	    for(int i = 0; i < len + 2; i++)
		{
	        for(int j = 7; j >= 0; j--)
			{
	            bool last = hold & (1 << 15);
	            //数据前移
	            hold <<= 1;
	            if(i < len) hold |= (info[i] & (1 << j) ? 1 : 0);//
	            //1则异或poly
				if(last) hold ^= divider;
	        }
	    }
	    return hold;
	}

	bool crc_verify(const char *info, int len, uint16_t reminder)
	{
	    uint16_t hold = init;
	    uint16_t divider = poly;
	    for(int i = 0; i < len + 2; i++)
		{
	        for(int j = 7; j >= 0; j--)
			{
	            bool last = hold & (1 << 15);
	            hold <<= 1;
	            if(i < len) hold |= (info[i] & (1 << j) ? 1 : 0);
	            else
				{
	                hold |= (reminder & (1 << ((len - i + 1) * 8 + j))) ? 1 : 0;//结尾加上余数 
	            }
	            if(last) hold ^= divider;
	        }
	    }
	    return hold==0;
	}
};

