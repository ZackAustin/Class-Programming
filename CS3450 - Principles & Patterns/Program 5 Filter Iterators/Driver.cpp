//Driver.cpp

//Programmer Information

//Name:			Zack Austin
//Class:		CS 3450
//Date:			11/12/13
//Program:		Program 5 - Filter Iterators
//Purpose:		Use of External Iterators

#include "Iterator.h"
#include <iostream>

using namespace std;

int main()
{
	//Programmer information
	cout << "Name:			Zack Austin\n";
	cout << "Class:			CS 3450\n";
	cout << "Date:			11/12/13\n";
	cout << "Program:		Program 5 - Filter Iterators\n";
	cout << "Purpose:		Use of External Iterators\n\n\n";

	//driver
	const int size = 8;
	//make an iterator
	IterableSequence<string>* myIterableArray = new MyIterator<string>(size);

	myIterableArray->add("5");
	myIterableArray->add("#bob");
	myIterableArray->add("15");
	myIterableArray->add("#20");
	myIterableArray->add("fred");

	Iterator<string> *iter = myIterableArray->GetIterator();
	//filter it
	cout << "Basic Iterator:\n";
	for (string s = iter->first(); iter->isDone() == false; s = iter->next())
	{
		std::cout << s << std::endl;;
	}
	cout << endl << "Filtered Iterator: Contains a Digit.\n";

	myIterableArray = new FilterIterator<string>(myIterableArray, 1);

	Iterator<string>* filterIter = myIterableArray->GetIterator();

	for (string s = filterIter->first(); filterIter->isDone() == false; s = filterIter->next())
	{
		std::cout << s << std::endl;
	}

	cout << endl << "Filtered Iterator: Contains a Digit as well as a Hash Symbol.\n";

	myIterableArray = new FilterIterator<string>(myIterableArray, 2);

	Iterator<string>* filterIter2 = myIterableArray->GetIterator();

	for (string s = filterIter2->first(); filterIter2->isDone() == false; s = filterIter2->next())
	{
		std::cout << s << std::endl;
	}

	delete myIterableArray;
	return 0;
}

