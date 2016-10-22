#include <iostream>
#include <string>
using namespace std;

class Top
{
   string text;

public:
   Top(const string& s) : text(s){cout << s << endl;}
};

class Left : public virtual Top
{
public:

   Left() : Top(" from Left") {}
};

class Right : public virtual Top
{
public:
   Right() : Top(" from Right") {}
};

class Bottom : public Left, public Right
{
public:
   Bottom() : Top(" from Bottom") {}
};

int main()
{
   Top t(" from main");
   Left l;
   Right r;
   Bottom b;
}

/* Output:
 from main
 from Left
 from Right
 from Bottom
*/
