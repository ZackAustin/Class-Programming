#include <iostream>
using namespace std;

class Monostate {
    static int theData;
public:
    void setData(int x) {
        theData = x;
    }
    int getData() const {
        return theData;
    }
};
int Monostate::theData = 0;

class M1 : public Monostate
{
};

class M2 : public Monostate
{
};

int main() {
    Monostate m1;
    m1.setData(7);
    Monostate m2;
    cout << m2.getData() << endl;   // 7
	M1 mm1;
	cout << mm1.getData() << endl;
	M2 mm2;
	cout << mm2.getData() << endl;
	mm2.setData(19);
	cout << m1.getData() << endl;
}
