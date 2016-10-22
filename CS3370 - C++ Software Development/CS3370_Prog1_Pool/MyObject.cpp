#include "MyObject.h"
#include "Pool.h"
#include <iostream>

using namespace std;

Pool MyObject::pool = sizeof(MyObject);

MyObject::MyObject(int i, const std::string& nm)
{ 
	id = i;
	name = nm;
}

void* MyObject::operator new(size_t siz)
{
	return pool.allocate();
}

void MyObject::operator delete(void* p) noexcept
{
	pool.deallocate(p);
}

ostream& operator<<(std::ostream& os, const MyObject& obj)
{
	os << "{" << obj.id << "," << obj.name << "}" << endl;
	return os;
}