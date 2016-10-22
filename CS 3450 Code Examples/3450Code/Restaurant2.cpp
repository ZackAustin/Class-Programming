#include <iostream>
#include <cstdlib>
#include <ctime>
using namespace std;

class Cook {
public:
    virtual void makeBurger() = 0;
    virtual void makeFries() = 0;
    virtual void makeShortStack() = 0;
    virtual void makeScrambled() = 0;
    virtual void makeHashBrowns() = 0;
};

class GoodCook : public Cook {
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

class BadCook : public Cook {
public:
    void makeBurger() {
        cout << "Making a burnt burger\n";
    }
    void makeFries() {
        cout <<"Making soggy fries\n";
    }
    void makeShortStack() {
        cout <<"Making 2 gooey pancakes\n";
    }
    void makeScrambled() {
        cout <<"Scrambling rubber eggs\n";
    }
    void makeHashBrowns() {
        cout <<"Burning the hash brown potatoes\n";
    }
} badcook;


template<class Order>
void orderUp(Order& order) {
    order();
}



class BurgerAndFries {
    Cook* receiver;
public:
    BurgerAndFries(Cook* c) : receiver(c) {}
    void operator()(){
        receiver->makeBurger();
        receiver->makeFries();
    }
	void newcook(Cook* c) {
		receiver = c;
	}
};

class FarmersSpecial {
    Cook* receiver;
public:
    FarmersSpecial(Cook* c) : receiver(c) {}
    void operator()(){
        receiver->makeShortStack();
        receiver->makeScrambled();
        receiver->makeHashBrowns();
    }
	void newcook(Cook* c) {
		receiver = c;
	}
};

class Waitress {
public:
    static void serve() {
		BurgerAndFries baf(&cook);
		FarmersSpecial f(&cook);
		bool shift_changed = false;
        for (int i = 0; i < 14; ++i) {
	    if (i >= 7 && !shift_changed) {
		cout << "Shift Change!!!\n\n";
		baf.newcook(&badcook);
		f.newcook(&badcook);
		shift_changed = true;
	    }
            // Take order and serve
            switch (rand() % 2) {
            case 0:
                orderUp(baf);
                break;
            case 1:
			orderUp(f);
                break;
	    default:
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
