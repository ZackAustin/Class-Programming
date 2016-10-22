//ShapeAdapter.h

#ifndef SHAPEADAPTER_H
#define SHAPEADAPTER_H
#include <iostream>
using namespace std;

//Shape Hierarchy
class Shape
{
public:
	void setLocation(){cout << "Location is set.\n";}
	void getLocation(){cout << "Got shapes location.\n";}
	virtual void display() = 0;
	virtual void fill() = 0;
	void setColor(){cout << "Color is set.\n";}
	virtual void undisplay() = 0;
};

//concrete shapes
class Point : public Shape
{
public:
	void display() { cout << "Displaying Shape: Point\n"; }
	void fill() { cout << "Filling Shape: Point\n"; }
	void undisplay() { cout << "Undisplaying Shape: Point\n"; }
};
//concrete shapes
class Line : public Shape
{
public:
	void display() { cout << "Displaying Shape: Line\n"; }
	void fill() { cout << "Filling Shape: Line\n"; }
	void undisplay() { cout << "Undisplaying Shape: Line\n"; }
};
//concrete shapes
class Rectangle : public Shape
{
public:
	void display() { cout << "Displaying Shape: Rectangle\n"; }
	void fill() { cout << "Filling Shape: Rectangle\n"; }
	void undisplay() { cout << "Undisplaying Shape: Rectangle\n"; }
};

//Circle class we want to reuse.
class XXCircle
{
public:
	//Can just call set & get Shape within CircleAdapter.
	void setLocation() { cout << "Location is set.\n"; }
	void getLocation() { cout << "Got shapes location.\n"; }
	void displayIt() { cout << "Displaying Shape: XXCircle\n"; }
	void fillIt() { cout << "Filling Shape: XXCircle\n"; }
	void setItsColor() { cout << "Coloring Shape: XXCircle\n"; }
	void undisplayIt() { cout << "Undisplaying Shape: XXCircle\n"; }
};

//Adapter, wraps

class CircleAdapter : public Shape, private XXCircle
{
	XXCircle wrappedCircle;
public:
	CircleAdapter(XXCircle item)
	{
		wrappedCircle = item;
	}
	void display() { wrappedCircle.displayIt(); }
	void fill() { wrappedCircle.fillIt(); }
	void undisplay() { wrappedCircle.undisplayIt(); }
};

#endif