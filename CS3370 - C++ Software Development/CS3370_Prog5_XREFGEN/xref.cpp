// Author:		Zack Austin
// Class:		CS 3370
// Date:		4/13/14
// Program:		Cross Reference Generator.

#include <cstdlib>
#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <string>
#include <map>
#include <functional>
#include <iomanip>

using namespace std;

const int wordWrapper = 9;

struct xrefComparer
{
	bool operator()(const string& s1, const string& s2)
	{
		int tmp = _stricmp(s1.c_str(), s2.c_str()); //ignoring case
		if (tmp <= 0) // string1 less than string2
		{
			if (tmp == 0)	//not ignoring case
			{
				if (s1 < s2)
					return true;
				else return false;
			}
			else return true;
		}
		else return false;
	}
};

struct tokenData
{
	int linenum;
	int linecount;
	friend std::ostream& operator<<(std::ostream& os, const tokenData &definedData)
	{
		os << definedData.linenum << ":" << definedData.linecount;
		return os;
	}
};

int main(int argc, char* argv[])
{
	map<string, vector<tokenData>, xrefComparer> m;
	int maxWordSize = 0, lnNum = 1, wordCount = 0;
	fstream* fileInput;
	string fileName = "", lineInput = "";
	if (argc > 1)
		fileInput = new fstream(argv[1], ifstream::in);
	else
	{
		cout << "Enter Filename for XREF Generator: ";
		cin >> fileName;
		fileInput = new fstream(fileName, ifstream::in);
	}

	while (*fileInput)
	{
		char tmpC = fileInput->get();
		string tmp = "";
		if (tmpC == '\n')
		{
			lnNum++;
			tmpC = ' ';
		}
		while (isalpha(tmpC) || tmpC == '\'')
		{
			if (isalpha(tmpC) || tmpC == '\'')
				tmp += tmpC;
			tmpC = fileInput->get();
		}

		if (tmp != "")
		{
			if (tmp.size() > maxWordSize)
				maxWordSize = tmp.size();
			auto it = m.find(tmp);
			if (it == m.end())
			{
				vector<tokenData> tmpData;
				tmpData.push_back({ lnNum, 1 });
				m[tmp] = tmpData;
			}
			else
			{
				bool changed = false;
				for (size_t i = 0; i < m[tmp].size(); i++)
				{
					if (m[tmp][i].linenum == lnNum)
					{
						m[tmp][i].linecount++;
						changed = true;
					}
				}
				if (!changed)
					m[tmp].push_back({ lnNum, 1 });
			}
		}
		if (tmpC == '\n')
			lnNum++;
	}

	// Print the map: 
	cout << endl;
	for (const auto& elem : m)
	{
		int countTheWrappin = 0;
		cout << setw(maxWordSize + 1) << left << elem.first << ": ";
		for (size_t i = 0; i < elem.second.size(); i++)
		{
			wordCount += elem.second[i].linecount;;
			cout << elem.second[i];
			countTheWrappin++;
			if (i != elem.second.size() - 1)
				cout << ", ";
			if (countTheWrappin == wordWrapper)
			{
				if (i != elem.second.size() - 1)
					cout << endl << setw(maxWordSize + 1) << left << " " << ": ";
				countTheWrappin = 0;
			}
		}
		cout << endl;
	}
	//cout << "\nWord Count: " << wordCount << endl;
	delete fileInput;
	return 0;
}