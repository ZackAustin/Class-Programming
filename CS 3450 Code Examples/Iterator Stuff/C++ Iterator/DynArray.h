// DynArray.h: A vector with iterators
// Author: Chuck Allison (2001-2006)
// This version uses an array of T for simplicity. "Real containers"
// allocate raw memory and use placement new and explicit destructor
// calls for efficiency.

// TODO: Change const-Iterator to hold a pointer and add the equality check in relationals.

#ifndef DYNARRAY_H
#define DYNARRAY_H

#include <algorithm>
#include <cassert>
#include <cstddef>
#include <iterator>
#include <stdexcept>
using std::size_t;
using std::logic_error;

// Template class DynArray
template<typename T>
class DynArray {
public:
   // Nested type declarations
   class iterator;
   friend class iterator;
   typedef std::reverse_iterator<iterator> reverse_iterator;
   class const_iterator;
   friend class const_iterator;
   typedef std::reverse_iterator<const_iterator> const_reverse_iterator;

   explicit DynArray(size_t n = 0) {
      init(n);
   }
   template<typename OtherIter> DynArray(OtherIter beg, OtherIter end) {
      init(0);
      while (beg != end)
         push_back(*beg++);
   }
   ~DynArray() {
      delete [] data;
   }
   void push_front(const T& t) {
      // Make room and assign to 0th position
      shuffleRight(0);
      data[0] = t;
      ++count;
   }
   void insert(const iterator& it, const T& t) {
      // Make room and assign to nth position
      size_t pos = it - begin();
      shuffleRight(pos);
      data[pos] = t;
      ++count;
   }
   T& front() {
      if (count == 0)
         throw logic_error("Underflow in DynArray::front");
      return data[0];
   }
   const T& front() const {
      if (count == 0)
         throw logic_error("Underflow in DynArray::front");
      return data[0];
   }
   T& back() {
      if (count == 0)
         throw logic_error("Underflow in DynArray::back");
      return data[count-1];
   }
   const T& back() const {
      if (count == 0)
         throw logic_error("Underflow in DynArray::back");
      return data[count-1];
   }
   void pop_front() {
      if (count > 0) {
         shuffleLeft(0);
         --count;
      }
   }
/*   void pop_back() {
      if (count > 0)
         --count;
   }
   */
   void pop_back() {
       erase(end() - 1);
   }
   void erase(const iterator& it) {
      if (it >= begin() && it < end()) {
         shuffleLeft(it - begin());
         --count;
      }
   }
   void clear() {
      count = 0;
   }
/*   void push_back(const T& t) {
      checkCapacity();
      data[count++] = t;
   }
   */
   void push_back(const T& t) {
       insert(end(), t);
   }
   T& at(size_t pos) {
      if (pos >= count)
         throw logic_error("Index error in DynArray::at");
      return data[pos];
   }
   const T& at(size_t pos) const {
      if (pos >= count)
         throw logic_error("Index error in DynArray::at");
      return data[pos];
   }
   size_t size() const {
      return count;
   }

   // Iterator-related functions
   iterator begin() {
      return iterator(this);
   }
   iterator end() {
      return iterator(this, true);
   }
   reverse_iterator rbegin() {
      return reverse_iterator(end());
   }
   reverse_iterator rend() {
      return reverse_iterator(begin());
   }
   const_iterator begin() const {
      return const_iterator(*this);
   }
   const_iterator end() const {
      return const_iterator(*this, true);
   }
   const_reverse_iterator rbegin() const {
      return const_reverse_iterator(end());
   }
   const_reverse_iterator rend() const {
      return const_reverse_iterator(begin());
   }

   // Nested class iterator (Stores a pointer to the DynArray)
   class iterator : public std::iterator<std::random_access_iterator_tag, T> {
      friend class DynArray<T>;
   public:
      T& operator*() const {
         return array->data[pos];
      }
      iterator& operator++() {
         if (pos < array->count)
            ++pos;
         return *this;
      }
      iterator operator++(int) {
         iterator save(*this);
         operator++();
         return save;
      }
      iterator& operator--() {
         if (pos > 0)
            --pos;
         return *this;
      }
      iterator operator--(int) {
         iterator save(*this);
         operator--();
         return save;
      }
      bool operator==(const iterator& it2) const {
         return array == it2.array && pos == it2.pos;
      }
      bool operator!=(const iterator& it2) const {
         return !(*this == it2);
      }
      bool operator<(const iterator& it2) const {
         assert(array == it2.array);
         return pos < it2.pos;
      }
      bool operator<=(const iterator& it2) const {
         return !(it2 < *this);
      }
      bool operator>(const iterator& it2) const {
         return it2 < *this;
      }
      bool operator>=(const iterator& it2) const {
         return !(*this < it2);
      }
      iterator& operator+=(ptrdiff_t n) {
         if (n < 0)
            return operator-=(-n);
         if (n > 0) {
            // Check for overflow
            if (pos + n >= array->count)
               pos = array->count;
            else
               pos += n;
         }
         return *this;
      }
      iterator operator+(ptrdiff_t n) const {
         iterator temp(*this);
         return temp += n;
      }
      iterator& operator-=(ptrdiff_t n) {
         if (n < 0)
            return operator+=(-n);
         if (n > 0) {
            // Check for underflow
            if (size_t(n) >= pos)
               pos = 0;
            else
               pos -= n;
         }
         return *this;
      }
      iterator operator-(ptrdiff_t n) const {
         iterator temp(*this);
         return temp -= n;
      }
      ptrdiff_t operator-(const iterator& it2) const {
         assert(array == it2.array);
         return pos - it2.pos;
      }
      T* operator->() const {
         return &**this;
      }
/*      T& operator[](ptrdiff_t n) const {
         return array->data[pos+n];
      }
      */
      T& operator[](ptrdiff_t n) const {
         return *operator+(n);
      }
   private:
      DynArray<T>* array;
      size_t pos;

      iterator(DynArray<T>* a) {       // For begin()
         array = a;
         pos = 0;
      }
      iterator(DynArray<T>* a, bool) { // For end()
         array = a;
         pos = array->count;
      }
   };

   // Nested class const_iterator (stores a reference to the DynArray)
   class const_iterator : public std::iterator<std::random_access_iterator_tag, T, ptrdiff_t, const T*, const T&> {
      friend class DynArray<T>;
   public:
      const T& operator*() const {
         return array.data[pos];
      }
      const_iterator& operator++() {
         if (pos < array.count)
            ++pos;
         return *this;
      }
      const_iterator operator++(int) {
         const_iterator save(*this);
         operator++();
         return save;
      }
      const_iterator& operator--() {
         if (pos > 0)
            --pos;
         return *this;
      }
      const_iterator operator--(int) {
         const_iterator save(*this);
         operator--();
         return save;
      }
      bool operator==(const const_iterator& it2) const {
         return pos == it2.pos;
      }
      bool operator!=(const const_iterator& it2) const {
         return !operator==(it2);
      }
      bool operator<(const const_iterator& it2) const {
         return pos < it2.pos;
      }
      bool operator<=(const const_iterator& it2) const {
         return !(it2 < *this);
      }
      bool operator>(const const_iterator& it2) const {
         return it2 < *this;
      }
      bool operator>=(const const_iterator& it2) const {
         return !(*this < it2);
      }
      const_iterator& operator+=(ptrdiff_t n) {
         if (n < 0)
            return operator-=(-n);
         if (n > 0) {
            // Check for overflow
            if (pos + n >= array.count)
               pos = array.count;
            else
               pos += n;
         }
         return *this;
      }
      const_iterator operator+(ptrdiff_t n) const {
         const_iterator temp(*this);
         return temp += n;
      }
      const_iterator& operator-=(ptrdiff_t n) {
         if (n < 0)
            return operator+=(-n);
         if (n > 0) {
            // Check for underflow
            if (size_t(n) >= pos)
               pos = 0;
            else
               pos -= n;
         }
         return *this;
      }
      const_iterator operator-(ptrdiff_t n) const {
         const_iterator temp(*this);
         return temp -= n;
      }
      ptrdiff_t operator-(const const_iterator& it2) const {
          // TODO: check for array == it2.array
         return pos - it2.pos;
      }
      const T* operator->() const {
         return &**this;
      }
      const T& operator[](ptrdiff_t n) const {
         return array.data[pos+n];
      }
   private:
      const DynArray<T>& array;
      size_t pos;

      const_iterator(const DynArray<T>& a) : array(a) {
         pos = 0;
      }
      const_iterator(const DynArray<T>& a, bool) : array(a) {
         pos = array.count;
      }
   };

   // DynArray members
private:
   enum {EXTENT = 10};
   T* data;
   size_t count;
   size_t capacity;

   void init(size_t n) {
      count = capacity = n;
      data = new T[capacity];
   }
   void checkCapacity() {
      if (count == capacity)
         grow();
      assert(count < capacity);
   }
   void grow() {
      // Allocate new array
      size_t newCapacity = capacity + EXTENT;
      T* newData = new T[newCapacity];
      std::copy(data, data+capacity, newData);
      delete [] data;
      data = newData;
      capacity = newCapacity;
   }
   void shuffleRight(size_t pos) {
      assert(pos <= count);
      checkCapacity();  // Grow if necessary (invalidates iterators!)

      T* start = data+pos;
      T* end = start+count;
      std::copy_backward(start, end, end+1);
      // Note that this loop is a no-op for pos == count
      // (This approach simplifies this function's callers)
//      for (size_t i = count; i > pos; --i)
//         data[i] = data[i-1];
   }
   void shuffleLeft(size_t pos) {
      assert(pos < count);
      std::copy(data+pos+1,data+count,data);
//      for (size_t i = pos; i < count-1; ++i)
//         data[i] = data[i+1];
   }
};

#endif
