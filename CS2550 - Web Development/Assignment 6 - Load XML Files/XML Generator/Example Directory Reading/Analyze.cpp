// Author:		Zack Austin
// Class:		CS 3370
// Date:		3/30/14
// Program:		Analyze - Data Reduction with C++ Algorithms.

#include <cstdlib>
#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <string>

int analyzeFiles();

using namespace std;

#if defined(_WIN32)
	#define listcmd "dir /b *.dat > datfiles.text 2>nul"
#elif defined(__GNUC__)
	#define listcmd "ls *.dat > datfiles.text 2>/dev/null"
#else
	#error UnSupported Compiler.
#endif

int main()
{
	int success = analyzeFiles();
	if (success)
		return 1;
	return 0;
}

int analyzeFiles()
{
	system(listcmd);
	ifstream datfiles("datfiles.text");

	//Read all parameters from an .ini file like the following at program startup :
	//# Pulse parameters
		//	vt = 100
		//	width = 100
		//	pulse_delta = 15
		//	drop_ratio = 0.75
		//	below_drop_ratio = 4

	cout << "Configuration File: ";
	string configfile = "";
	cin >> configfile;

	//Read Configuration File.
		//All parameters are necessary and none others are allowed. Enforce this.
		//Lines beginning with ‘#’ are comments so ignore them.
		//Blank lines are allowed.

	return 0;
}