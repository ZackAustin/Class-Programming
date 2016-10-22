#include "Pool.h"
#include <iostream>
#include <iomanip>

using namespace std;

Pool::Pool(size_t elemSize, size_t blockSize) : _elemSize(elemSize), _blockSize(blockSize)
{
	_blocks = 0, _elemCount = 0;
	cout << "Initializing a pool with element size " << _elemSize << " and block size " << _blockSize << endl;
	pool = new char*[99]; //hardcoded since I couldn't figure out how to add row.
}

Pool::~Pool()
{
	cout << "Deleting " << _blocks << " blocks" << endl;
	for (int i = 0; i < _blocks; i++)
		delete[] pool[i];
}

void* Pool::allocate()
{
	if (freelist.size() > 0) { freehead = freelist.front(); }
	else { freehead = nullptr; }

	if (freehead == nullptr)
	{
		//add a row, link together
		cout << "Expanding pool...\n";
		//char** newPool = new char*[_blocks];
		//for (int i = 0; i <= _blocks; i++)
		//{
		//	newPool[i] = new char[_elemSize * (_blockSize)];
		//}
		//newPool[_blocks] = new char[_elemSize * _blockSize];
		pool[_blocks] = new char[_elemSize * _blockSize];
		//memcpy(newPool, pool, _blocks * _elemSize * _blockSize);
		// Delete old array
		//delete [] pool;
		//pool = newPool;
		
		//initialize block as logically linked list.
		freehead = pool[_blocks];
		char *p = pool[_blocks++];
		cout << "Linking cells starting at 0x" << hex << reinterpret_cast<char**>(p) << endl;
		for (int i = 0; i < 4; i++)
		{
			*reinterpret_cast<char**>(p) = p + _elemSize;
			freelist.push_back(p);
			p += _elemSize;
		}
		//5th element
		*reinterpret_cast<char**>(p) = nullptr;
		freelist.push_back(p);
	}
	cout << "Cell allocated at 0x" << hex << reinterpret_cast<char**>(freehead) << dec << endl;
	freelist.pop_front();
	return freehead;
}

void Pool::deallocate(void* freedmem)
{
	char* pmem = reinterpret_cast<char*>(freedmem);
	freelist.push_front(pmem);
	cout << "Cell deallocated at 0x" << hex << reinterpret_cast<char**>(pmem) << endl;
}