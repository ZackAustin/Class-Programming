#include <iostream>
#include <string>

class cmdNode
{
public:
	std::string data;
	cmdNode* next;
	
	cmdNode(std::string d) : data(d)
	{
		next = nullptr;
	}
};

void printList(cmdNode*);
void reverseList(cmdNode*, cmdNode*&);

int main(int argc, const char* argv[])
{
	cmdNode* tmp = nullptr;
	cmdNode* head = nullptr;
	std::cout << "argc: " << argc << std::endl;
	for (int i = 1; i < argc; ++i)
	{
		std::cout << i << std::endl;
		tmp = new cmdNode(argv[i]);
		if (i == 1)
			head = tmp;
		else 
		{
			cmdNode* tmpHead = head;
			if (tmpHead != nullptr)
			{
				while (tmpHead->next != nullptr)
				{
					tmpHead = tmpHead->next;
				}
				tmpHead->next = tmp;
			}
		}
	}
	printList(head);
	cmdNode* newList = nullptr;
	reverseList(head, newList);
	printList(newList);
}

void printList(cmdNode* head)
{
	std::cout << "printing list: " << std::endl;
	if (head != nullptr)
	{
		while (head->next != nullptr)
		{
			std::cout << head->data << std::endl;
			head = head->next;
		}
		std::cout << head->data << std::endl;
	}
}

void reverseList(cmdNode* head, cmdNode* &newList)
{
	while (head != nullptr)
	{
		cmdNode* tmp = head;
		head = head->next;
		tmp->next = newList;
		newList = tmp;
	}
}