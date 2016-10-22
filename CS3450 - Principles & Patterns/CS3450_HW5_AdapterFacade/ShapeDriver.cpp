//ShapeDriver.cpp
// Name:		Zack Austin
// Date:		11/4/13
// Class:		CS 3450
// Assignment:	Homework 5 - Shape Adapter
// Purpose:		Learn how to implement an Adapter for shape with differing implementation.

#include <string>
#include "ShapeAdapter.h"
#include <vector>

void displayShapes(vector<Shape*> &shapes);

int main()
{
	cout << "Name:		Zack Austin\n";
	cout << "Date:		11/4/13\n";
	cout << "Class:		CS 3450\n";
	cout << "Assignment:	Homework 5 - Shape Adapter\n";
	cout << "Purpose:	Learn Adapter Pattern using Shape Hierarchy & XXCircle.\n\n";

	//sequence of shape objects
	vector<Shape*> shapeSequence;
	Point pointShape;
	Line lineShape;
	Rectangle rectangleShape;
	shapeSequence.push_back(&pointShape);
	shapeSequence.push_back(&lineShape);
	shapeSequence.push_back(&rectangleShape);

	//XX Circle adapter object.
	XXCircle xxCircle;
	CircleAdapter circleShape(xxCircle);
	shapeSequence.push_back(&circleShape);

	//display shapes
	displayShapes(shapeSequence);

	return 0;
}

void displayShapes(vector<Shape*> &shapes)
{
	//display all shapes contained, verify circle coexists nicely in Shape.
	for (int i = 0; i < shapes.size(); i++)
	{
		shapes[i]->display();
		shapes[i]->setColor();
		shapes[i]->undisplay();
		cout << endl;
	}
}