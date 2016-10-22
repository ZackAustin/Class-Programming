// Name:		Zack Austin
// Date:		10/15/13
// Class:		CS 3450
// Assignment:	HW4
// Purpose:		Learn to use Abstract Factory and Singleton.

#include <iostream>
using namespace std;

class AbstractWidget
{
public:
	virtual void draw() = 0;
};

class HighResWidget : public AbstractWidget
{
public:
	void draw(){ cout << "Drawing a Widget using a HighResDisplay Driver\n"; }
	static HighResWidget& instance()
	{
		static HighResWidget theInstance;
		return theInstance;
	}
};

class LowResWidget : public AbstractWidget
{
public:
	void draw(){ cout << "Drawing a Widget using a LowResDisplay Driver\n"; }
	static LowResWidget& instance()
	{
		static LowResWidget theInstance;
		return theInstance;
	}
};

class AbstractDocument
{
public:
	virtual void print() = 0;
};

class HighResDocument : public AbstractDocument
{
public:
	void print() { cout << "Printing a Document using a HighResPrintDriver\n"; }
	static HighResDocument& instance()
	{
		static HighResDocument theInstance;
		return theInstance;
	}
};

class LowResDocument : public AbstractDocument
{
public:
	static LowResDocument& instance()
	{
		static LowResDocument theInstance;
		return theInstance;
	}
	void print() { cout << "Printing a Document using a LowResPrintDriver\n"; }
};

class AbstractFactory
{
public:
	virtual AbstractDocument* print() = 0;
	virtual AbstractWidget* draw() = 0;
};

class HighResFactory : public AbstractFactory
{
public:
	AbstractDocument* print(){return new HighResDocument();}
	AbstractWidget* draw(){return new HighResWidget();}
};

class LowResFactory : public AbstractFactory
{
public:
	AbstractDocument* print(){return new LowResDocument();}
	AbstractWidget* draw(){return new LowResWidget();}
};

int main()
{
	bool supportsHighRes = true;
	if (supportsHighRes == true)
	{
		AbstractFactory* factory = new HighResFactory();
		AbstractWidget* w = factory->draw();
		AbstractDocument* d = factory->print();
		w->draw();
		d->print();
	}
	cout << endl;
	supportsHighRes = false;
	if (supportsHighRes == false)
	{
		AbstractFactory* factory = new LowResFactory();
		AbstractWidget* w = factory->draw();
		AbstractDocument* d = factory->print();
		w->draw();
		d->print();
	}
	return 0;
}