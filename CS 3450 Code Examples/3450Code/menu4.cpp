// menu4.cpp: Adds receivers (File1 and File2 classes)
// Note changes to concrete commands.

#include <cstdlib>
#include <iostream>
#include <string>
#include <vector>
using namespace std;

// An interface for File objects
class File {
public:
    virtual ~File(){}
    virtual void doNew() = 0;
    virtual void doOpen() = 0;
    virtual void doClose() = 0;
    virtual void doSave() = 0;
    virtual void doPrint() = 0;
    virtual void doExit() = 0;
};

// Concrete Receivers
class File1 : public File {
public:
    void doNew() { cout << "Version 1 of New\n"; }
    void doOpen() { cout << "Version 1 of Open\n"; }
    void doClose() { cout << "Version 1 of Close\n"; }
    void doSave() { cout << "Version 1 of Save\n"; }
    void doPrint() { cout << "Version 1 of Print\n"; }
    void doExit() { cout << "Version 1 of Exit\n"; }
};

class File2 : public File {
public:
    void doNew() { cout << "Version 2 of New\n"; }
    void doOpen() { cout << "Version 2 of Open\n"; }
    void doClose() { cout << "Version 2 of Close\n"; }
    void doSave() { cout << "Version 2 of Save\n"; }
    void doPrint() { cout << "Version 2 of Print\n"; }
    void doExit() { cout << "Version 2 of Exit\n"; }
};

// An explicit interface for menu actions
class Command {
public:
    virtual ~Command(){}
    virtual void execute() = 0;
};

// An intermediate abstract class to manage File receivers
class FileCommand : public Command {
protected:
    File* receiver;
public:
    FileCommand() { receiver = 0; }
    void setReceiver(File* r) { receiver = r; }
};

// Two sets of actions for each menu choice
class New : public FileCommand {
public:
    void execute() {
        if (receiver)
            receiver->doNew();
    }
};

class Open : public FileCommand {
public:
    void execute() {
        if (receiver)
            receiver->doOpen();
    }
};

class Close : public FileCommand {
public:
    void execute() {
        if (receiver)
            receiver->doClose();
    }
};

class Save : public FileCommand {
public:
    void execute() {
        if (receiver)
            receiver->doSave();
    }
};

class Print : public FileCommand {
public:
    void execute() {
        if (receiver)
            receiver->doPrint();
    }
};

class Exit : public FileCommand {
public:
    void execute() {
        if (receiver)
            receiver->doExit();
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
    File1 file1;

    New new1;
    new1.setReceiver(&file1);
    newItem.setAction(&new1);

    Open open1;
    open1.setReceiver(&file1);
    openItem.setAction(&open1);
    
    Close close1;
    close1.setReceiver(&file1);
    closeItem.setAction(&close1);

    Save save1;
    save1.setReceiver(&file1);
    saveItem.setAction(&save1);
    
    Print print1;
    print1.setReceiver(&file1);
    printItem.setAction(&print1);
    
    Exit exit1;
    exit1.setReceiver(&file1);
    exitItem.setAction(&exit1);
    
    doMenu(menu);

    // Reconfigure menu
    File2 file2;
    new1.setReceiver(&file2);
    open1.setReceiver(&file2);
    close1.setReceiver(&file2);
    save1.setReceiver(&file2);
    print1.setReceiver(&file2);
    exit1.setReceiver(&file2);

    doMenu(menu);
}
