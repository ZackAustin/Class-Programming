// menu1.cpp: A C-like approach to menu management
#include <iostream>
#include <string>
#include <cstdlib>
using namespace std;

typedef void (*Command)();  // Implicit interface for menu actions

string menuDescriptions[] =
{
    "New", "Open", "Close", "Save", "Print", "Exit"
};

// Two sets of actions for each menu choice
void new1() {
    cout << "Version 1 of New\n";
}
void new2() {
    cout << "Version 2 of New\n";
}

void open1() {
    cout << "Version 1 of Open\n";
}
void open2() {
    cout << "Version 2 of Open\n";
}

void close1() {
    cout << "Version 1 of Close\n";
}
void close2() {
    cout << "Version 2 of Close\n";
}

void save1() {
    cout << "Version 1 of Save\n";
}
void save2() {
    cout << "Version 2 of Save\n";
}

void print1() {
    cout << "Version 1 of Print\n";
}
void print2() {
    cout << "Version 2 of Print\n";
}

void exit1() {
    cout << "Version 1 of Exit\n";
}
void exit2() {
    cout << "Version 2 of Exit\n";
}

// Initial menu configuration
Command commands[] = 
{
    new1, open1, close1, save1, print1, exit1
};

// Second configuration
void reconfigure() {
    commands[0] = new2;
    commands[1] = open2;
    commands[2] = close2;
    commands[3] = save2;
    commands[4] = print2;
    commands[5] = exit2;
}

int getChoice() {
    // Read a line and extract int
    string line;
    getline(cin, line);
    return atoi(line.c_str());
}

void doMenu() {
    // Test initial configuration
    int choice;
    do {
        // Get menu choice
        do {
            cout << "1-New, 2-Open, 3-Close, 4-Save, 5-Print, 6-Exit\n";
        } while ((choice = getChoice()) < 1 || choice > 6);

        // Execute associated command
        commands[choice-1]();
    } while (choice != 6);
}

int main() {
    doMenu();
    reconfigure();
    doMenu();
}