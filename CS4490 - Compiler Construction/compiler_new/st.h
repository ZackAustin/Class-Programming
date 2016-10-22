#pragma once

#include <map>
#include <sstream>
#include <string>
#include <iostream>
#include <algorithm>
#include <functional>

struct SYMID
{
	std::string symID;
	long symbolCounter;
	SYMID(std::string ID, long sc) : symID(ID), symbolCounter(sc){}

	friend std::ostream& operator<<(std::ostream& os, SYMID const& id)
	{
		os << "\n" << id.symID << " ->";
		return os;
	}
};

struct mapOrdering
{
	bool operator()(const std::string& s1, const std::string& s2)
	{
		int n1 = 0, n2 = 0;
		std::istringstream(s1.substr(1)) >> n1;
		std::istringstream(s2.substr(1)) >> n2;
		if (n1 < n2)
			return true;
		else return false;
	}
};

class KindData
{
public:
	virtual ~KindData() = default;
	virtual void print(std::ostream& os) = 0;
	virtual std::string getType() = 0;
	virtual std::string getAccessMod() = 0;
	virtual std::string getParams() = 0;
	virtual void setSize(std::string) = 0;
	virtual std::string getSize() = 0;
	virtual std::string getRefFlag() = 0;
	virtual void setRefFlag(std::string) = 0;
};

class classData : public KindData
{
	std::string size;
	std::string type;
public:
	classData(std::string s, std::string t) : size(s), type(t) {}
	~classData(){}

	void print(std::ostream& os){os << this;}
	std::string getType(){return type;}
	std::string getAccessMod(){return "unprotected";}
	std::string getParams(){return "";}
	void setSize(std::string val){size = val;}
	std::string getSize(){return size;}
	std::string getRefFlag(){return "";}
	void setRefFlag(std::string s) {}

	friend std::ostream& operator<<(std::ostream& os, const classData* definedData)
	{
		os << "\tData:\tSize: " << definedData->size << std::endl;
		os << "\t\tType: " << definedData->type << std::endl << std::endl;
		return os;
	}

};

class varData : public KindData
{
	std::string offset;
	std::string type;
	std::string accessMod;
	std::string usedAsRef;
public:
	varData(std::string offset, std::string type, std::string accessMod) : offset(offset), type(type), accessMod(accessMod)
	{
		usedAsRef= "N";
	}
	~varData(){}

	void print(std::ostream& os){os << this;}
	std::string getType(){return type;}
	std::string getAccessMod(){return accessMod;}
	std::string getParams(){return "";}
	void setSize(std::string val){offset = val;}
	std::string getSize(){return offset;}
	std::string getRefFlag(){return usedAsRef;}
	void setRefFlag(std::string s) {usedAsRef = s;}

	friend std::ostream& operator<<(std::ostream& os, const varData* definedData)
	{
		os << "\tData:\tOffset: " << definedData->offset << std::endl;
		os << "\t\ttype: " << definedData->type << std::endl;
		os << "\t\taccessMod: " << definedData->accessMod << std::endl << std::endl;
		return os;
	}
};

class methodData : public KindData
{
	std::string size;
	std::string returnType;
	std::string param;
	std::string accessMod;
public:
	methodData(std::string s, std::string returntype, std::string param, std::string accessMod) : size(s), returnType(returntype), param(param), accessMod(accessMod){}
	~methodData(){}

	void print(std::ostream& os){os << this;}
	std::string getType(){return returnType;}
	std::string getAccessMod(){return accessMod;}
	std::string getParams(){return param;}
	void setSize(std::string val){size = val;}
	std::string getSize(){return size;}
	std::string getRefFlag(){return "";}
	void setRefFlag(std::string s) {}

	friend std::ostream& operator<<(std::ostream& os, const methodData* definedData)
	{
		os << "\tData:\tSize: " << definedData->size << std::endl;
		os << "\t\treturnType: " << definedData->returnType << std::endl;
		os << "\t\tParam:\t" << definedData->param << std::endl;
		os << "\t\taccessMod: " << definedData->accessMod << std::endl << std::endl;
		return os;
	}
};

class tempData : public KindData
{
	std::string offset;
	std::string type;
	std::string usedAsRef;
public:
	tempData(std::string offset, std::string t, std::string ref) : offset(offset), type(t), usedAsRef(ref){}
	~tempData(){}

	void print(std::ostream& os) {os << this;}
	std::string getType(){return type;}
	std::string getAccessMod(){return "unprotected";}
	std::string getParams(){return "";}
	void setSize(std::string val){}
	std::string getSize(){return offset;}
	std::string getRefFlag(){return usedAsRef;}
	void setRefFlag(std::string s) {usedAsRef = s;}

	friend std::ostream& operator<<(std::ostream& os, const tempData* definedData)
	{
		os << "\tData:\tOffset: " << definedData->offset << std::endl;
		os << "\t\ttype: " << definedData->type << std::endl;
		os << "\t\tUsed as Ref: " << definedData->usedAsRef << std::endl << std::endl;
		return os;
	}
};

struct STData
{
	int lineNumber;
	std::string scope;
	std::string symID;
	std::string value;
	std::string kind;
	KindData* data;
	std::vector<std::string> dataLocations;
	
	STData(int line, std::string scope, std::string symID, std::string value, std::string kind, KindData* d) : lineNumber(line), scope(scope), symID(symID), value(value), kind(kind)
	{
		//REWRITE THIS, DOES NOT WORK CORRECTLY. PASS IT INTO CTOR.
		data = d;
		if (getSize() != "" && getSize() != "0" && symID.size() > 0 && symID.at(0) != 'V')
			dataLocations.push_back("stack(" + data->getSize() + ")");
		else if (symID.size() > 0 && symID.at(0) == 'V')
			dataLocations.push_back("heap(" + data->getSize() + ")");
		else if (getSize() == "0")
			dataLocations.push_back("global");
		
	}
	~STData(){}

	std::string getScope(){return scope;}
	std::string getSymID(){return symID;}
	std::string getValue(){return value;}
	std::string getKind(){return kind;}
	std::vector<std::string> getLocations(){return dataLocations;}

	std::string getType()
	{
		if (data != nullptr)
			return data->getType();
		else return "";
	}
	std::string getAccessMod()
	{
		if (data != nullptr)
			return data->getAccessMod();
		else return "";
	}

	std::string getParams()
	{
		if (data != nullptr)
			return data->getParams();
		else return "";
	}

	void setSize(std::string val)
	{
		if (data != nullptr)
			data->setSize(val);
	}

	std::string getSize()
	{
		if (data != nullptr)
			return data->getSize();
		else return "";
	}

	std::string getRefFlag()
	{
		if (data != nullptr)
			return data->getRefFlag();
		else return "";
	}

	void setRefFlag(std::string s)
	{
		if (data != nullptr)
			data->setRefFlag(s);
	}

	friend std::ostream& operator<<(std::ostream& os, const STData* definedData)
	{
		os << "\tScope:\t" << definedData->scope << std::endl;
		os << "\tSymid:\t" << definedData->symID << std::endl;
		os << "\tValue:\t" << definedData->value << std::endl;
		os << "\tKind:\t" << definedData->kind << std::endl;
		if (definedData->data != nullptr)
			definedData->data->print(os);
		else os << "\tData:" << std::endl << std::endl;
		return os;
	}
};

class ST
{
	std::ostringstream ss;
public:
	std::map<std::string, STData*, mapOrdering> symbolTable;
	long symbolCounter;
	std::string scope; //keep up with scope
	ST();
	~ST();
	bool insert(STData*);
	std::string genSym(std::string kind);
	std::string scopeSearch(std::string, std::string);
	std::vector<std::string> extractScope(std::string);
	std::vector<std::string> getLocation(std::string);
	std::string getSymIDForLabel(std::string);

	friend std::ostream& operator<< (std::ostream& os, const ST* st)
	{
		os << std::endl;
		for (auto it = st->symbolTable.begin(); it != st->symbolTable.end(); ++it)
		{
  			os << it->first;
  			os << it->second;
		}
		return os;
	}
};