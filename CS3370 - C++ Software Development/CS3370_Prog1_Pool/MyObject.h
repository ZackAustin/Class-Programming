#include <string>
#include "Pool.h"

#pragma once
class MyObject
{
	static Pool pool;
	int id;
	std::string name;
	MyObject(int i, const std::string& nm);
	MyObject(const MyObject&); //no copying!
	MyObject& operator=(const MyObject&); // no assignment!
public:
	static MyObject* create(int id, const std::string& name) { return new MyObject(id, name); }
	static void* operator new(size_t siz);
	static void operator delete(void* p) noexcept;
	friend std::ostream& operator<<(std::ostream& os, const MyObject& obj);
};
