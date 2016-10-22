#include <iostream>
#include <string>
#include "DynArray.h"
using namespace std;

int main()
{
  DynArray<int> a;
  a.push_back(10);
  a.push_back(20);
  a.push_back(30);
  cout << "a:\n";
  DynArray<int>::iterator p = a.begin();
  while (p != a.end())
    cout << *p++ << endl;
  cout << "a backwards:\n";
  DynArray<int>::reverse_iterator q = a.rbegin();
  while (q != a.rend())
    cout << *q++ << endl;
  DynArray<int>::iterator r = a.begin();
  cout << *(r + 1) << endl;
  r += 2;
  cout << *r << endl;
  r -= 1;
  cout << *r << endl;
  cout << "difference " << p - r << endl;

  int nums[] = {7,8,9,10,11};
  DynArray<int> a2(nums, nums+5);
  cout << "a2.size() == " << a2.size() << endl;
  cout << "a2:\n";
  DynArray<int>::iterator p2 = a2.begin();
  while (p2 != a2.end())
    cout << *p2++ << endl;
  DynArray<int>::iterator p2a = a2.begin();
  cout << "difference " << p2 - p2a << endl;
  cout << "a2 backwards:\n";
  DynArray<int>::reverse_iterator q2 = a2.rbegin();
  while (q2 != a2.rend())
    cout << *q2++ << endl;

  DynArray<string> a3;
  a3.push_back("now");
  a3.push_back("is");
  a3.push_back("the");
  a3.push_back("time");
  DynArray<string>::iterator p3 = a3.begin();
  cout << p3->find('o') << endl;
  cout << "a3:\n";
  cout << p3[0] << endl;
  cout << p3[1] << endl;
  cout << p3[2] << endl;
  ++p3;
  cout << p3[-1] << endl;
}

/* Output:
a:
10
20
30
a backwards:
30
20
10
20
30
20
difference 2
a2.size() == 5
a2:
7
8
9
10
11
difference 5
a2 backwards:
11
10
9
8
7
1
a3:
now
is
the
now
*/
