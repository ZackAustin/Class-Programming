#include <iostream>
using namespace std;

//
// Table-driven state machine
//
// C style: No objects used except
//	for ease in input and output (cin, cout)
//  and strings.
//

int main()
{
	const int NUM_STATES = 5;
	const int NUM_EVENTS = 6;
	
	enum states { CardWait = 0, PINWait, MainMenu, GiveCash, AcceptDeposit };
	enum events { InCard = 0, TypePin, Withdraw, Deposit, Main, Exit };
	
	int state_table [NUM_STATES][NUM_EVENTS] = {
		{ PINWait, -1, -1, -1, -1, -1 },
		{ -1, MainMenu, -1, -1, -1, CardWait },
		{ -1, -1, GiveCash, AcceptDeposit, -1, CardWait },
		{ -1, -1, -1, -1, MainMenu, CardWait },
		{ -1, -1, -1, -1, MainMenu, CardWait }
	};
	
	string state_msgs[NUM_STATES] = {
		"Please Insert Card",
		"Please Type PIN",
		"Would you like to withdraw or deposit?",
		"Here is $50; more transactions?",
		"Thank you for your money; more transactions?"
	};
	
	string input_msgs[NUM_EVENTS] = {
		"Insert Card",
		"Type PIN",
		"Select Withdraw",
		"Select Deposit",
		"Another Transaction",
		"Exit"
	};
	
	int curr_state = CardWait;
	
	while (1)
	{
		// Display the Current State message
		cout << endl << state_msgs[curr_state] << endl;
		
		// Display Input choices
		cout << "Select one:" << endl;
		for (int i = 0; i < NUM_EVENTS; i++)
		{
			if (state_table[curr_state][i] != -1)
				cout << "\t" << i << ": " << input_msgs[i] << endl;
		}
		
		int input;
		cin >> input;
		
		if (input < 0 || input >= NUM_EVENTS)
		{
			cout << "Illegal input; try again\n";
			continue;
		}
		
		int new_state = state_table[curr_state][input];
		
		// Legal event?
		if (new_state == -1)
		{
			cout << "Sorry, that event can't happen in this state\n";
			continue;
		}
		
		curr_state = new_state;
	}
}

			