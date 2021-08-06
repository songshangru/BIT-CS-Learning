#include <Winsock.h>
#include <string>
#include <vector>
#include <map>

using namespace std;
#pragma comment(lib, "ws2_32.lib")

class Physical
{
private:
    const int BUFF_LEN = 1024 * 4;
    SOCKET sock_id;
    SOCKADDR_IN us;
    map<string, SOCKADDR_IN> neighbor;
    map<string, bool> alive;

    BOOL fBroadcast = TRUE;
    SOCKADDR_IN src;
    int src_addrlen;
public:
    Physical(int port)
    {
        WSADATA wsaData;
        if (WSAStartup(MAKEWORD(1, 1), &wsaData) != 0)
        {
            printf("[Error] Can't initiates windows socket!\n");
        }
        if ((sock_id = socket(AF_INET, SOCK_DGRAM, 0)) < 0)
        {
            printf("[Error] Socket build error\n");
        }
        setsockopt(sock_id, SOL_SOCKET, SO_BROADCAST, (CHAR *) &fBroadcast, sizeof(BOOL));

        us.sin_family = AF_INET;
        us.sin_addr.s_addr = htonl(INADDR_ANY);
        us.sin_port = htons(port);

        if ((bind(sock_id, (SOCKADDR FAR *) &us, sizeof(us))) < 0)
        {
            printf("[Error] Socket bind fail\n");
        }
    }

    void add_nei(const string& id, int port)
    {
        SOCKADDR_IN tmp;
        tmp.sin_family = AF_INET;
        tmp.sin_addr.s_addr = htonl(INADDR_BROADCAST);
        tmp.sin_port = htons(port);
        neighbor[id] = tmp;
        alive[id] = true;
    }

    void disconnect(const string& id)
    {
        alive[id] = false;
    }

    void connect(const string& id)
    {
        alive[id] = true;
    }

    void send_to_nei(const string& info)
    {
        if (neighbor.empty())
            return;
        for (auto & i : neighbor)
        {
            if (alive[i.first])
            {
                sendto(sock_id, info.data(), (int) info.length(), 0, (SOCKADDR *) &i.second, sizeof(SOCKADDR_IN));
                Sleep(100);
            }
        }
    }

    string recv()
    {
        int nSize;
        char buf[BUFF_LEN];
        src_addrlen = sizeof(SOCKADDR_IN);
        if ((nSize = recvfrom(sock_id, buf, BUFF_LEN, 0, (SOCKADDR FAR *) &src, &src_addrlen)) < 0)
        {
            printf("[Error] Can't receive information\n");
        }

        string s(buf, nSize);
        return s;
    }

    int get_sockid() const
    {
        return sock_id;
    }
};
