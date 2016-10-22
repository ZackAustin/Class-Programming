// Inherited subobjects and upcasts
#include <iostream>
using namespace std;

class A
{
   int x;
};
class B
{
   int y;
};
class C : public A, public B
{
   int z;
};

int main()
{
   C* pc = new C;
   cout << pc << endl;
   B* pb = pc;
   cout << pb << endl;
   A* pa = pc;
   cout << pa << endl;
}

/* Output:
0x100150
0x100154
0x100150
*/

