#include <iostream>
#include <vector>
#include <map>
#include <string>
#include <iterator>
#include <fstream>
#include <sstream>
#include "CommandDB.h"

using namespace std;

Command* readBatchFile(ifstream &batchFile, vector<Database*> &DBList, vector<Command*> &commandObject);
bool aCommand(string buf);
bool aMacro(string buf);
MacroCommand* newTransaction(MacroCommand* &newMacro, ifstream &batchFile, vector<Command*> &commandObject, vector<Database*> &DBList);

int main()
{
	//programmer information
	cout << "Name:		Zack Austin\n";
	cout << "Date:		10/27/13\n";
	cout << "Class:		CS 3450\n";
	cout << "Assignment:	Program 4 - Command Database\n";
	cout << "Purpose:	Learn how to apply the Command Pattern on Database Simulation.\n\n";

	vector<Database*> DBList; //hold all DBs from file ids.
	vector<Command*> commandsObject;
	//1.read sample commands into sequence of command objects.
	ifstream sampleFile;
	sampleFile.open("sampleFile.txt", ios::binary);
	if (!sampleFile.is_open() || !sampleFile)  // Did the open work?
	{
		cout << "Can't open file for input!\n";
		return 1;
	}
	//reads the batch file and sets up the command object and databases,
	//otherwise specifies error (line number of fail).

	//tests
	while (!sampleFile.eof())
	{
		commandsObject.push_back(readBatchFile(sampleFile, DBList, commandsObject));
	}

	//run commands object.
	for (unsigned int i = 0; i < commandsObject.size(); i++)
	{
		commandsObject[i]->execute();
	}

	/*call backup on all DB elements of DBList.*/
	for (std::vector<Database*>::iterator it = DBList.begin(); it != DBList.end(); ++it)
	{
		(*it)->backup(cout);
	}

	//call undo iteratively backwards on commandsObject.
	for (int i = commandsObject.size() - 1; i >= 0; i--)
	{
		int count = i;
		bool clear = false;
		string DBID = "";
		cout << "Undid " << commandsObject[i]->getName() << endl;
		DBID = commandsObject.back()->getID();

		//remove dynamic mem
		delete commandsObject[i];
		commandsObject.pop_back();

		for (int k = 0; k < DBList.size(); k++)
		{
			DBList[k]->clearData();
		}
		//run commands object.
		if (count > 0)
		{
			for (unsigned int j = 0; j < commandsObject.size(); j++)
			{
				commandsObject[j]->execute();
			}
			/*call backup on all DB elements of DBList.*/
			for (std::vector<Database*>::iterator it = DBList.begin(); it != DBList.end(); ++it)
			{
				if ((*it)->getID() == DBID)
					(*it)->backup(cout);
			}
		}
	}

	/*call backup on all DB elements of DBList.*/
	for (std::vector<Database*>::iterator it = DBList.begin(); it != DBList.end(); ++it)
	{
		(*it)->backup(cout);
	}

	return 0;
}

Command* readBatchFile(ifstream &batchFile, vector<Database*> &DBList, vector<Command*> &commandObject)
{
	string aLine, buf, valueTokens, tempCmd, tempID;
	int macroNest = 0, success = -1, DBNumber = -1;
	while (!batchFile.eof())
	{
		// a line at a time!
		getline(batchFile, aLine, '\n');
		stringstream ss(aLine);
		Database* tempDB;
		//3 case:
		//<command> <db ID> <key> [<value>] | B | E
		//begin trans macro, B or end trans macro, E
		ss >> buf;
		if (aMacro(buf)) //ignore macros for now
		{
			/*write B into command object.*/
			if (buf == "B")
			{
				MacroCommand* newMacro = new MacroCommand(&Database::macro, cout, "Beginning a Macro\n");
				newMacro = newTransaction(newMacro, batchFile, commandObject, DBList);
				commandObject.push_back(newMacro);
				if (success == 1){}
					/*return 1;	*/	
			}
		}
		//command line
		else if (aCommand(buf))
		{
			//we already read command, throw into command object.
			tempCmd = buf;
			//read <db ID> next and process it.
			ss >> buf; // buf now DB ID.
			tempID = buf;
			bool dbExists = false;
			//check if DB exists for ID.
			for (unsigned int i = 0; i < DBList.size(); i++)
			{
				if (tempID == DBList[i]->getID())
				{
					DBNumber = i;
					dbExists = true;
					//db we're working with atm.
					tempDB = DBList[i];
				}
			}
			//if it didnt exist, create new DB with ID.
			if (dbExists == false)
			{
				tempDB = new Database(buf);
				DBList.push_back(tempDB);
				DBNumber = DBList.size() - 1;
			}
			//read <key> next and process it.
			ss >> buf; // buf now key.
			string tempKey = buf;

			//this does [<values>] for map in DB value with mult space.
			valueTokens = "";
			while (ss >> buf)
				valueTokens = valueTokens + " " + buf;
			//write to command object here.
			if (tempCmd == "A")
			{
				AddCommand *anAdd = new AddCommand(DBList[DBNumber], &Database::add, tempKey, valueTokens);
				return anAdd;
			}
			else if (tempCmd == "R")
			{
				RemoveCommand *aRem = new RemoveCommand(DBList[DBNumber], &Database::remove, tempKey, valueTokens);
				return aRem;
			}
			else if (tempCmd == "U")
			{
				UpdateCommand *anUpd = new UpdateCommand(DBList[DBNumber], &Database::update, tempKey, valueTokens);
				return anUpd;
			}
			else
			{
				cout << "File Syntax Error";
				/*return 1;*/
			}
		}
		else
		{
			cout << "File Syntax Error";
			/*return 1;*/
		}
	}
	return 0;
}

bool aCommand(string buf)
{
	if (buf == "A" || buf == "U" || buf == "R")
		return true;
	else return false;
}

bool aMacro(string buf)
{
	if (buf == "B" || buf == "E")
		return true;
	else return false;
}

MacroCommand* newTransaction(MacroCommand* &newMacro, ifstream &batchFile, vector<Command*> &commandObject, vector<Database*> &DBList)
{
	string aLine, buf, valueTokens, tempCmd, tempID;
	bool endTransaction = false;
	int DBNumber = -1;
	while (!batchFile.eof() && endTransaction != true)
	{
		// a line at a time!
		getline(batchFile, aLine, '\n');
		stringstream ss(aLine);
		Database* tempDB;
		//3 case:
		//<command> <db ID> <key> [<value>] | B | E
		//begin trans macro, B or end trans macro, E
		ss >> buf;
		tempCmd = buf;
		if (aMacro(buf))
		{
			if (tempCmd == "B")
			{
				/*MacroCommand* newMacro = new MacroCommand(&Database::macro, cout, "Beginning a Macro");
				newMacro = newTransaction(newMacro, batchFile, commandObject, DBList);
				commandObject.push_back(newMacro);*/

				MacroCommand* nestedMacro = new MacroCommand(&Database::macro, cout, "Beginning a Macro\n");
				newMacro->add(nestedMacro);
				newTransaction(nestedMacro, batchFile, commandObject, DBList);
			}

			else if (tempCmd == "E")
			{
				endTransaction = true;
				return newMacro;
				commandObject.push_back(newMacro);
			}
		}
		else if (aCommand(buf))
		{
			//we already read command, throw into command object.
			tempCmd = buf;
			//read <db ID> next and process it.
			ss >> buf; // buf now DB ID.
			tempID = buf;
			bool dbExists = false;
			//check if DB exists for ID.
			for (unsigned int i = 0; i < DBList.size(); i++)
			{
				if (tempID == DBList[i]->getID())
				{
					DBNumber = i;
					dbExists = true;
					//db we're working with atm.
					tempDB = DBList[i];
				}
			}
			//if it didnt exist, create new DB with ID.
			if (dbExists == false)
			{
				tempDB = new Database(buf);
				DBList.push_back(tempDB);
				DBNumber = DBList.size() - 1;
			}
			//read <key> next and process it.
			ss >> buf; // buf now key.
			string tempKey = buf;

			//this does [<values>] for map in DB value with mult space.
			valueTokens = "";
			while (ss >> buf)
				valueTokens = valueTokens + " " + buf;
			//write to command object here.
			if (tempCmd == "A")
			{
				AddCommand *anAdd = new AddCommand(DBList[DBNumber], &Database::add, tempKey, valueTokens);
				newMacro->add(anAdd);
			}
			else if (tempCmd == "R")
			{
				RemoveCommand *anRem = new RemoveCommand(DBList[DBNumber], &Database::remove, tempKey, valueTokens);
				newMacro->add(anRem);
			}
			else if (tempCmd == "U")
			{
				UpdateCommand *aUpd = new UpdateCommand(DBList[DBNumber], &Database::update, tempKey, valueTokens);
				newMacro->add(aUpd);
			}
			else
			{
				cout << "File Syntax Error\n";
			}
		}
	}
	return 0;
}