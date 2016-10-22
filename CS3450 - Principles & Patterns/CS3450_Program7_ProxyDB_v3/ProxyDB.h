//ProxyDB.h

using namespace std;
#include <string>
#include <iostream>
#include <map>

#include <iterator>
#include <fstream>
#include <sstream>
#include <exception>

const int CACHE_SIZE = 5;

class IDatabase
{
public:
	virtual string getID() = 0;
	virtual bool exists(const string& key) = 0;
	virtual string get(const string& key) = 0;
};

class Database : public IDatabase
{
	map<string, string> data;
	string DBID;
	fstream dbfile;
public:
	Database(string filename) : DBID(filename)
	{
		dbfile.open(DBID);
		if (dbfile.fail())
			throw runtime_error(filename + " does not exist");
		while (!dbfile.eof())
		{
			string buf, aLine;
			getline(dbfile, aLine, '\n');
			stringstream ss(aLine);
			ss >> buf;
			string key = buf;
			string value = "";
			while (ss >> buf)
				value = value + " " + buf;
			value = value.substr(1);//remove leading space.
			data.insert(std::pair<string, string>(key, value));
		}
	}
	~Database(){ dbfile.close(); }
	string getID() { return DBID; }
	bool exists(const string& key)
	{
		const map<string, string>::iterator findKey = data.find(key);
		if (findKey != data.end())
			return true;
		else return false;
	}
	string get(const string& key)
	{
		const map<string, string>::iterator findKey = data.find(key);
		if (findKey != data.end())
			return findKey->second;
		else
			throw runtime_error("No such record: " + key);
	}
};

class SecureDB : public IDatabase
{
	IDatabase* DB;
	IDatabase* UDB;
	bool accessable = true;
public:
	SecureDB(IDatabase* adb, IDatabase* audb) : DB(adb), UDB(audb)
	{
		secureLogin();
	}
	string getID()
	{
		if (accessable)
			return DB->getID();
		else
			throw runtime_error("Inaccessable due to Authentication");
	}
	bool exists(const string& key)
	{
		if (accessable)
			return DB->exists(key);
		else
			throw runtime_error("Inaccessable due to Authentication");
	}

	string get(const string& key)
	{
		if (accessable)
			return DB->get(key);
		else
			throw runtime_error("Inaccessable due to Authentication");
	}

	void secureLogin()
	{
		string username, password;
		bool userauth = false, passauth = false;
		cout << "Enter username: ";
		cin >> username;
		cout << "Enter password: ";
		cin >> password;
		try
		{
			userauth = UDB->exists(username);
			if (userauth)
			{
				string tempPass = UDB->get(username);
				if (tempPass == password){ passauth = true; }
			}
			if (userauth == false || passauth == false)
			{
				accessable = false;
				throw runtime_error("User name or password was incorrect");
			}
		}

		catch (runtime_error& x)
		{
			cout << x.what() << endl;
		}
	}
};

class CacheDB : public IDatabase
{
	IDatabase* DB;
	string cache[CACHE_SIZE];
public:
	CacheDB(IDatabase* adb) : DB(adb){}
	string getID(){ return DB->getID(); }
	bool exists(const string& key)
	{
	    for (int i = 0; i < CACHE_SIZE; i++)
		{
			if (cache[i] == DB->get(key))
			{
				cout << "exists \"" << cache[i] << "\" from cache\n";
				return true;
			}
		}
		string aval = DB->get(key);
		for (int i = CACHE_SIZE - 1; i > 0; i--)
		{
			cache[i] = cache[i - 1];
		}
		cache[0] = aval;
		return DB->exists(key);
    }
	string get(const string& key)
	{
		for (int i = 0; i < CACHE_SIZE; i++)
		{
			if (cache[i] == DB->get(key))
			{
				cout << "retrieving \"" << cache[i] << "\" from cache\n";
				return cache[i];
			}
		}
		string aval = DB->get(key);
		for (int i = CACHE_SIZE - 1; i > 0; i--)
		{
			cache[i] = cache[i - 1];
		}
		cache[0] = aval;
		return aval;
	}
};
