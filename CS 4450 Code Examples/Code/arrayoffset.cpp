#include <cassert>
#include <iostream>
using namespace std;

int rowmajor(int n, int indexes[], int dims[]) {
    assert(n>0);
    if (n == 1)
        return indexes[0];
    else
        return indexes[n-1] + dims[n-1]*rowmajor(n-1,indexes,dims);
}

int colmajor(int n, int indexes[], int dims[]) {
    assert(n>0);
    if (n == 1)
        return indexes[0];
    else
        return indexes[0] + dims[0]*colmajor(n-1,indexes+1,dims+1);
}

int main() {
    int indexes[] = {0,1,2};
    int dims[] = {3,4,5};
    cout << rowmajor(3,indexes, dims) << endl;
    cout << colmajor(3,indexes, dims) << endl;
}
