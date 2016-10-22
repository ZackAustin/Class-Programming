//Iterator.h

#ifndef ITERATOR_H
#define	ITERATOR_H

#include <array>
#include <string>
#include <vector>

template<class T>
class Iterator
{
public:
	virtual T first() = 0;
	virtual T next() = 0;
	virtual T current() = 0;
	virtual bool isDone() = 0;
};

template<class T>
class Iterable
{
public:
	virtual Iterator<T>* GetIterator() = 0;
	virtual T& operator[](int itemIndex) = 0;
	virtual int Count() = 0;
};

template<class T>
class Sequence
{
public:
	virtual void add(const T&) = 0;
	virtual int size() const = 0;
	virtual int capacity() const = 0;
	virtual T get(unsigned int) const = 0;
	virtual ~Sequence(){}
};

template<class T>
class IterableSequence : public Iterator<T>, public Iterable<T>, public Sequence<T>
{
};

template<class T>
class MyIterator : public IterableSequence<T>
{
protected:
	int currentItem;
	T *myArray;
	int arraySize;
	int arrayCapacity;
public:
	MyIterator(Iterable *it) : currentItem(0), anIterator(it){}
	MyIterator(int size)
	{
		myArray = new T [size];
		arrayCapacity = size;
		arraySize = 1;
	}
	MyIterator(){}

	~MyIterator(){ delete [] myArray; }

	//Sequence stuff
	void add(const T& val)
	{
		if (currentItem < arrayCapacity)
		{
			myArray[currentItem] = val;
			currentItem++;
			arraySize++;
		}
	}

	int size() const
	{
		return arraySize;
	}

	int capacity() const
	{
		return arrayCapacity;
	}

	T get(unsigned int j) const
	{
		return myArray[j];
	}

	//Iterable stuff
	Iterator* GetIterator()
	{
		return this;
	}

	T& operator[](int itemIndex)
	{
		return myArray[itemIndex];
	}

	int Count()
	{
		return arraySize;
	}

	//Iterator stuff
	T first()
	{
		currentItem = 0;
		return myArray[currentItem];
	}

	T next()
	{
		currentItem += 1;

		if (isDone() == false)
		{
			return myArray[currentItem];
		}
		else
		{
			T t;	//return default for that type.
			return t;
		}
	}

	T current()
	{
		return myArray[currentItem];
	}

	bool isDone()
	{
		if (currentItem < Count() - 1)
			return false;
		return true;
	}

	int getCurrentCntr()
	{
		return currentItem;
	}
};

template<class T>
class FilterIterator : public MyIterator<T>
{
	IterableSequence* iter;
	int predicateType;
public:
	FilterIterator(IterableSequence* i, int predType) : iter(i), predicateType(predType) {}
	~FilterIterator(){ }

	T first()
	{
		iter->GetIterator();
		T item = iter->first();
		bool predicate = false;
		if (predicateType == 1)
			predicate = containsDigit(item);
		if (predicateType == 2)
			predicate = containsHashSign(item);
		if (predicate)
			return item;
		else
		{
			T t;
			return t;
		}		
	}

	T next()
	{
		iter->GetIterator();
		T item = iter->next();
		bool predicate = false;
		bool didIt = iter->isDone();
		if (didIt == false)
		{
			if (predicateType == 1)
				predicate = containsDigit(item);
			if (predicateType == 2)
				predicate = containsHashSign(item);
			if (predicate)
				return item;
		}
			T t;	//return default for that type.
			return t;
	}

	bool isDone()
	{
		iter->GetIterator();
		bool item = iter->isDone();
		if (item == false)
			return false;
		return true;
	}

	bool containsDigit(const T& t)
	{
		return (t.find_first_of("0123456789") != std::string::npos);
	}

	bool containsHashSign(const T& t)
	{
		return (t.find_first_of("#") != std::string::npos);
	}
};

#endif