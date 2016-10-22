// menu3.cpp: An OO approach to menu management
// No change to Menu, minimal change to MenuItem
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
};

class New2 : public Command {
public:
    void execute() {
        cout << "Version 2 of New\n";
    }
};

class Open1 : public Command {
public:
    void execute() {
        cout << "Version 1 of Open\n";
    }
};

class Open2 : public Command {
public:
    void execute() {
        cout << "Version 2 of Open\n";
    }
};

class Close1 : public Command {
public:
    void execute() {
        cout << "Version 1 of Close\n";
    }
};

class Close2 : public Command {
public:
    void execute() {
        cout << "Version 2 of Close\n";
    }
};

class Save1 : public Command {
public:
    void execute() {
        cout << "Version 1 of Save\n";
    }
};

class Save2 : public Command {
public:
    void execute() {
        cout << "Version 2 of Save\n";
    }
};

class Print1 : public Command {
public:
    void execute() {
        cout << "Version 1 of Print\n";
    }
};

class Print2 : public Command {
public:
    void execute() {
        cout << "Version 2 of Print\n";
    }
};

class Exit1 : public Command {
public:
    void execute() {
        cout << "Version 1 of Exit\n";
    }
};

class Exit2 : public Command {
public:
    void execute() {
        cout << "Version 2 of Exit\n";
    }
};

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
    New1 new1;
    newItem.setAction(&new1);
    Open1 open1;
    openItem.setAction(&open1);
    Close1 close1;
    closeItem.setAction(&close1);
    Save1 save1;
    saveItem.setAction(&save1);
    Print1 print1;
    printItem.setAction(&print1);
    Exit1 exit1;
    exitItem.setAction(&exit1);
    
    doMenu(menu);

    // Configure menu
    New2 new2;
    newItem.setAction(&new2);
    Open2 open2;
    openItem.setAction(&open2);
    Close2 close2;
    closeItem.setAction(&close2);
    Save2 save2;
    saveItem.setAction(&save2);
    Print2 print2;
    printItem.setAction(&print2);
    Exit2 exit2;
    exitItem.setAction(&exit2);
    
    doMenu(menu);
}
