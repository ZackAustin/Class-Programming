#include <iostream>
#include "Widget.h"

using namespace std;

void widfun (WidgetPtr);

int main()
{
	WidgetPtr w1 = new Widget("Number One");
	
	cout << "w1: " << w1->get_name() << endl;
	WidgetPtr w2 (w1);
	cout << "w2: " << w2->get_name() << endl;
	w1 = new Widget ("Number Two");
	
	widfun (w1);
	widfun (w2);
	
	cout << "w1: " << w1->get_name() << endl;
	cout << "w2: " << w2->get_name() << endl;

}

void widfun (WidgetPtr w)
{
	cout << "Widget function: " << w->get_name() << endl;
}

