#include <cassert>

inline
bool primeHelper(int n, int nextDiv) {
   return (n == nextDiv) ? true : (n%nextDiv == 0) ? false : primeHelper(n, nextDiv+1);
}

inline
bool isPrime(int n) {
   return n == 2 ? true : primeHelper(n,2);
}

int main() {
   assert(isPrime(2));
   assert(isPrime(3));
   assert(!isPrime(4));
}

