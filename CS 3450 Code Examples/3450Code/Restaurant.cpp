#include <iostream>
#include <cstdlib>
#include <ctime>
using namespace std;

class Cook {
public:
    void makeBurger() {
        cout << "Making a burger\n";
    }
    void makeFries() {
        cout <<"Making fries\n";
    }
    void makeShortStack() {
        cout <<"Making 2 pancakes\n";
    }
    void makeScrambled() {
        cout <<"Scrambling eggs\n";
    }
    void makeHashBrowns() {
        cout <<"Making hash brown potatoes\n";
    }
} cook;


template<class Order>
void orderUp(Order& order) {
    order();
}


class BurgerAndFries {
    Cook& receiver;
public:
    BurgerAndFries(Cook& c) : receiver(c) {}
    void operator()(){
        receiver.makeBurger();
        receiver.makeFries();
    }
};

class FarmersSpecial {
    Cook& receiver;
public:
    FarmersSpecial(Cook& c) : receiver(c) {}
    void operator()(){
        receiver.makeShortStack();
        receiver.makeScrambled();
        receiver.makeHashBrowns();
    }
};

class Waitress {
public:
    static void serve() {
		BurgerAndFries baf(cook);
		FarmersSpecial f(cook);
        for (int i = 0; i < 5; ++i) {
            // Take order and serve
            switch (rand() % 2) {
            case 0:
                orderUp(baf);
                break;
            case 1:
				orderUp(f);
                break;
            }
            cout << endl;
        }
    }
};

int main() {
    srand(time(0));
    Waitress::serve();
}

