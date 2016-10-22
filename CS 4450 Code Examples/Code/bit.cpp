// bit.cpp: Overlay an integer with a bit field structure

// 9/17/08:
//		day = 17 = 16 + 1 = 10001
//		mon = 9 = 8 + 1 = 1001
//		year = 8 = 0001000
//
// =>	1000 1100 1000 1000 = 1000 1100 1000 1000 = 0x8C88

// On a little-endian machine, bit fields are stored backwards, field-by-field:
//		year|mon|day = 0001000 1001 10001 = 00010001 00110001 = 0x1131
// but these are stored in reverse byte order as well giving:
//		00110001 00010001 = 0x3111

// When bytes are examined bit-by-bit on a LE machine, the bits are even *reported* backwards,
// which is why we end up with 1000 1100 1000 1000, which mirrors the original conceptual BE layout! 

#include <iostream>
using namespace std;

union DateOverlay {
   struct
   {
       unsigned day: 5;
       unsigned mon: 4;
       unsigned year: 7;
   };
   unsigned short int v;
};

int main()
{
	// Store 9/17/08
    DateOverlay dov;
    dov.day = 17;
	dov.mon = 9;
	dov.year = 8;
	
	// Examine storage
    cout << hex << dov.v << endl;
	
	// Examine byte-wise
    unsigned char* p = reinterpret_cast<unsigned char*>(&dov);
    for (int i = 0; i < 2; ++i) {
        cout << hex << static_cast<unsigned int>(p[i]) << ' ';
    }
    cout << endl;
	
	// Examine bit-wise
	struct bit16 {
		unsigned bit15 : 1;
		unsigned bit14 : 1;
		unsigned bit13 : 1;
		unsigned bit12 : 1;
		unsigned bit11 : 1;
		unsigned bit10 : 1;
		unsigned bit9 : 1;
		unsigned bit8 : 1;
		unsigned bit7 : 1;
		unsigned bit6 : 1;
		unsigned bit5 : 1;
		unsigned bit4 : 1;
		unsigned bit3 : 1;
		unsigned bit2 : 1;
		unsigned bit1 : 1;
		unsigned bit0 : 1;
	};
	
	bit16* p16 = reinterpret_cast<bit16*>(&dov);
	cout << p16->bit15 << p16->bit14 << p16->bit13 << p16->bit12 << p16->bit11 << p16->bit10 << p16->bit9
	     << p16->bit8 << p16->bit7 << p16->bit6 << p16->bit5 << p16->bit4 << p16->bit3 << p16->bit2
		  << p16->bit1 << p16->bit0 << endl; 
}

/* Output:
1131
31 11 
1000110010001000
*/
