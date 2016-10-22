// menu2.cpp: A function callback approach to menu management
#include <iostream>
#include <string>
#include <vector>
#include <cstdlib>
using namespace std;

typedef void (*Command)();  // Implicit interface for menu actions

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

class MenuItem {
    Command action;
    string description;
public:
    MenuItem(string desc, Command act) : action(act), description(desc)	{ }
    void select() { if (action) action(); }
    void setAction(Command c) { action = c; }
};

class Menu {
    vector<MenuItem*> items;
public:
    void addItem(MenuItem* item) { items.push_back(item); }
    void selectItem(int i) { items[i]->select(); }
};

int getChoice() {
    // Read a line and extract int
    string line;
    getline(cin, line);
    return atoi(line.c_str());
}

void doMenu(Menu& menu) {
    // Test initial configuration
    int choice;
    do {
        // Get menu choice
        do {
            cout << "1-New, 2-Open, 3-Close, 4-Save, 5-Print, 6-Exit\n";
        } while ((choice = getChoice()) < 1 || choice > 6);

        // Execute associated command
        menu.selectItem(choice-1);
    } while (choice != 6);
}

int main() {
    // Create menu
	// and configure itmes
    Menu menu;
    MenuItem newItem("New", new1);
    menu.addItem(&newItem);
    MenuItem openItem("Open", open1);
    menu.addItem(&openItem);
    MenuItem closeItem("Close", close1);
    menu.addItem(&closeItem);
    MenuItem saveItem("Save", save1);
    menu.addItem(&saveItem);
    MenuItem printItem("Print", print1);
    menu.addItem(&printItem);
    MenuItem exitItem("Exit", exit1);
    menu.addItem(&exitItem);

    
    doMenu(menu);

    // Configure menu
    newItem.setAction(new2);
    openItem.setAction(open2);
    closeItem.setAction(close2);
    saveItem.setAction(save2);
    printItem.setAction(print2);
    exitItem.setAction(exit2);
    
    doMenu(menu);
}