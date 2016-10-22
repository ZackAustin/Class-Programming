#include "st.h"

ST::ST()
{
	scope = "g";
	symbolCounter = 0;
}

ST::~ST(){}

bool ST::insert(STData* d)
{
	bool itsADuplicate = false, uniquenessError = false;
	//check for duplicates before inserting at the current scope.
	for(auto it = symbolTable.begin(); it != symbolTable.end(); it++)
	{
		if (it->second->scope == d->scope)
		{
			if (it->second->value == d->value)
			{
				itsADuplicate = true;
				if (itsADuplicate && d->kind != "literal")
					uniquenessError = true;
			}
		}
	}
	if (itsADuplicate == false)
	{
		symbolTable.insert(std::pair<std::string, STData*> (d->symID, d)).second;
	}
	else delete d;
	return uniquenessError;
}

std::string ST::genSym(std::string kind)//needs a parameter for the Kind.
{
	ss.str(std::string());
    ss << symbolCounter++;
	return kind += ss.str();
}

std::string ST::scopeSearch(std::string scope, std::string identifier)
{
	for(auto it = symbolTable.begin(); it != symbolTable.end(); it++)
	{
		if (it->second->scope == scope)
		{
			if (it->second->value == identifier)
			{
				return it->second->symID;
			}
		}
	}
	return "";
}

std::vector<std::string> ST::extractScope(std::string scope)
{
	std::vector<std::string> scopeSymIDs;
	for(auto it = symbolTable.begin(); it != symbolTable.end(); it++)
	{
		if (it->second->scope == scope)
		{
			scopeSymIDs.push_back(it->second->symID);
		}
	}
	return scopeSymIDs;
}

std::vector<std::string> ST::getLocation(std::string symID)
{
	return symbolTable[symID]->getLocations();
}

std::string ST::getSymIDForLabel(std::string label)
{
	//std::cout << "passed label: " << label << std::endl;

	std::string scopeToSearch = label.substr(0, label.find_last_of("_"));
	std::replace(scopeToSearch.begin(), scopeToSearch.end(), '_', '.');

	//std::cout << "scopeToSearch: " << scopeToSearch << std::endl;

	std::string valueToSearch = label.substr(label.find_last_of("_") + 1);

	//std::cout << "valueToSearch: " << valueToSearch << std::endl;

	std::string symID = scopeSearch(scopeToSearch, valueToSearch);

	//std::cout << "symID: " << symID << std::endl;


	return symID;
}