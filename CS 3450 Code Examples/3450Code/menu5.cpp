// menu5.cpp: Uses a Null Object for both commands and receivers.
// To diasllow null pointers, we use references (this was done to
// *require* Null Object, for emphasis). No more if's,
// but also no more setReceiver() or setAction().

// Note: we could make File the NullFile object by providing empty
// bodies, but since this is only a C++ thing, we didn't.

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

class NullFile : public File
{
public:
    void doNew() {}
    void doOpen() {}
    void doClose() {}
    void doSave() {}
    void doPrint() { cout << "Doing the right thing if no Print Command exists\n";}
    void doExit() {}
};

// An explicit interface for menu actions
class Command {
public:
    virtual ~Command(){}
    virtual void execute() = 0;
};

class NullCommand : public Command {
public:
    void execute() {}
};

// An intermediate abstract class to manage File receivers
class FileCommand : public Command {
protected:
    File& receiver;
public:
    FileCommand(File& f) : receiver(f) {}
};

// Two sets of actions for each menu choice
class New : public FileCommand {
public:
    New(File& receiver) : FileCommand(receiver) {}
    void execute() {
        receiver.doNew();
    }
};

class Open : public FileCommand {
public:
    Open(File& receiver) : FileCommand(receiver) {}
    void execute() {
        receiver.doOpen();
    }
};

class Close : public FileCommand {
public:
    Close(File& receiver) : FileCommand(receiver) {}
    void execute() {
        receiver.doClose();
    }
};

class Save : public FileCommand {
public:
    Save(File& receiver) : FileCommand(receiver) {}
    void execute() {
        receiver.doSave();
    }
};

class Print : public FileCommand {
public:
    Print(File& receiver) : FileCommand(receiver) {}
    void execute() {
        receiver.doPrint();
    }
};

class Exit : public FileCommand {
public:
    Exit(File& receiver) : FileCommand(receiver) {}
    void execute() {
        receiver.doExit();
    }
};

class MenuItem {
    Command& action;
    string description;
public:
    MenuItem(string desc, Command& c) : description(desc), action(c) {}
    void select() { action.execute(); }
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
    // Create/configure menu
    Menu menu;
    File1 file1;
    File2 file2;
    NullFile nullFile;
    NullCommand nullCommand;

    New new1(file1);
    MenuItem newItem("New",new1);
    menu.addItem(&newItem);

    Open open2(file2);
    MenuItem openItem("Open", open2);
    menu.addItem(&openItem);

    Close close(nullFile);
    MenuItem closeItem("Close", close);
    menu.addItem(&closeItem);

    Save save1(file1);
    MenuItem saveItem("Save", save1);
    menu.addItem(&saveItem);

    MenuItem printItem("Print", nullCommand);
    menu.addItem(&printItem);

    Exit exit2(file2);
    MenuItem exitItem("Exit", exit2);
    menu.addItem(&exitItem);

    doMenu(menu);
}