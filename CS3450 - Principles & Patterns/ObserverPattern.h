#include <stdio.h>
#include <string>
#include <iostream>
#include <vector>
#include <fstream>

using namespace std;

template <class T>
class Observer
{
public:
	Observer() {}
	virtual ~Observer() {}
	virtual void update(T *subject) = 0;
};

template <class T>
class Subject
{
public:
	Subject() {}
	virtual ~Subject() {}
	void registerObserver(Observer<T> &observer)
	{
		observers.push_back(&observer);
	}

	void removeObserver(Observer<T> &observer)
	{
		for (unsigned int i = 0; i < observers.size(); i++)
			if (observers[i] == &observer)
				observers.erase(observers.begin() + i);
	}

	void notifyObservers()
	{
		std::vector<Observer<T> *>::iterator it;
		for (it = observers.begin(); it != observers.end(); it++)
			(*it)->update(static_cast<T *>(this));
	}
private:
	std::vector<Observer<T> *> observers;
};

class LocalStock : public Subject<LocalStock>
{
public:
	LocalStock() {}
	~LocalStock() {  }
	void stockChanged(){notifyObservers();}
	//getters and setters...
	vector<double> getPERatio() {return _PERatio;}
	void setPERatio(double val) { _PERatio.push_back(val); }
	vector<double> get_52WeekLow() { return _52WeekLow; }
	void set_52WeekLow(double val) { _52WeekLow.push_back(val); }
	vector<double> get_52WeekHigh() { return _52WeekHigh; }
	void set_52WeekHigh(double val) { _52WeekHigh.push_back(val); }
	vector<double> get_YTDPercentChange() { return _YTDPercentChange; }
	void set_YTDPercentChange(double val) { _YTDPercentChange.push_back(val); }
	vector<double> get_percentChange() { return _percentChange; }
	void set_percentChange(double val) { _percentChange.push_back(val); }
	vector<double> get_dollarChange() { return _dollarChange; }
	void set_dollarChange(double val) { _dollarChange.push_back(val); }
	vector<double> get_currentPrice() { return _currentPrice; }
	void set_currentPrice(double val) { _currentPrice.push_back(val); }
	vector<string> get_tickerSymbol() { return _tickerSymbol; }
	void set_tickerSymbol(string val) { _tickerSymbol.push_back(val); }
	vector<string> get_companyName() { return _companyName; }
	void set_companyName(string val) { _companyName.push_back(val); }
	vector<string> get_date() { return _date; }
	void set_date(string val) { _date.push_back(val); }
private:
	vector<string> _date;
	vector<string> _companyName;
	vector<string> _tickerSymbol;
	vector<double> _currentPrice;
	vector<double> _dollarChange;
	vector<double> _percentChange;
	vector<double> _YTDPercentChange;
	vector<double> _52WeekHigh;
	vector<double> _52WeekLow;
	vector<double> _PERatio;
};

//	1.	A report that displays the average of all local stock prices of each snapshot,
//		along with the time the snapshot was taken.
class AverageReport : public Observer<LocalStock>
{
public:
	AverageReport() {}
	~AverageReport() {}
	//Update with average and date for snapshot.
	void update(LocalStock *subject)
	{
		double tempStockAvg = 0;
		this->stockPrice = subject->get_currentPrice();
		this->date = subject->get_date();

			for (unsigned int i = 0; i < stockPrice.size(); i++)
			{
				tempStockAvg = tempStockAvg + stockPrice[i];
			}
			tempStockAvg = tempStockAvg / (stockPrice.size());
			average.push_back(tempStockAvg);
		display();
	}

	int display()
	{
		ofstream fout("Average.dat", ios::app);  // Average.dat is created.
		if (!fout)                // did the open work?
		{
			cerr << "Can't open file for output!\n";
			return 1;
		}
		fout << date[0] << ", Average price: " << average[0] << "\n";
		fout.close();
		return 0;
	}
private:
	//only the stuff the observer wants to track.
	vector<string> date;
	vector<double> stockPrice;
	vector<double> average;
};

//	2.	A report that displays all companies that have had a price change of 10 % or more.
//		List the ticker symbol, the price and the percentage change.
class Change10Report : public Observer<LocalStock>
{
public:
	Change10Report() {}
	~Change10Report() {}
	//Update with companies with percent change of 10 difference for snapshot.
	void update(LocalStock *subject)
	{
		this->date = subject->get_date();

		for (unsigned int i = 0; i < subject->get_percentChange().size(); i++)
		{
			if (subject->get_percentChange()[i] > 10 || subject->get_percentChange()[i] < -10)
			{
				tickerSymbol.push_back(subject->get_tickerSymbol()[i]);
				stockPrice.push_back(subject->get_currentPrice()[i]);
				percentChange.push_back(subject->get_percentChange()[i]);
			}
		}
		display();
	}

	int display()
	{
		ofstream fout("Change10.dat", ios::app);  // Change10.dat is created.
		if (!fout)                // did the open work?
		{
			cerr << "Can't open file for output!\n";
			return 1;
		}
		fout << "\n" << date[0] << ":\n";
		if (percentChange.size() > 0)
		{
			for (unsigned int i = 0; i < percentChange.size(); i++)
				fout << tickerSymbol[i] << " " << stockPrice[i] << " " << percentChange[i] << "\n";
		}
		fout.close();
		return 0;
	}
private:
	//only the stuff the observer wants to track.
	vector<string> date;
	vector<string> tickerSymbol;
	vector<double> stockPrice;
	vector<double> percentChange;
};

//	3.	A report that displays all fields for the following companies
//		(listed here by ticker symbol) : ALL, BA, BC, GBEL, KFT, MCD, TR, WAG
class SelectionReport : public Observer<LocalStock>
{
public:
	SelectionReport() {}
	~SelectionReport() {}
	//Update with companies with percent change of 10 difference for snapshot.
	void update(LocalStock *subject)
	{
		this->date = subject->get_date();

		for (unsigned int i = 0; i < subject->get_percentChange().size(); i++)
		{
			if (subject->get_tickerSymbol()[i] == "ALL" ||
				subject->get_tickerSymbol()[i] == "BA" ||
				subject->get_tickerSymbol()[i] == "BC" ||
				subject->get_tickerSymbol()[i] == "GBEL" ||
				subject->get_tickerSymbol()[i] == "KFT" ||
				subject->get_tickerSymbol()[i] == "MCD" ||
				subject->get_tickerSymbol()[i] == "TR" ||
				subject->get_tickerSymbol()[i] == "WAG")
			{
				_companyName.push_back(subject->get_companyName()[i]);
				_tickerSymbol.push_back(subject->get_tickerSymbol()[i]);
				_currentPrice.push_back(subject->get_currentPrice()[i]);
				_dollarChange.push_back(subject->get_dollarChange()[i]);
				_percentChange.push_back(subject->get_percentChange()[i]);
				_YTDPercentChange.push_back(subject->get_YTDPercentChange()[i]);
				_52WeekHigh.push_back(subject->get_52WeekHigh()[i]);
				_52WeekLow.push_back(subject->get_52WeekLow()[i]);
				_PERatio.push_back(subject->getPERatio()[i]);
			}
		}
		display();
	}

	int display()
	{
		ofstream fout("Selections.dat", ios::app);  // Selections.dat is created.
		if (!fout)                // did the open work?
		{
			cerr << "Can't open file for output!\n";
			return 1;
		}
		fout << "\n" << date[0] << ":\n";
		if (_companyName.size() > 0)
		{
			for (unsigned int i = 0; i < _companyName.size(); i++)
				fout << _companyName[i] << " " << _tickerSymbol[i] << " " << _currentPrice[i]
				<< " " << _dollarChange[i] << " " << _percentChange[i] << " " << _YTDPercentChange[i]
				<< " " << _52WeekHigh[i] << " " << _52WeekLow[i] << " " << _PERatio[i] << "\n";
		}
		fout.close();
		return 0;
	}
private:
	vector<string> date;
	vector<string> _companyName;
	vector<string> _tickerSymbol;
	vector<double> _currentPrice;
	vector<double> _dollarChange;
	vector<double> _percentChange;
	vector<double> _YTDPercentChange;
	vector<double> _52WeekHigh;
	vector<double> _52WeekLow;
	vector<double> _PERatio;
};

class KeepRunning 
{
public:
	~KeepRunning()
	{
		std::cout << "\nEnd of Program 2. Check those files!";
		std::cin.get();
	}
};