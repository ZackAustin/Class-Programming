#include "smartptr.h"
#include "smartptr.cpp"

using std::string;

class Widget : public RefCnt<Widget>
{
	string name;
public:
	Widget (const string& s) : name (s) {}
	string get_name() { return name; }
};

class WidgetPtr : public SmartPtr<Widget>
{
public:
	WidgetPtr (Widget* tgen) : SmartPtr<Widget> (tgen) {}
	WidgetPtr () {}
	WidgetPtr (const WidgetPtr& wgt) : SmartPtr<Widget> (wgt) {}
};
