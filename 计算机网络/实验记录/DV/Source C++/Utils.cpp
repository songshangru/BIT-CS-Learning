#include<vector>
#include<string>
#include<set>

using namespace std;

vector<string> split(const string& s, const set<char>& cs)
{
    vector<string> res;
    string x;
    for (auto c:s)
    {
        if (cs.count(c))
        {
            if (x.length())
            {
                res.push_back(x);
                x = "";
            }
        } else
        {
            x.push_back(c);
        }
    }
    if (!x.empty())
        res.push_back(x);
    return res;
}
