#include"Simulator.cpp"

int main(int argc, char *argv[])
{
    string id, port, init_file;
    if (argc != 4)
    {
        cout << "Expect 4 params but get " << argc << endl;
        cout << "Please input id, port, init_file :" << endl;
        cin >> id >> port >> init_file;
        // return 0;
    } else {
        id = argv[1];
        port = argv[2];
        init_file = argv[3];
    }
    Simulator dev(id, atoi(port.data()), init_file);
    // 路由运行线程
    thread([&dev] { dev.run(); }).detach();
    // 接受指令线程
    thread([&dev] {
        string s;
        //接收指令线程
        while (cin >> s)
        {
            if (s == "p")
            {
                dev.fault();
            }
            else if (s == "s")
            {
                dev.restart();
            }
            else if (s == "k")
            {
                dev.stop();
                break;
            }
            else if (s == "a")
            {
                dev.debug();
            }
            else
            {
                cout << "Don't support the command" << endl;
            }
        }
    }).join();

    return 0;
}

/*

a 52005 ../config/a.txt
b 52001 ../config/b.txt
c 52003 ../config/c.txt

x 52004 ../config/x.txt
y 52005 ../config/y.txt
z 52006 ../config/z.txt

 * */