#include <list>

#pragma once
class Pool
{
	int _elemCount;
	size_t _elemSize;
	size_t _blockSize;
	char* freehead = 0;
	char** pool = nullptr;
	//array or something for freelist.
	std::list<char*> freelist;
	int _blocks;
	Pool(const Pool&); //no copying!
	Pool& operator=(const Pool&); // no assignment!
public:
	Pool(size_t elemSize, size_t blockSize = 5);
	~Pool();
	void* allocate(); //Get a ptr inside a pre-allocated block for a new object
	void deallocate(void* freedmem); //Free an object's slot (push addr on 'free list')
};