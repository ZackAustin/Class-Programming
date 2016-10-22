#ifndef BITARRAY_H
#define BITARRAY_H

#include <iostream>
#include <vector>
#include <stdexcept>

template<class IType = unsigned int>
class BitArray
{
	size_t _size;
	bool val;
	enum { BITS_PER_WORD = CHAR_BIT * sizeof(IType) };
	std::vector<IType> bitstorage;
	class bitproxy
	{
		BitArray* _ba;
		size_t position;
	public:
		bitproxy(BitArray<IType>* ba, size_t pos) : _ba(ba), position(pos) {}
		void operator=(bool item)
		{
			int block = position / _ba->BITS_PER_WORD; // 1 = 50/32
			if (item != 0)
			{
				IType mask = 1u << position;
				IType value = _ba->bitstorage[position / _ba->BITS_PER_WORD] & mask;
				_ba->bitstorage[position / _ba->BITS_PER_WORD] |= mask;
				value = _ba->bitstorage[block] & mask;
				if ((value) != 0)
					_ba->val = true;
				else _ba->val = false;
			}
			else if (item == 0)
			{
				IType mask = (~(1u << position));
				_ba->bitstorage[block] &= mask;
				IType value = _ba->bitstorage[block] & mask;
				if ((value) != 0)
					_ba->val = true;
				else _ba->val = false;
			}
			else throw logic_error("");
		}

		void operator=(bitproxy ba)
		{
			if ((ba._ba->bitstorage[ba.position / BITS_PER_WORD] & (1u << ba.position)) != 0)//it's a 1, place in this position.
			{
				_ba->bitstorage[position / BITS_PER_WORD] |= (1u << position);
				_ba->val = true;
			}
			else//place 0 at position.
			{
				_ba->bitstorage[position / BITS_PER_WORD] &= (~(1u << position));
				_ba->val = false;
			}
		}
		operator bool() const{return _ba->val;}
	};
public:
	// Object Management
	explicit BitArray(size_t g = 0)
	{
		_size = g;
		if (_size > 0)
		{
			while (bitstorage.size() <= (_size / BITS_PER_WORD))
				bitstorage.push_back(0);
		}
	}

	explicit BitArray(const std::string& bits)
	{
		_size = bits.size();
		if (_size > 0)
		{
			while (bitstorage.size() <= (_size / BITS_PER_WORD))
				bitstorage.push_back(0);
		}

		for (size_t i = 0; i < bits.size(); i++)//build bit
		{
				if (bits[i] == '1')
					bitstorage[i / BITS_PER_WORD] |= (1u << (i));
				else if (bits[i] == '0')
					bitstorage[i / BITS_PER_WORD] &= (~(1u << (i)));
				else
					throw runtime_error("");
		}
	}

	size_t capacity() const{ return bitstorage.size() * BITS_PER_WORD; } // # of bits the current allocation can hold
	
	// Mutators
	BitArray& operator+=(bool item) // Append a bit
	{
		_size++;
		while (bitstorage.size() <= (_size / BITS_PER_WORD))
			bitstorage.push_back(0);
		if (item != 0)
			bitstorage[(_size - 1) / BITS_PER_WORD] |= (1u << (_size - 1));
		else if (item == 0)
			bitstorage[(_size - 1) / BITS_PER_WORD] &= (~(1u << (_size - 1)));
		return *this;
	}

	BitArray& operator+=(const BitArray& b) // Append a BitArray
	{
		int tmpsize = _size;
		int j = 0;
		for (int i = _size - b._size; i < tmpsize; i++)
		{
			if ((b.bitstorage[j / BITS_PER_WORD] & (1u << j)) != 0)
				this->operator+=(true);
			else
				this->operator+=(false);
			j++;
		}
		return *this;
	}

	void erase(size_t pos) // Remove a bit (slide "left")
	{
		for (int i = 0; i < _size - pos - 1; i++)
		{
			if ((bitstorage[(pos + i) / BITS_PER_WORD] & (1u << (pos + i))) != 0) //1 bit, copy into pos + i.
			{
				if ((bitstorage[(pos + i + 1) / BITS_PER_WORD] & (1u << (pos + i + 1))) != 0);//1 bit here. Do nothing.
				else//Set bit to 0.
					bitstorage[(pos + i) / BITS_PER_WORD] &= (~(1u << (pos + i)));
			}
			else//0 bit, copy into pos + i.
			{
				if ((bitstorage[(pos + i + 1) / BITS_PER_WORD] & (1u << (pos + i + 1))) != 0)//Set bit to 1. otherwise do nothing.
					bitstorage[(pos + i) / BITS_PER_WORD] |= (1u << (pos + i));
			}
		}
		bitstorage[(_size - 1) / BITS_PER_WORD] &= (~(1u << (_size - 1)));
		_size--;
	}

	void erase(size_t pos, size_t nbits) // Remove a number of bits
	{
		for (int j = 0; j < nbits; j++)
			this->erase(pos);
	}

	void insert(size_t pos, bool item) // Insert a bit at a position (slide "right")
	{
		_size++;

		if (_size > 0)
		{
			while (bitstorage.size() <= (_size / BITS_PER_WORD))
				bitstorage.push_back(0);
		}

		for (int i = _size - 1; i > pos; i--)
		{
			if ((bitstorage[(i - 1) / BITS_PER_WORD] & (1u << (i - 1))) != 0)
			{//bit is 1 here, set i to 1.
				if ((bitstorage[i / BITS_PER_WORD] & (1u << i)) != 0);//do nothing, i set.
				else//set to 1.
					bitstorage[i / BITS_PER_WORD] |= (1u << i);
			}
			else
			{//bit is 0 here, set i to 0.
				if ((bitstorage[i / BITS_PER_WORD] & (1u << i)) != 0)//set to 0. otherwise nothing.
					bitstorage[i / BITS_PER_WORD] &= (~(1u << i));
			}
		}
		//insert into position.
		if (item != 0)//set to 1.
			bitstorage[pos / BITS_PER_WORD] |= (1u << pos);
		else//set to 0.
			bitstorage[pos / BITS_PER_WORD] &= (~(1u << pos));
	}
	void insert(size_t pos, const BitArray& ba) // Insert an entire BitArray object
	{
		int tmpsize = _size;
		int j = 0;
		for (int i = _size - ba._size; i < tmpsize; i++)
		{
			if ((ba.bitstorage[j / BITS_PER_WORD] & (1u << j)) != 0)
				this->insert(pos, true);
			else
				this->insert(pos, false);
			j++;
		}
	}

	void shrink_to_fit() // Discard unused trailing blocks
	{
		cout << "shrinking from " << bitstorage.size() << " to ";
		while (bitstorage.size() > ((_size / BITS_PER_WORD) + 1))
			bitstorage.pop_back();
		cout << bitstorage.size() << " words\n";
	}

	void reserve(size_t nbits) // Reserve space for nbits bits (but don’t use yet)
	{
		size_t blocknum = (_size + nbits) / BITS_PER_WORD;

		while (bitstorage.size() - 1 < blocknum)
			bitstorage.push_back(0);
	}

	// Bitwise ops
	bitproxy operator[](size_t item)
	{
		if (item >= 0 && item < _size)
		{
			if ((bitstorage[item / BITS_PER_WORD] & (1u << item)) != 0)
				this->val = true;
			else this->val = false;
			return bitproxy(this, item);
		}
		else
			throw logic_error("");
	}

	bool operator[](size_t item) const
	{
		if (item >= 0 && item < _size)
		{
			if ((bitstorage[item / BITS_PER_WORD] & (1u << item)) != 0)
				return true;
			else return false;
		}
		else
			throw logic_error("");
	}

	void toggle(size_t item) 
	{
		if (_size > 0)
		{
			if ((bitstorage[item / BITS_PER_WORD] & (1u << item)) != 0) //bit is 1, flip it.
				bitstorage[item / BITS_PER_WORD] ^= (1u << item);
			else //bit is 0, flip it.
				bitstorage[item / BITS_PER_WORD] |= (1u << item);
		}
		else
			throw logic_error("");
	}
	
	void toggle(){*this = this->operator~();}// Toggles all bits
	
	BitArray operator~() const
	{
		BitArray<IType> tmp = *this;
		for (size_t i = 0; i < _size; i++)
		{
			if ((tmp.bitstorage[i / BITS_PER_WORD] & (1u << i)) != 0) //1 bit, flip it to 0.
				tmp.bitstorage[i / BITS_PER_WORD] &= (~(1u << i));
			else // 0 bit, flip it to 1.
				tmp.bitstorage[i / BITS_PER_WORD] |= (1u << i);
		}
		return tmp;
	}

	BitArray operator<<(unsigned int amt) const // Shift operators…
	{
		BitArray<IType> tmp = *this;
		for (size_t i = 0; i < _size - amt; i++)
		{
			if ((tmp.bitstorage[(amt + i) / BITS_PER_WORD] & (1u << (amt + i))) != 0) //bit is 1 so copy 1 into _size - amt - i - 1.
				tmp.bitstorage[i / BITS_PER_WORD] |= (1u << i);
			else //bit is 0 so copy 0 into _size - amt - i - 1.
				tmp.bitstorage[i / BITS_PER_WORD] &= (~(1u << i));
		}
		//add zeros at left end.
		for (size_t i = _size - amt; i < _size; i++)
			tmp.bitstorage[i / BITS_PER_WORD] &= (~(1u << i));
		return tmp;
	}

	BitArray operator>>(unsigned int amt) const
	{
		BitArray<IType> tmp = *this;
		for (size_t i = 0; i < _size - amt; i++)
		{
			if ((tmp.bitstorage[(_size - amt - 1 - i) / BITS_PER_WORD] & (1u << (_size - amt - 1 - i))) != 0) //bit is 1 so copy 1 into_size - i - 1.
				tmp.bitstorage[(_size - i - 1) / BITS_PER_WORD] |= (1u << (_size - i - 1));
			else //bit is 0 so copy 0 into _size - i - 1.
				tmp.bitstorage[(_size - i - 1) / BITS_PER_WORD] &= (~(1u << (_size - i - 1)));
		}
		//add zeros at right end.
		for (size_t i = 0; i < amt; i++)
			tmp.bitstorage[i / BITS_PER_WORD] &= (~(1u << i));
		return tmp;
	}

	BitArray& operator<<=(unsigned int amt){return (*this = this->operator<<(amt));}
	
	BitArray& operator>>=(unsigned int amt){return (*this = this->operator>>(amt));}
	
	// Extraction ops
	BitArray slice(size_t pos, size_t count) const // Extracts a new sub-array
	{
		BitArray<IType> tmpBA = *this;
		int tmpAmt = tmpBA.size() - (pos + count);
		if (count > 0)
			tmpBA.erase(pos + count, tmpAmt);
		if (pos > 0)
			tmpBA.erase(0, pos);
		
		return tmpBA;
	}

	// Comparison ops
	bool operator==(const BitArray& ba) const
	{
		if (_size == ba._size)
		{
			if (this->to_string() == ba.to_string())
				return true;
			else
				return false;
		}
		else return false;
	}

	bool operator!=(const BitArray& ba) const{return !operator==(ba);}
	
	bool operator<(const BitArray& ba) const
	{
		if (this->to_string() < ba.to_string())
			return true;
		else return false;
	}

	bool operator<=(const BitArray& ba) const
	{
		if (this->to_string() <= ba.to_string())
			return true;
		else return false;
	}

	bool operator>(const BitArray& ba) const
	{
		if (this->to_string() > ba.to_string())
			return true;
		else return false;
	}

	bool operator>=(const BitArray& ba) const
	{
		if (this->to_string() >= ba.to_string())
			return true;
		else return false;
	}

	// Counting ops
	size_t size() const{return _size;}
	
	size_t count() const // The number of 1-bits present
	{
		size_t tmp = 0;
		for (IType i = 0; i < _size; i++)
		{
			if ((bitstorage[i / BITS_PER_WORD] & (1u << i)) != 0)
				tmp++;
		}
		return tmp;
	}
	bool any() const // Optimized version of count() > 0
	{
		if (_size == 0)
			return false;
		else
		{
			for (IType i = 0; i < _size; i++)
			{
				if ((bitstorage[i / BITS_PER_WORD] & (1u << i)) != 0)
					return true;
			}
			return false;
		}
	}

	// Stream I/O (define these in situ)
	//friend ostream& operator<<(ostream&, const BitArray&);
	
	friend std::istream& operator>>(std::istream& is, BitArray& ba)
	{
		is.clear();
		string tmp = "";
		while (is)
		{
			char c = ' ';
			is >> c;
			if (c == '1' || c == '0')
				tmp += c;
			else
				is.setstate(ios::failbit);
		}

		if (tmp.size() > 0)
			ba = BitArray(tmp);
		return is;
	}

	// String conversion
	std::string to_string() const
	{
		std::string tmp = "";
		for (size_t i = 0; i < _size; i++)
		{
			//check if the bit is set to 1.
			if ((bitstorage[i / BITS_PER_WORD] & (1u << i)) != 0)
				tmp = tmp + "1";
			else
				tmp = tmp + "0";
		}
		return tmp;
	}
};

#endif