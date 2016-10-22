#include <iostream>
#include <string>
#include <list>
#include "DynArray.h"
#include "test.h"
using namespace std;

int main()
{
   // Test Exceptions on Empty Array
   DynArray<int> empty;
   try {
      (void) empty.front();
      fail_("Allowed front() on empty array");
   }
   catch (exception&) {
      succeed_();
   }
   try {
      empty.pop_front();
      succeed_();
   }
   catch (exception&) {
      fail_("pop_front() shouldn't throw");
   }
   try {
      (void) empty.back();
      fail_("Allowed back() on empty array");
   }
   catch (exception&) {
      succeed_();
   }
   try {
      empty.pop_back();
      succeed_();
   }
   catch (exception&) {
      fail_("pop_back() shouldn't throw");
   }
   try {
      (void) empty.at(0);
      fail_("Allowed at() on empty array");
   }
   catch (exception&) {
      succeed_();
   }
   try {
      DynArray<int>::iterator it = empty.begin();
      empty.erase(it);
      succeed_();
   }
   catch (exception&) {
      fail_("erase() shouldn't");
   }
   test_(empty.size() == 0);
   empty.clear();
   test_(empty.size() == 0);

   // Test a non-const DynArray
   DynArray<int> d;
   test_(d.size() == 0);
   DynArray<int>::iterator it = d.begin();
   test_(it == d.end());

   d.insert(it, 10);
   test_(d.size() == 1);
   test_(d.front() == 10);
   test_(d.back() == 10);

   d.push_front(20);
   test_(d.size() == 2);
   test_(d.front() == 20);
   test_(d.back() == 10);

   d.push_back(30);
   test_(d.size() == 3);
   test_(d.front() == 20);
   test_(d.at(1) == 10);
   test_(d.back() == 30);

   it = d.end();
   d.insert(it, 40);
   test_(d.size() == 4);
   test_(d.back() == 40);
   test_(d.at(3) == 40);

   // Test iterator operations
   it = d.begin();
   test_(*it++ == 20);
   test_(*it++ == 10);
   test_(*it++ == 30);
   test_(*it++ == 40);
   DynArray<int>::reverse_iterator rit = d.rbegin();
   test_(*rit++ == 40);
   test_(*rit++ == 30);
   test_(*rit++ == 10);
   test_(*rit++ == 20);
   it = d.begin();
   *it++ = 99;
   test_(d.front() == 99);
   test_(it[-1] == 99);
   test_(it[0] == 10);
   test_(it[1] == 30);
   DynArray<int>::iterator it2 = d.begin();
   test_((it - it2) == 1);
   test_((it2 - it) == -1);
   test_((it2+1) == it);
   test_((it-1) == it2);
   test_(it2 < it);
   test_(it2 <= it);
   test_(it > it2);
   test_(it >= it2);
   test_(it2 != it);
   test_(++it2 == it);
   it[0] = 66;
   test_(d.at(1) == 66);
   it += 1;
   test_(*it == 30);
   it2 += 2;
   test_(*it2 == 40);
   it2 -= 1;
   test_(it == it2);

   // Test traversal and comparison to end()
   int stuff[] = {99,66,30,40};
   DynArray<int>::iterator p = d.begin();
   int* p2 = stuff;
   while (p != d.end())
       test_(*p++ == *p2++);
   
   DynArray<int>::reverse_iterator rp = d.rbegin();
   p2 = stuff+4;
   while (rp != d.rend())
       test_(*rp++ == *--p2);

   const DynArray<int> cd(d.begin(), d.end());
   DynArray<int>::const_iterator pc = cd.begin();
   p2 = stuff;
   while (pc != cd.end())
       test_(*pc++ == *p2++);
   
   DynArray<int>::const_reverse_iterator rpc = cd.rbegin();
   p2 = stuff+4;
   while (rpc != cd.rend())
       test_(*rpc++ == *--p2);

   // Test removals
   d.pop_front();
   test_(d.size() == 3);
   test_(d.front() == 66);
   d.pop_back();
   test_(d.size() == 2);
   test_(d.back() == 30);
   it = d.begin();
   d.erase(it);
   test_(d.size() == 1);
   test_(d.front() == 30);
   test_(d.back() == 30);
   d.push_front(66);
   it = d.begin() + 1;
   d.erase(it);
   test_(d.size() == 1);
   test_(d.front() == 66);
   test_(d.back() == 66);
   d.clear();
   test_(d.size() == 0);

   // Test a const DynArray
   int a[] = {3,4,5,6};
   list<int> alist(a, a+4);
   const DynArray<int> c(alist.begin(), alist.end());
   test_(c.size() == 4);
   test_(c.front() == 3);
   test_(c.back() == 6);
   test_(c.at(1) == 4);
   
   DynArray<int>::const_iterator cit = c.begin();
   test_(*cit++ == 3);
   test_(cit > c.begin());
   test_(cit >= c.begin());
   test_(c.begin() < cit);
   test_(c.begin() <= cit);
   test_(cit != c.begin());
   test_(*cit++ == 4);
   test_(*cit++ == 5);
   test_(*cit++ == 6);
   test_(cit == c.end());

   DynArray<int>::const_reverse_iterator crit = c.rbegin();
   test_(*crit++ == 6);
   test_(*crit++ == 5);
   test_(*crit++ == 4);
   test_(*crit++ == 3);
   test_(crit == c.rend());

   // Test an DynArray of objects
   string words[] = {"eat", "rocks"};
   const DynArray<string> sd(words, words+2);
   test_(sd.size() == 2);
   DynArray<string>::const_iterator sit = sd.begin();
   test_(sit->size() == 3);
   ++sit;
   test_(sit->size() == 5);
   test_(sit->find('o') == 1);
   test_(sit->find('p') == string::npos);
   
   do_report();
}

