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

int main() {
    Monostate m1;
    m1.setData(7);
    Monostate m2;
    cout << m2.getData() << endl;   // 7
}
