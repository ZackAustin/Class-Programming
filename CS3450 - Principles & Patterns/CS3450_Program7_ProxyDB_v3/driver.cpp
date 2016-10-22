//Driver.cpp

//Name:			Zack Austin;
//Date:			11/30/13;
//Class:		CS 3450;
//Assignment:	Program 7 - Proxy Database;
//Purpose:		Apply Proxy Pattern to DB via CacheDB & SecureDB;

#include "ProxyDB.h"

void test(IDatabase* db)
{
	try
	{
		cout << db->get("one") << endl;
		cout << db->get("two") << endl;
		cout << db->get("two") << endl;
		cout << db->get("three") << endl;
		cout << db->get("four") << endl;
		cout << db->get("four") << endl;
		cout << db->get("five") << endl;
		cout << db->get("six") << endl;
		cout << db->get("one") << endl;
		cout << db->get("seven") << endl;
	}
	catch (runtime_error& x)
	{
		cout << x.what() << endl;
	}
	cout << endl;
}

int main()
{
	//driver given
	Database db("db.dat");
	test(&db);

	Database userdb("userdb.dat");
	SecureDB sdb(&db, &userdb);
	test(&sdb);

	CacheDB cdb(&sdb);
	test(&cdb);

	try
	{
		Database db2("noname.dat");
	}
	catch (runtime_error& x)
	{
		cout << x.what() << endl;
	}

	return 0;
}
