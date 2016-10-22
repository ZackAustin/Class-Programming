#include <iostream>
#include "DuckStates.h"
using namespace std;

int main()
{
	// Got a flock of ducks!
	Duck* ducks[5];
	for (int i = 0; i <5; i++)
		ducks[i] = new Duck(i+1);
	
	int num, event;
	while (true)
	{
		cout << "Pick a duck, any duck! (1-5)  ";
		cin >> num;
		num--;		//UI is 1-based
		if (num < 0 || num >= 5){
			cout << "Ducks are done\n";
			break;
		}
		
		cout << "Do what? (0 - Shoot duck, 1 - Cook duck, 2 - Eat duck) ";
		cin >> event;
		cout << endl;
		if (event >= 0 && event <= 3) {
			Event e = event == 0 ? Shoot : event == 1 ? Cook : Eat ;
			ducks[num]->stuff_happens(e);
		} else {
			cout << "Oops, you can't do that!\n";
		}
		cout << endl;
		for (int i = 0; i < 5; i++)
			ducks[i]->report();
	}
}