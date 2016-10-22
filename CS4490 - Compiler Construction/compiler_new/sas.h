#pragma once
#include <string>
#include <vector>
#include <iostream>
#include <cstring>
#include <sstream>
#include "st.h"

struct semanticMessager
{
	bool success;
	std::string message;
	semanticMessager(bool s, std::string m) : success(s), message(m){}
};

class SAR
{
public:
	virtual ~SAR() = default;
	//virtual void print(std::ostream& os) = 0;
	virtual std::string getDebug() = 0;
	virtual std::string getName() = 0;
	virtual std::string getSymID() = 0;
	virtual semanticMessager* checkExistance(std::string, ST* &st) = 0;
	virtual bool isASentinel() = 0;
	virtual std::vector<SAR*> getAL() = 0;
	virtual std::string getType() = 0;
	virtual bool isArr() = 0;
	virtual bool isFunc() = 0;
	virtual std::string getSA() = 0;
	virtual void setSymID(std::string) = 0;
};

class _sar : public SAR
{
public:
	std::string name;
	std::string SA;
	_sar(std::string n, std::string sa) : name(n), SA(sa){}
	~_sar(){}

	void setSymID(std::string symid) {}

	std::string getDebug()
	{
		return name + "\t- " + SA;
	}

	std::string getName()
	{
		return name;
	}

	std::string getSymID()
	{
		return "";
	}

	std::string getType()
	{
		return "";
	}

	std::string getSA(){return SA;}

	semanticMessager* checkExistance(std::string id, ST* &st)
	{
		//make sure ids kind isn't a method and type isn't an array.
		try
		{
			std::string idKind = st->symbolTable[id]->getKind();
			if (idKind == "method")
			{
				return new semanticMessager{false, "Expected a function declaration."};
			}

			if (name != "")
				return new semanticMessager{true, ""};
			else return new semanticMessager{false, name + " does not exist."};

		}
		catch(...) {return new semanticMessager{false, id + " does not exist."};}
	}

	bool isASentinel() {return false;}
	bool isArr() {return false;}
	bool isFunc() {return false;}
	std::vector<SAR*> getAL() {return std::vector<SAR*>{};}
};

class bal_SAR : public SAR
{
public:
	bal_SAR(){}
	~bal_SAR(){}

	void setSymID(std::string symid) {}

	std::string getDebug()
	{
		return std::string{} + "bal_sar" + "\t- " + "#BAL";
	}

	std::string getName()
	{
		return "bal_sar";
	}

	std::string getSymID()
	{
		return "";
	}

	std::string getType()
	{
		return "";
	}

	std::string getSA(){return "";}

	semanticMessager* checkExistance(std::string id, ST* &st)
	{
		return new semanticMessager{true, ""};
	}

	bool isASentinel() {return true;}
	bool isArr() {return false;}
	bool isFunc() {return false;}
	std::vector<SAR*> getAL() {return std::vector<SAR*>{};}
};

class type_SAR : public SAR
{
public:
	std::string type;
	std::string SA;
	type_SAR(std::string t, std::string sa) : type(t), SA(sa){}
	~type_SAR(){}

	void setSymID(std::string symid) {}

	std::string getDebug()
	{
		return type + "\t- " + SA;
	}

	std::string getName()
	{
		return type;
	}

	std::string getSymID()
	{
		return "";
	}

	std::string getType()
	{
		return type;
	}

	std::string getSA(){return SA;}

	semanticMessager* checkExistance(std::string id, ST* &st)
	{
		if(type != "")
			return new semanticMessager{true, ""};
		else return new semanticMessager{false, type + " does not exist."};
	}

	bool isASentinel() {return false;}
	bool isArr() {return false;}
	bool isFunc() {return false;}
	std::vector<SAR*> getAL() {return std::vector<SAR*>{};}
};

class id_SAR : public SAR
{
public:
	std::string identifier;
	std::string type;
	std::string symID;
	std::string SA;
	bool usedAsArrayIndex;
	id_SAR(std::string id, std::string t, std::string sid, std::string sa, bool ai) : identifier(id), type(t), symID(sid), SA(sa), usedAsArrayIndex(ai){}
	~id_SAR(){}

	void setSymID(std::string symid)
	{
		symID = symid;
	}

	std::string getDebug()
	{
		return symID + "\t- " + SA;
	}

	std::string getName()
	{
		return identifier;
	}

	std::string getSymID()
	{
		return symID;
	}

	std::string getType()
	{
		return type;
	}
	std::string getSA(){return SA;}

	semanticMessager* checkExistance(std::string id, ST* &st)
	{
		if(symID != "")
			return new semanticMessager{true, ""};
		else return new semanticMessager{false, symID + " does not exist."};
	}

	bool isASentinel() {return false;}
	bool isArr() {return usedAsArrayIndex;}
	bool isFunc() {return false;}
	std::vector<SAR*> getAL() {return std::vector<SAR*>{};}
};

class ref_SAR : public SAR
{
public:
	std::string identifier;
	std::string type;
	std::string symID;
	std::string SA;
	bool usedAsArrayIndex;
	ref_SAR(std::string id, std::string t, std::string sid, std::string sa, bool ai) : identifier(id), type(t), symID(sid), SA(sa), usedAsArrayIndex(ai){}
	~ref_SAR(){}

	void setSymID(std::string symid)
	{
		symID = symid;
	}

	std::string getDebug()
	{
		return symID + "\t- " + SA;
	}

	std::string getName()
	{
		return identifier;
	}

	std::string getSymID()
	{
		return symID;
	}

	std::string getType()
	{
		return type;
	}

	std::string getSA(){return SA;}

	semanticMessager* checkExistance(std::string id, ST* &st)
	{
		try
		{
			std::string params = (st->symbolTable[id]->getParams()).substr(1);
		}
		catch(...) {return new semanticMessager{false, "expected a method."};}

		if(symID != "")
			return new semanticMessager{true, ""};
		else return new semanticMessager{false, symID + " does not exist."};
	}

	bool isASentinel() {return false;}
	bool isArr() {return usedAsArrayIndex;}
	bool isFunc() {return false;}
	std::vector<SAR*> getAL() {return std::vector<SAR*>{};}
};

class al_SAR : public SAR
{
public:
	std::vector<SAR*> AL_SYMIDS;
	std::string SA;
	al_SAR(std::vector<SAR*> &alSARS, std::string sa) : SA(sa)
	{
		for (size_t i = 0; i < alSARS.size(); i++)
		{
			AL_SYMIDS.push_back(alSARS[i]);
		}
	}
	~al_SAR(){}

	void setSymID(std::string symid) {}

	std::string getDebug()
	{
		return std::string{} + "al_sar" + "\t- " + SA;
	}

	std::string getName()
	{
		return "al_sar";
	}

	std::string getSymID()
	{
		return "";
	}

	std::string getType()
	{
		return "";
	}

	std::string getSA(){return SA;}

	semanticMessager* checkExistance(std::string id, ST* &st)
	{
		return new semanticMessager{true, ""};
	}

	bool isASentinel() {return false;}
	bool isArr() {return false;}
	bool isFunc() {return false;}
	std::vector<SAR*> getAL() {return AL_SYMIDS;}
};

class func_SAR : public SAR
{
public:
	std::vector<SAR*> AL_SYMIDS;
	std::string identifier;
	std::string SA;
	func_SAR(SAR* &alSARS, SAR* &idSAR)
	{
		auto alSARS_list = alSARS->getAL();
		for (size_t i = 0; i < alSARS_list.size(); i++)
		{
			AL_SYMIDS.push_back(alSARS_list[i]);
		}
		identifier = idSAR->getName();
		SA = "#func";
	}
	~func_SAR(){}

	void setSymID(std::string symid) {}

	std::string getDebug()
	{
		return std::string{} + "func_sar" + "- " + SA;
	}

	std::string getName()
	{
		return identifier;
	}

	std::string getSymID()
	{
		return "";
	}

	std::string getType()
	{
		return "";
	}

	std::string getSA(){return SA;}

	semanticMessager* checkExistance(std::string id, ST* &st)
	{
		//This is the function in class. Check it's arity and params with our vector.
			//id.
		//This is the identifier before #Exist function. It will be passed id after this, in a ref sar. identifier.
			//identifier.
		//Check Order, Arity, and Type.
			//Check Arity First.

		std::string params = "";
		try
		{
			params = (st->symbolTable[id]->getParams()).substr(1);
			params.pop_back();

			std::vector<std::string> arity;

			std::stringstream ss(params);
			std::string item;

			while (std::getline(ss, item, ','))
			{
				size_t first = item.find_first_not_of(' ');
				size_t last = item.find_last_not_of(' ');
				item = item.substr(first, (last-first+1));
				arity.push_back(item);
			}

			//Arity check.
			if (arity.size() != AL_SYMIDS.size())
			{
				std::stringstream ss;
				ss << arity.size();
				return new semanticMessager{false, "Failed arity check. Expected size: " + ss.str()};
			}

			for (size_t i = 0; i < arity.size(); i++)
			{

				//Type Check each Parameter.
				std::string nextParamType = st->symbolTable[arity[i]]->getType();
				std::string nextALType = AL_SYMIDS[i]->getType();

				if (nextParamType != nextALType)
					return new semanticMessager{false, "Expected: " + nextParamType + " Found: " + nextALType};
			}
		}
		catch(...){return new semanticMessager{false, "Function does not exist."};}

		return new semanticMessager{true, ""};
	}

	bool isASentinel() {return false;}
	bool isArr() {return false;}
	bool isFunc() {return true;}
	std::vector<SAR*> getAL() {return AL_SYMIDS;}
};

class new_SAR : public SAR
{
public:
	std::vector<SAR*> AL_SYMIDS;
	std::string identifier;
	std::string type;
	std::string SA;
	new_SAR(SAR* &alSARS, SAR* &typeSAR, std::string id, std::string sa)
	{
		auto alSARS_list = alSARS->getAL();
		for (size_t i = 0; i < alSARS_list.size(); i++)
		{
			AL_SYMIDS.push_back(alSARS_list[i]);
		}
		type = typeSAR->getName();
		SA = sa;
		identifier = id;
	}
	new_SAR(std::string id, std::string t, std::string sa) : identifier(id), type(t), SA(sa){}
	~new_SAR(){}

	void setSymID(std::string symid) {}

	std::string getDebug()
	{
		return std::string{} + "new_sar" + "\t- " + SA;
	}

	std::string getName()
	{
		return type;
	}

	std::string getSymID()
	{
		return identifier;
	}

	std::string getType()
	{
		return type;
	}

	std::string getSA(){return SA;}

	semanticMessager* checkExistance(std::string id, ST* &st)
	{
		return new semanticMessager{true, ""};
	}

	bool isASentinel() {return false;}
	bool isArr() {return false;}
	bool isFunc() {return false;}
	std::vector<SAR*> getAL() {return AL_SYMIDS;}
};

class arr_SAR : public SAR
{
public:
	std::vector<SAR*> AL_SYMIDS;
	std::string identifier;
	std::string SA;
	arr_SAR(std::string id, std::vector<SAR*> symIDForArrSize, std::string sa) : identifier(id), SA(sa)
	{
		for (size_t i = 0; i < symIDForArrSize.size(); i++)
			AL_SYMIDS.push_back(symIDForArrSize[i]);
	}
	~arr_SAR(){}

	void setSymID(std::string symid) {}

	std::string getDebug()
	{
		return std::string{"arr_sar"} + "\t- " + SA;
	}

	std::string getName()
	{
		return identifier;
	}

	std::string getSymID()
	{
		return "";
	}

	std::string getType()
	{
		return "";
	}

	std::string getSA(){return SA;}

	semanticMessager* checkExistance(std::string id, ST* &st)
	{
		//Test that the id is an array.

		if (id == "")
			return new semanticMessager{false, id + " does not exist."};

		try
		{
			std::string type = st->symbolTable[id]->getType();
			std::string arrayType = type.substr(0, 2);

			if (arrayType != "@:")
				return new semanticMessager{false, "Not an array type."};

			return new semanticMessager{true, ""};
		}
		catch(...){return new semanticMessager{false, id + "d oes not exist."};}

		return new semanticMessager{true, ""};
	}

	bool isASentinel() {return false;}
	bool isArr() {return true;}
	bool isFunc() {return false;}
	std::vector<SAR*> getAL() {return AL_SYMIDS;}
};

class SAS
{
public:
	std::vector<SAR*> sas;
	void push(SAR*);
	SAR* pop();
};