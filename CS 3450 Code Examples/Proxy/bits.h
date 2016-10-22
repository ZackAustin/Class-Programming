#include <iostream>
#include <sstream>
using namespace std;


class Bits {
	
	
	typedef unsigned int IType;
	enum {BITS_PER_WORD = CHAR_BIT * sizeof(IType)}; // IType == unsigned int	
	//static const IType BITS_PER_WORD = CHAR_BIT * sizeof(IType);
	
	// data
	IType* words;
    size_t nwords;          // Number of words in use
    size_t nwords_allocated;
    size_t nbits;           // Number of bits in use

	
	// helper functions
	const size_t word_pos (size_t pos) const { return pos / BITS_PER_WORD; }
	const size_t bit_pos (size_t pos) const { return pos % BITS_PER_WORD; }
	
	size_t words_needed (size_t bits) {
		return bits / BITS_PER_WORD + bool (bits % BITS_PER_WORD);
	}
	
	void write_bit (size_t pos, bool bit) {
		if (bit)
			words[word_pos(pos)] |= 1u << bit_pos(pos);
		else
			words[word_pos(pos)] &= ~(1u << bit_pos(pos));
	}
	void toggle_bit (size_t pos) {
		words[word_pos(pos)] ^= 1u << bit_pos(pos);
	}
	
	const bool get_bit (size_t pos) const {
		return words[word_pos(pos)] & 1u << bit_pos(pos);
	}
	
	void make_space (size_t num_bits);
	
	int compare (const Bits& rhs) const;

	// bitproxy class
	friend class bitproxy
	{
		Bits& bitsref;
		size_t bitspos;
		
	public:
		bitproxy (Bits& b, size_t p) : bitsref(b), bitspos(p) {}
		
		bitproxy operator= (bool bit) {
			bitsref.write_bit(bitspos, bit);
			return *this;
		}
		operator bool() { return bitsref.get_bit(bitspos); }		
	};
	
	public:
		
	Bits(const Bits&, size_t start_pos, size_t num_bits);	// ADDED
	
	Bits operator+ (const Bits& b);						// ADDED -- concatenation
	Bits operator| (const Bits& b) const;				// ADDED -- bitwise or
	Bits operator& (const Bits& b) const;				// ADDED -- bitwise and
	
    // Object Management
    explicit Bits(size_t = 0);
    explicit Bits(const string&);
    Bits(const Bits&);
	
    Bits& operator=(const Bits&);
    ~Bits();
	
    // Mutators
    Bits& operator+=(bool);		// Append a bit
    Bits& operator+=(const Bits& b);	// Append a Bits
    void erase(size_t);			// Remove a bit (slide "left")
    void erase(size_t, size_t);		// Remove a number of bits
    void insert(size_t, bool);		// Insert a bit at a given bit position
    void insert(size_t, const Bits&);	// Insert an entire Bits object
    void compress();			// Discard unneeded trailing blocks
    
    // Bitwise ops
	bitproxy operator[](size_t);
    bool operator[](size_t) const;
    void toggle(size_t);
    void toggle();
    Bits operator~() const;
    Bits operator<<(unsigned int) const;// Shift operators…
    Bits operator>>(unsigned int) const;
    Bits& operator<<=(unsigned int);
    Bits& operator>>=(unsigned int);
    
    // Extraction ops
    Bits slice(size_t, size_t) const;	// Extracts a substring (2nd arg is the count)
    
    // Comparison ops
    bool operator==(const Bits&) const;
    bool operator!=(const Bits&) const;
    bool operator<(const Bits&) const;
    bool operator<=(const Bits&) const;
    bool operator>(const Bits&) const;
    bool operator>=(const Bits&) const;
    
    // Counting ops
    size_t size() const;
    size_t count() const;			// The number of 1-bits present
    bool any() const;			// Optimized version of count() > 0
    
    // Stream I/O
    friend ostream& operator<<(ostream&, const Bits&);
    friend istream& operator>>(istream&, Bits&);

};

