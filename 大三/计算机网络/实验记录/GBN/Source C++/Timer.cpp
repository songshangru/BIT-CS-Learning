#include<thread>
using namespace std;

class Timer {
private:
    bool clear = false;

public:
    template<typename Function>
    void setTimeout(Function function, int delay)
	{
        this->clear = false;
        thread([=]() {
            if(this->clear) return;
            this_thread::sleep_for(chrono::milliseconds(delay));
            if(this->clear) return;
            function();
        }).detach();
    }

    void stop()
	{
        clear = true;
    }
};

