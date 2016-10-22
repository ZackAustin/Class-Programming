// menu3b.cpp: An OO approach to menu management
// No change to Menu, minimal change to MenuItem
//
// Same as menu3, except we created global command objects;
// makes the menu configuration code exactly as before.
// Why not use Singletons for them? Because there is no need:
// 	it doesn't hurt to have more, and
// 	they have no data to change
//
#include <cstdlib>
#include <iostream>
#include <string>
#include <vector>
using namespace std;

// An explicit interface for menu actions
class Command {
public:
    virtual ~Command(){}
    virtual void execute() = 0;
};

// Two sets of actions for each menu choice
class New1 : public Command {
public:
    void execute() {
        cout << "Version 1 of New\n";
    }
} new1;

class New2 : public Command {
public:
    void execute() {
        cout << "Version 2 of New\n";
    }
} new2;

class Open1 : public Command {
public:
    void execute() {
        cout << "Version 1 of Open\n";
    }
} open1;

class Open2 : public Command {
public:
    void execute() {
        cout << "Version 2 of Open\n";
    }
} open2;

class Close1 : public Command {
public:
    void execute() {
        cout << "Version 1 of Close\n";
    }
} close1;

class Close2 : public Command {
public:
    void execute() {
        cout << "Version 2 of Close\n";
    }
} close2;

class Save1 : public Command {
public:
    void execute() {
        cout << "Version 1 of Save\n";
    }
} save1;

class Save2 : public Command {
public:
    void execute() {
        cout << "Version 2 of Save\n";
    }
} save2;

class Print1 : public Command {
public:
    void execute() {
        cout << "Version 1 of Print\n";
    }
} print1;

class Print2 : public Command {
public:
    void execute() {
        cout << "Version 2 of Print\n";
    }
} print2;

class Exit1 : public Command {
public:
    void execute() {
        cout << "Version 1 of Exit\n";
    }
} exit1;

class Exit2 : public Command {
public:
    void execute() {
        cout << "Version 2 of Exit\n";
    }
} exit2;

class MenuItem {
    Command* action;
    string description;
public:
    MenuItem(string desc) : description(desc) { action = 0; }
    void select() { if (action) action->execute(); }
    void setAction(Command* c) { action = c; }
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
    Menu menu;
    MenuItem newItem("New");
    menu.addItem(&newItem);
    MenuItem openItem("Open");
    menu.addItem(&openItem);
    MenuItem closeItem("Close");
    menu.addItem(&closeItem);
    MenuItem saveItem("Save");
    menu.addItem(&saveItem);
    MenuItem printItem("Print");
    menu.addItem(&printItem);
    MenuItem exitItem("Exit");
    menu.addItem(&exitItem);

    // Configure menu
    newItem.setAction(&new1);
    openItem.setAction(&open1);
    closeItem.setAction(&close1);
    saveItem.setAction(&save1);
    printItem.setAction(&print1);
    exitItem.setAction(&exit1);
    
    doMenu(menu);

    // Configure menu
    newItem.setAction(&new2);
    openItem.setAction(&open2);
    closeItem.setAction(&close2);
    saveItem.setAction(&save2);
    printItem.setAction(&print2);
    exitItem.setAction(&exit2);
    
    doMenu(menu);
}
