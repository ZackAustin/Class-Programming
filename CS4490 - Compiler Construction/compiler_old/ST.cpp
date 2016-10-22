#include "ST.h"
#include <typeinfo>

using namespace std;

int ST::stCounter = 1;

ST::ST(Scanner* ct) : _ct(ct){ _scope = "g"; }

ST::~ST()
{
	//delete the ST pointers which delete KD pointers.
}

struct std::pair<class std::_Tree_iterator<class std::_Tree_val<struct std::_Tree_simple_types<struct std::pair<class std::basic_string<char, struct std::char_traits<char>, class std::allocator<char> > const, struct STData *> > > >, bool> ST::STInsert(STData* value)
{
	auto ret = _symbolTable.insert(pair<string, STData*> (value->_symID, value));
	return ret;
}

string ST::genSym(string kind)//needs a parameter for the Kind.
{
	return kind += to_string(stCounter++);
}