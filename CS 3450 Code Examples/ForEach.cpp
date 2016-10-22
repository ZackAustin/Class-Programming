#include <iostream>
#include <string>
#include <vector>

using namespace std;

template<class Iter, class F>
void forEach(Iter start, Iter stop, F f) {
    while (start != stop)
        f(*start++);
}

template<class T>
void f(const T& t) {
    cout << t << endl;
}

int main() {
    string a[] = {"one", "two", "three"};
    forEach(a, a+3, &f<string>);
	int b[] = {1 , 2, 3,4,5,6,7 };
	forEach (b+1, b+5, &f<int>);
	
	vector<double> v;
	v.push_back(46);
	v.push_back(17.998);
	v.push_back(196.006);
	
	forEach (v.begin(), v.end(), &f<double>);
}
