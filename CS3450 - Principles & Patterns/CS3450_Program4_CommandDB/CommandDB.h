#include <iostream>
#include <vector>
#include <map>
#include <string>
#include <iterator>
#include <fstream>
#include <sstream>
using namespace std;

//Concrete Receiver
class Database
{
	map<string, string> data;
	string DBID;
public:
	~Database(){}
	Database(){}
	Database(string ID){ DBID = ID; }
	string getID() const { return DBID; }
	string get(const string& key)
	{
		const map<string, string>::iterator findKey = data.find(key);
		return findKey->first;
	}
	void add(const string& key, const string& value)
	{
		//dont allow add command for a key that exists.
		if (data.find(key) == data.end())
		{
			// key not found.
			data.insert(std::pair<string, string>(key, value));
		}
		else {} //key found, do nothing(ignore it).
		string temp = "";
	}
	void update(const string& key, const string& value)
	{
		if (data.find(key) == data.end()) {} //key not found so ignore process.
		else
		{
			map<string, string>::iterator it = data.find(key);
			if (it != data.end())
				it->second = value;
		}
	}
	void remove(const string& key)
	{
		if (data.find(key) == data.end()) {} //key not found so ignore process.
		else
		{
			map<string, string>::iterator it = data.find(key);
			data.erase(it);
		}
	}
	void backup(ostream& dest) const // Writes key|value lines
	{
		dest << "\nDatabase " << DBID << ":\n";
		for (auto it = data.begin(); it != data.end(); ++it)
			dest << it->first << "|" << it->second << endl;
		dest << endl;
	}

	void macro(ostream& dest, string out)
	{
		dest << out << endl;
	}

	void clearData()
	{
		data.clear();
	}
};

class Command
{
public:
	virtual void execute() = 0;
	virtual string getName() = 0;
	virtual string getID() = 0;
};

class AddCommand : public Command
{
	typedef void(Database:: *Action)(const string& key, const string& value);
	Database *receiver;
	Action action;
	string key, value, name;
public:
	AddCommand(Database *rec, Action act, string k, string val)
	{
		receiver = rec;
		action = act;
		key = k;
		value = val;
		name = "AddCommand";
	}
	void execute()
	{
		(receiver->*action)(key, value);
		string temp = "";
	}
	string getName() { return name; }
	string getID()
	{
		return receiver->getID();
	}
};

class RemoveCommand : public Command
{
	typedef void(Database:: *Action)(const string& key);
	Database *receiver;
	Action action;
	string key, value, name;
public:
	RemoveCommand(Database *rec, Action act, string k, string val)
	{
		receiver = rec;
		action = act;
		key = k;
		value = val;
		name = "RemoveCommand";
	}
	void execute()
	{
		(receiver->*action)(key);
	}
	string getName() { return name; }

	string getID()
	{
		return receiver->getID();
	}
};

class UpdateCommand : public Command
{
	typedef void(Database:: *Action)(const string& key, const string& value);
	Database *receiver;
	Action action;
	string key, value, name;
public:
	UpdateCommand(Database *rec, Action act, string k, string val)
	{
		receiver = rec;
		action = act;
		key = k;
		value = val;
		name = "UpdateCommand";
	}
	void execute()
	{
		(receiver->*action)(key, value);
	}
	string getName() { return name; }

	string getID()
	{
		return receiver->getID();
	}
};

class MacroCommand : public Command
{
	typedef void(Database:: *Action)(ostream& dest, string out);
	Database *receiver;
	Action action;
	string msg, name, end;
	int count;
	ostream& dest;
	vector < Command * > list;
public:
	MacroCommand(Action act, ostream& stream, string m) : dest(stream)
	{
		action = act;
		msg = m;
		name = "MacroCommand";
		end = "Ending a Macro\n";
	}
	void add(Command* cmd)
	{
		string temp = "";
		list.push_back(cmd);
	}
	void execute()
	{
		dest << msg;
		for (int i = 0; i < list.size(); i++)
			list[i]->execute();
		dest << end;
		msg = "";
		end = msg;
	}
	string getName() { return name; }

	string getID()
	{
		return "";
	}
};