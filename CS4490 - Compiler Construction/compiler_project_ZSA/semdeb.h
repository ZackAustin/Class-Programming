#pragma once
#include "sas.h"
#include "os.h"
#include <string>
#include <iostream>

struct SADebugger
{
	OS* os;
	SAS* sas;
	SADebugger(OS* _os, SAS* _sas) : os(_os), sas(_sas) {}
	~SADebugger(){}

	friend std::ostream& operator<< (std::ostream& os, const SADebugger* saDebug)
	{
		os << std::endl;
		int osSize = saDebug->os->os.size();
		int sasSize = saDebug->sas->sas.size();
		bool printing = true;
		int osCounter = osSize - 1, sasCounter = sasSize - 1;
		std::string fullPrint = "";
		bool waitForSAS = false;
		bool waitForOS = false;

		if (osCounter < sasCounter)
			waitForSAS = true;

		if (osCounter > sasCounter)
			waitForOS = true;

		while (printing)
		{
			if (waitForSAS && osCounter == sasCounter)
				waitForSAS = false;

			if (waitForOS && sasCounter == osCounter)
				waitForOS = false;

			if (osCounter >= 0 && waitForSAS == false)
			{
				fullPrint += "\t" + saDebug->os->os[osCounter--]->operatorLexem + "\t\t";
			}
			else fullPrint += "\t\t\t";
			if (sasCounter >= 0 && waitForOS == false)
			{
				fullPrint += saDebug->sas->sas[sasCounter--]->getDebug() + "\n";
			}
			else fullPrint += "\n";

			if(osCounter < 0 && sasCounter < 0)
				printing = false;
		}

		os << fullPrint << "   Operator Stack\tSemantic Action Stack\n";
		return os;
	}
};