#include <iostream>
using namespace std;

int main() {
   union MyUnion {
      unsigned int n;
      unsigned char bytes[4];
   };

   MyUnion u;
   u.n = 0x61626364;
   for (int i = 0; i < 4; ++i)
      cout << i << ":" << u.bytes[i] << ' ';
}

/* Output (little endian architecture):
0:d 1:c 2:b 3:a
*/
