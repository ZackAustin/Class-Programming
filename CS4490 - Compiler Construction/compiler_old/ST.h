#pragma once

#include <string>
#include <vector>
#include <map>
#include "Scanner.h"

class KindData
{
public:
	virtual ~KindData() = default;
	virtual void print(std::ostream& os) = 0;
};

class varData : public KindData
{
	std::string _type;
	std::string _accessMod;
public:
	varData(std::string type, std::string accessMod) : _type(type), _accessMod(accessMod){}
	~varData(){}
	void print(std::ostream& os)
	{
		os << this;
	}

	friend std::ostream& operator<<(std::ostream& os, const varData* definedData)
	{
		os << "Data:\ttype: " << definedData->_type << std::endl;
		os << "\taccessMod: " << definedData->_accessMod << std::endl << std::endl;
		return os;
	}
};

class methodData : public KindData
{
	std::string _returnType;
	std::string _param;
	std::string _accessMod;
public:
	methodData(std::string returntype, std::string param, std::string accessMod) : _returnType(returntype),
		_param(param), _accessMod(accessMod){}
	~methodData(){}
	void print(std::ostream& os)
	{
		os << this;
	}

	friend std::ostream& operator<<(std::ostream& os, const methodData* definedData)
	{
		os << "Data:\treturnType: " << definedData->_returnType << std::endl;
		os << "\tParam: " << definedData->_param << std::endl;
		os << "\taccessMod: " << definedData->_accessMod << std::endl << std::endl;
		return os;
	}
};

struct STData
{
	std::string _scope;
	std::string _symID;
	std::string _value;
	std::string _kind;
	KindData* _data;
	STData(std::string scope, std::string symID, std::string value, std::string kind, KindData* data) :_scope(scope), _symID(symID), _value(value), _kind(kind){ _data = data; }
	~STData(){}
	friend std::ostream& operator<<(std::ostream& os, const STData* definedData)
	{
		os << "Scope:\t" << definedData->_scope << std::endl;
		os << "Symid:\t" << definedData->_symID << std::endl;
		os << "Value:\t" << definedData->_value << std::endl;
		os << "Kind:\t" << definedData->_kind << std::endl;
		if (definedData->_data != nullptr)
			definedData->_data->print(os);
		else
			os << "Data:" << std::endl << std::endl;
		return os;
	}
};

class ST
{
	std::map<std::string, STData*> _symbolTable;
	Scanner* _ct;
	static int stCounter;
public:
	std::string _scope; //keep up with scope
	ST(Scanner* ct);
	~ST();
	//insertFunct. Calls genSym first.
	struct std::pair<class std::_Tree_iterator<class std::_Tree_val<struct std::_Tree_simple_types<struct std::pair<class std::basic_string<char, struct std::char_traits<char>, class std::allocator<char> > const, struct STData *> > > >, bool> STInsert(STData* value);
	std::string genSym(std::string kind);
	static int getSTCounter() { return stCounter; }
};