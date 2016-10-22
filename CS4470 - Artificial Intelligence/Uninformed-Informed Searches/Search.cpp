//	Author:		Zack Austin
//	Class:		CS4470 - AI
//	Assign:		Program1-2: Uninformed/Informed Searching
//  Date:		9/17/14

#include <cstdlib>
#include <string>
#include <map>
#include <iomanip>
#include <iostream>
#include <fstream>
#include <algorithm>
#include <unordered_map>
#include <functional>
#include <chrono>
#include <vector>
#include <queue>
#include "Heuristic.h"

using namespace std;
using namespace std::chrono;

pNode setupPuzzle(int argc, char*argv []);
void breadthFirstSearch(pNode& start, pNode& end, string searchType);
void depthFirstSearch(pNode& start, pNode& end, string searchType);
bool depthLimitedSearch(pNode& start, pNode& end, int depthLimit, string searchType, bool ID, chrono::system_clock::time_point starterTime);
void iterativeDeepeningSearch(pNode& start, pNode& end, string searchType);
void biDirectionalSearch(pNode& start, pNode& end, string searchType);
void greedySearch(pNode& start, pNode& end, string searchType);
void AStarSearchMisplacedTiles(pNode& start, pNode& end, string searchType);
void AStarSearchHammingManhattan(pNode& start, pNode& end, string searchType);
void puzzleDisplay(string printPuz);
void displaySearchOutput(string searchType, long long timeTaken, pNode& start, pNode& end);

int main(int argc, char* argv [])
{
	//Grab an 8-puzzle input file.
	pNode initPuzzle = setupPuzzle(argc, argv);
	pNode endPuzzle("123456780", nullptr, "none", END_BLANK_POS, 0);

	//Uninformed Searches

	//Breadth-First Search
	breadthFirstSearch(initPuzzle, endPuzzle, "Breadth-First Search");

	//Depth-First Search
	depthFirstSearch(initPuzzle, endPuzzle, "Depth-First Search");

	//Depth-Limited Search
	depthLimitedSearch(initPuzzle, endPuzzle, 100, "Depth-Limited Search", false, chrono::system_clock::time_point{});

	//Iterative-Deepening Search
	iterativeDeepeningSearch(initPuzzle, endPuzzle, "Iterative-Deepening Search");

	//Bi-Directional Search
	biDirectionalSearch(initPuzzle, endPuzzle, "Bi-Directional Search");

	//Informed Searches

	//Greedy Search
	greedySearch(initPuzzle, endPuzzle, "Greedy Search - Misplaced Tiles");

	//A* Search - Misplaced Tiles
	AStarSearchMisplacedTiles(initPuzzle, endPuzzle, "A* Search - Misplaced Tiles");

	//A* Search - Misplaced Tiles + Manhattan
	AStarSearchHammingManhattan(initPuzzle, endPuzzle, "A* Search - Misplaced Tiles + Manhattan");

	return 0;
}

pNode setupPuzzle(int argc, char*argv [])
{
	string initArr = "";
	int initCnt = 0, blockPos = -1;
	fstream fileInput;
	string fileName = "";
	if (argc > 1)
		fileInput.open(argv[1], ifstream::in);
	else
	{
		cout << "Enter Filename for 8-puzzle: ";
		cin >> fileName;
		fileInput.open(fileName, ifstream::in);
	}
	while (fileInput)
	{
		char tmpC = fileInput.get();
		if (initCnt <= PUZZLE_SIZE)
		{
			if (isdigit(tmpC))
			{
				initArr = initArr + tmpC;
				initCnt++;
			}
			else if (tmpC == '_')
			{
				blockPos = initCnt;
				initArr = initArr + '0';
			}
		}
	}
	fileInput.close();
	return pNode{ initArr, nullptr, "", blockPos, 0 };
}

void breadthFirstSearch(pNode& start, pNode& end, string searchType)
{
	bool success = false;
	//time it.
	auto startTime = high_resolution_clock::now();

	unordered_map<string, pNode*> visited; //closedset
	queue<pNode*> exist; //openset
	vector<pNode*> mem;
	auto starter = new pNode(start.state, start.parent, start.action, start.blankPosition, start.parentCount);
	exist.push(starter);
	mem.push_back(starter);
	string key = "";
	pNode* tmp = nullptr;

	while (!exist.empty())
	{
		tmp = exist.front();
		exist.pop();

		if (tmp->state == end.state)
		{
			success = true;
			auto endTime = high_resolution_clock::now();
			long long timeElapsed = duration_cast<std::chrono::milliseconds>(endTime - startTime).count();
			displaySearchOutput(searchType, timeElapsed, start, *tmp); //print out.
			visited.clear();
			swap(exist, queue<pNode*> {});
		}
		else
		{
			pNode::expandedNode++;
			//for each next state accessible from here, check if it's visited (and ignore it), else stick it in the openset and record parent.
			if (tmp->blankPosition > 2)//MOVE UP
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition - 3]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					exist.push(new pNode(key, tmp, "UP", tmp->blankPosition - 3, tmp->parentCount + 1));
					visited[key] = exist.back();
					mem.push_back(exist.back());
				}
			}
			if (tmp->blankPosition != 2 && tmp->blankPosition != 5 && tmp->blankPosition != 8) //MOVE RIGHT
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition + 1]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					exist.push(new pNode(key, tmp, "RIGHT", tmp->blankPosition + 1, tmp->parentCount + 1));
					visited[key] = exist.back();
					mem.push_back(exist.back());
				}
			}
			if (tmp->blankPosition < 6) //MOVE DOWN
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition + 3]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					exist.push(new pNode(key, tmp, "DOWN", tmp->blankPosition + 3, tmp->parentCount + 1));
					visited[key] = exist.back();
					mem.push_back(exist.back());
				}
			}

			if (tmp->blankPosition != 0 && tmp->blankPosition != 3 && tmp->blankPosition != 6) //MOVE LEFT
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition - 1]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					exist.push(new pNode(key, tmp, "LEFT", tmp->blankPosition - 1, tmp->parentCount + 1));
					visited[key] = exist.back();
					mem.push_back(exist.back());
				}
			}
		}
	}
	if (success == false)
	{
		auto endTime = high_resolution_clock::now();
		long long timeElapsed = duration_cast<std::chrono::milliseconds>(endTime - startTime).count();
		cout << "\nUnsolvable - " << searchType << endl;
		cout << "Time: " << timeElapsed << "ms" << endl;
		cout << "Expanded Nodes: " << pNode::expandedNode << endl;
	}
	pNode::expandedNode = 0;
	for (size_t i = 0; i < mem.size(); i++)
		delete mem[i];
}

void depthFirstSearch(pNode& start, pNode& end, string searchType)
{
	bool success = false;
	//time it.
	auto startTime = high_resolution_clock::now();
	int nodeCount = 0;
	unordered_map<string, pNode*> visited; //closedset
	vector<pNode*> exist; //openset
	vector<pNode*> mem;
	pNode* starter = new pNode(start.state, start.parent, start.action, start.blankPosition, start.parentCount);
	exist.push_back(starter);
	mem.push_back(starter);
	auto t1 = high_resolution_clock::now();
	string key = "";
	pNode* tmp = nullptr;

	while (!exist.empty())
	{
		tmp = exist.back();
		exist.pop_back();

		if (tmp->state == end.state)
		{
			chrono::system_clock::time_point endTime = high_resolution_clock::now();
			long long timeElapsed = duration_cast<std::chrono::milliseconds>(endTime - startTime).count();
			displaySearchOutput(searchType, timeElapsed, start, *tmp); //print out.
			exist.clear();
			visited.clear();
			success = true;
		}
		else
		{
			pNode::expandedNode++;
			//for each next state accessible from here, check if it's visited (and ignore it), else stick it in exist.
			if (tmp->blankPosition != 0 && tmp->blankPosition != 3 && tmp->blankPosition != 6) //MOVE LEFT
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition - 1]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					exist.push_back(new pNode(key, tmp, "LEFT", tmp->blankPosition - 1, tmp->parentCount + 1));
					visited[key] = exist.back();
					mem.push_back(exist.back());
				}
			}
			if (tmp->blankPosition < 6) //MOVE DOWN
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition + 3]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					exist.push_back(new pNode(key, tmp, "DOWN", tmp->blankPosition + 3, tmp->parentCount + 1));
					visited[key] = exist.back();
					mem.push_back(exist.back());
				}
			}
			if (tmp->blankPosition != 2 && tmp->blankPosition != 5 && tmp->blankPosition != 8) //MOVE RIGHT
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition + 1]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					exist.push_back(new pNode(key, tmp, "RIGHT", tmp->blankPosition + 1, tmp->parentCount + 1));
					visited[key] = exist.back();
					mem.push_back(exist.back());
				}
			}
			if (tmp->blankPosition > 2)//MOVE UP
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition - 3]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					exist.push_back(new pNode(key, tmp, "UP", tmp->blankPosition - 3, tmp->parentCount + 1));
					visited[key] = exist.back();
					mem.push_back(exist.back());
				}
			}
		}
	}
	if (success == false)
	{
		auto endTime = high_resolution_clock::now();
		long long timeElapsed = duration_cast<std::chrono::milliseconds>(endTime - startTime).count();
		cout << "\nUnsolvable - " << searchType << endl;
		cout << "Time: " << timeElapsed << "ms" << endl;
		cout << "Expanded Nodes: " << pNode::expandedNode << endl;
	}
	pNode::expandedNode = 0;
	for (size_t i = 0; i < mem.size(); i++)
		delete mem[i];
}

bool depthLimitedSearch(pNode& start, pNode& end, int depthLimit, string searchType, bool ID, chrono::system_clock::time_point starterTime)
{
	bool success = false;
	//time it.
	auto startTime = high_resolution_clock::now();
	int nodeCount = 0;
	unordered_map<string, pNode*> visited; //closedset
	vector<pNode*> exist; //openset
	vector<pNode*> mem;
	pNode* starter = new pNode(start.state, start.parent, start.action, start.blankPosition, start.parentCount);
	exist.push_back(starter);
	mem.push_back(starter);
	auto t1 = high_resolution_clock::now();
	string key = "";
	pNode* tmp = nullptr;

	while (!exist.empty())
	{
		tmp = exist.back();
		exist.pop_back();

		if (tmp->state == end.state)
		{
			long long timeElapsed = 0;
			chrono::system_clock::time_point endTime = high_resolution_clock::now();
			if (ID)
				timeElapsed = duration_cast<std::chrono::milliseconds>(endTime - starterTime).count();
			else
				timeElapsed = duration_cast<std::chrono::milliseconds>(endTime - startTime).count();
			displaySearchOutput(searchType + ", depth " + to_string(depthLimit), timeElapsed, start, *tmp); //print out.
			exist.clear();
			visited.clear();
			success = true;
		}
		else
		{
			pNode::expandedNode++;
			//for each next state accessible from here, check if it's visited (and ignore it), else stick it in exists.
			if (tmp->blankPosition != 0 && tmp->blankPosition != 3 && tmp->blankPosition != 6 && tmp->parentCount < depthLimit) //MOVE LEFT
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition - 1]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					exist.push_back(new pNode(key, tmp, "LEFT", tmp->blankPosition - 1, tmp->parentCount + 1));
					visited[key] = exist.back();
					mem.push_back(exist.back());
				}
			}
			if (tmp->blankPosition < 6 && tmp->parentCount < depthLimit) //MOVE DOWN
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition + 3]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					exist.push_back(new pNode(key, tmp, "DOWN", tmp->blankPosition + 3, tmp->parentCount + 1));
					visited[key] = exist.back();
					mem.push_back(exist.back());
				}
			}
			if (tmp->blankPosition != 2 && tmp->blankPosition != 5 && tmp->blankPosition != 8 && tmp->parentCount < depthLimit) //MOVE RIGHT
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition + 1]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					exist.push_back(new pNode(key, tmp, "RIGHT", tmp->blankPosition + 1, tmp->parentCount + 1));
					visited[key] = exist.back();
					mem.push_back(exist.back());
				}
			}
			if (tmp->blankPosition > 2 && tmp->parentCount < depthLimit)//MOVE UP
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition - 3]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					exist.push_back(new pNode(key, tmp, "UP", tmp->blankPosition - 3, tmp->parentCount + 1));
					visited[key] = exist.back();
					mem.push_back(exist.back());
				}
			}
		}
	}
	if (success == false && ID == false)
	{
		auto endTime = high_resolution_clock::now();
		long long timeElapsed = duration_cast<std::chrono::milliseconds>(endTime - startTime).count();
		cout << "\nUnsolvable - " << searchType << ", limit " << depthLimit << endl;
		cout << "Time: " << timeElapsed << "ms" << endl;
		cout << "Expanded Nodes: " << pNode::expandedNode << endl;
	}
	if (ID == true)
		pNode::IDExpand = pNode::expandedNode;
	else pNode::expandedNode = 0;
	for (size_t i = 0; i < mem.size(); i++)
		delete mem[i];
	return success;
}

void iterativeDeepeningSearch(pNode& start, pNode& end, string searchType)
{
	auto startTime = high_resolution_clock::now();
	bool success = false;
	int depth = 40;
	while (success == false && pNode::expandedNode < MAX_EXPAND)
	{
		pNode::expandedNode = 0;
		success = depthLimitedSearch(start, end, depth, searchType, true, startTime);
		depth *= 2;
	}
	if (success == false)
	{
		auto endTime = high_resolution_clock::now();
		long long timeElapsed = duration_cast<std::chrono::milliseconds>(endTime - startTime).count();
		cout << "\nUnsolvable - " << searchType << ", depth " << depth << endl;
		cout << "Time: " << timeElapsed << "ms" << endl;
		cout << "Expanded Nodes: " << pNode::IDExpand << endl;
	}
	pNode::expandedNode = 0;
}

void biDirectionalSearch(pNode& start, pNode& end, string searchType)
{
	string finalKey = "";
	bool success = false;
	int biDirection = 0;
	//time it.
	auto startTime = high_resolution_clock::now();

	unordered_map<string, pNode*> visited; //closedset
	unordered_map<string, pNode*> visited2;
	queue<pNode*> exist; //openset
	queue<pNode*> exist2;
	vector<pNode*> mem;
	auto starter = new pNode(start.state, start.parent, start.action, start.blankPosition, start.parentCount);
	auto ender = new pNode(end.state, end.parent, end.action, end.blankPosition, end.parentCount);
	exist.push(starter);
	exist2.push(ender);
	mem.push_back(starter);
	mem.push_back(ender);
	string key = "";
	for (int i = 0; i < PUZZLE_SIZE; i++)
		key = key + to_string(start.state[i]);
	visited.insert(make_pair(key, exist.back()));
	key = "";
	for (int i = 0; i < PUZZLE_SIZE; i++)
		key = key + to_string(end.state[i]);
	visited2.insert(make_pair(key, exist2.back()));

	pNode* tmp = nullptr;
	pNode* goal = nullptr;

	while (!exist.empty() && !exist2.empty())
	{
		if (success)
		{
			pNode::expandedNode = pNode::expandedNode / 2 + 1;
			auto endTime = high_resolution_clock::now();
			auto front = visited.at(finalKey);
			auto back = visited2.at(finalKey);

			long long timeElapsed = duration_cast<std::chrono::milliseconds>(endTime - startTime).count();
			cout << "\n" << searchType << ":\n" << endl;
			cout << "Initial Puzzle:\n";
			puzzleDisplay(start.state);
			cout << "Time: " << timeElapsed << "ms\n";
			cout << "Expanded Nodes: " << pNode::expandedNode  << endl;
			cout << "Solution Path, " << front->parentCount + back->parentCount << " steps:\n\t";

			deque<string> frontpath;

			while (front->parent != nullptr)
			{
				frontpath.push_front(front->action);
				front = front->parent;
			}

			deque<string> backpath;
			while (back->parent != nullptr)
			{
				if (back->action == "UP")
					backpath.push_back("DOWN");
				else if (back->action == "DOWN")
					backpath.push_back("UP");
				else if (back->action == "LEFT")
					backpath.push_back("RIGHT");
				else if (back->action == "RIGHT")
					backpath.push_back("LEFT");
				back = back->parent;
			}
			while (backpath.size() > 0)
			{
				frontpath.push_back(backpath.front());
				backpath.pop_front();
			}

			int printPath = 0, lineLen = 0;
			if (frontpath.size() > 100)
				printPath = frontpath.size() - 100;
			for (size_t i = printPath; i < frontpath.size() - 1; i++)
			{
				cout << frontpath[i] << ", ";
				if (lineLen++ == PUZZLE_SIZE)
				{
					cout << "\n\t";
					lineLen = 0;
				}
			}
			cout << frontpath.back() << ".\n";
			cout << "End Puzzle:\n";
			puzzleDisplay(end.state);
			visited.clear();
			swap(exist, queue<pNode*> {});
			swap(exist2, queue<pNode*> {});
		}
		else
		{
			if (biDirection == 0)
			{
				tmp = exist.front();
				exist.pop();
			}
			else
			{
				tmp = exist2.front();
				exist2.pop();
			}
			pNode::expandedNode++;
			//for each next state accessible from here, check if it's visited (and ignore it), else stick in exist.
			if (tmp->blankPosition > 2)//MOVE UP
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition - 3]);
				try
				{
					if (biDirection == 0)
						visited.at(key)->state;
					else visited2.at(key)->state;
				}
				catch (out_of_range)
				{
					if (biDirection == 0)
					{
						exist.push(new pNode(key, tmp, "UP", tmp->blankPosition - 3, tmp->parentCount + 1));
						visited[key] = exist.back();
						mem.push_back(exist.back());
					}
					else
					{
						exist2.push(new pNode(key, tmp, "UP", tmp->blankPosition - 3, tmp->parentCount + 1));
						visited2[key] = exist2.back();
						mem.push_back(exist2.back());
					}
				}
				try
				{
					visited.at(key)->state;
					visited2.at(key)->state;
					success = true;
					finalKey = key;
				}
				catch (out_of_range){}
			}
			if (tmp->blankPosition != 2 && tmp->blankPosition != 5 && tmp->blankPosition != 8) //MOVE RIGHT
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition + 1]);
				try
				{
					if (biDirection == 0)
						visited.at(key)->state;
					else visited2.at(key)->state;
				}
				catch (out_of_range)
				{
					if (biDirection == 0)
					{
						exist.push(new pNode(key, tmp, "RIGHT", tmp->blankPosition + 1, tmp->parentCount + 1));
						visited[key] = exist.back();
						mem.push_back(exist.back());
					}
					else
					{
						exist2.push(new pNode(key, tmp, "RIGHT", tmp->blankPosition + 1, tmp->parentCount + 1));
						visited2[key] = exist2.back();
						mem.push_back(exist2.back());
					}
				}
				try
				{
					visited.at(key)->state;
					visited2.at(key)->state;
					success = true;
					finalKey = key;
				}
				catch (out_of_range){}
			}
			if (tmp->blankPosition < 6) //MOVE DOWN
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition + 3]);
				try
				{
					if (biDirection == 0)
						visited.at(key)->state;
					else visited2.at(key)->state;
				}
				catch (out_of_range)
				{
					if (biDirection == 0)
					{
						exist.push(new pNode(key, tmp, "DOWN", tmp->blankPosition + 3, tmp->parentCount + 1));
						visited[key] = exist.back();
						mem.push_back(exist.back());
					}
					else
					{
						exist2.push(new pNode(key, tmp, "DOWN", tmp->blankPosition + 3, tmp->parentCount + 1));
						visited2[key] = exist2.back();
						mem.push_back(exist2.back());
					}
				}
				try
				{
					visited.at(key)->state;
					visited2.at(key)->state;
					success = true;
					finalKey = key;
				}
				catch (out_of_range){}
			}

			if (tmp->blankPosition != 0 && tmp->blankPosition != 3 && tmp->blankPosition != 6) //MOVE LEFT
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition - 1]);
				try
				{
					if (biDirection == 0)
						visited.at(key)->state;
					else visited2.at(key)->state;
				}
				catch (out_of_range)
				{
					if (biDirection == 0)
					{
						exist.push(new pNode(key, tmp, "LEFT", tmp->blankPosition - 1, tmp->parentCount + 1));
						visited[key] = exist.back();
						mem.push_back(exist.back());
					}
					else
					{
						exist2.push(new pNode(key, tmp, "LEFT", tmp->blankPosition - 1, tmp->parentCount + 1));
						visited2[key] = exist2.back();
						mem.push_back(exist2.back());
					}
				}
				try
				{
					visited.at(key)->state;
					visited2.at(key)->state;
					success = true;
					finalKey = key;
				}
				catch (out_of_range){}
			}
			if (biDirection == 0)
				biDirection = 1;
			else biDirection = 0;
		}
	}
	if (success == false)
	{
		pNode::expandedNode = pNode::expandedNode / 2 + 1;
		auto endTime = high_resolution_clock::now();
		long long timeElapsed = duration_cast<std::chrono::milliseconds>(endTime - startTime).count();
		cout << "\nUnsolvable - " << searchType << endl;
		cout << "Time: " << timeElapsed << "ms" << endl;
		cout << "Expanded Nodes: " << pNode::expandedNode << endl;
	}
	pNode::expandedNode = 0;
	for (size_t i = 0; i < mem.size(); i++)
		delete mem[i];
}

void greedySearch(pNode& start, pNode& end, string searchType)
{
	bool success = false;
	//time it.
	auto startTime = high_resolution_clock::now();

	unordered_map<string, pNode*> visited; //closedset
	map<string, pNode*, Heuristic::misplacedTiles> exist;
	vector<pNode*> mem;

	auto starter = new pNode(start.state, start.parent, start.action, start.blankPosition, start.parentCount);
	exist.insert(make_pair(starter->state, starter));
	mem.push_back(starter);
	string key = "";
	pNode* tmp = nullptr;

	while (!exist.empty())
	{
		tmp = exist.begin()->second;
		exist.erase(exist.begin());
		
		if (tmp->state == end.state)
		{
			success = true;
			auto endTime = high_resolution_clock::now();
			long long timeElapsed = duration_cast<std::chrono::milliseconds>(endTime - startTime).count();
			displaySearchOutput(searchType, timeElapsed, start, *tmp); //print out.
			visited.clear();
			exist.clear();
		}
		else
		{
			pNode::expandedNode++;
			//for each next state accessible from here, check if it's visited (and ignore it), else stick it in the openset and record parent.
			if (tmp->blankPosition > 2)//MOVE UP
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition - 3]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					pNode* newNode = new pNode(key, tmp, "UP", tmp->blankPosition - 3, tmp->parentCount + 1);
					exist.insert(make_pair(key, newNode));
					visited[key] = newNode;
					mem.push_back(newNode);
				}
			}
			if (tmp->blankPosition != 2 && tmp->blankPosition != 5 && tmp->blankPosition != 8) //MOVE RIGHT
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition + 1]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					pNode* newNode = new pNode(key, tmp, "RIGHT", tmp->blankPosition + 1, tmp->parentCount + 1);
					exist.insert(make_pair(key, newNode));
					visited[key] = newNode;
					mem.push_back(newNode);
				}
			}
			if (tmp->blankPosition < 6) //MOVE DOWN
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition + 3]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					pNode* newNode = new pNode(key, tmp, "DOWN", tmp->blankPosition + 3, tmp->parentCount + 1);
					exist.insert(make_pair(key, newNode));
					visited[key] = newNode;
					mem.push_back(newNode);
				}
			}

			if (tmp->blankPosition != 0 && tmp->blankPosition != 3 && tmp->blankPosition != 6) //MOVE LEFT
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition - 1]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					pNode* newNode = new pNode(key, tmp, "LEFT", tmp->blankPosition - 1, tmp->parentCount + 1);
					exist.insert(make_pair(key, newNode));
					visited[key] = newNode;
					mem.push_back(newNode);
				}
			}
		}
	}
	if (success == false)
	{
		auto endTime = high_resolution_clock::now();
		long long timeElapsed = duration_cast<std::chrono::milliseconds>(endTime - startTime).count();
		cout << "\nUnsolvable - " << searchType << endl;
		cout << "Time: " << timeElapsed << "ms" << endl;
		cout << "Expanded Nodes: " << pNode::expandedNode << endl;
	}
	pNode::expandedNode = 0;
	for (size_t i = 0; i < mem.size(); i++)
		delete mem[i];
}

void AStarSearchMisplacedTiles(pNode& start, pNode& end, string searchType)
{
	bool success = false;
	//time it.
	auto startTime = high_resolution_clock::now();

	unordered_map<string, pNode*> visited; //closedset
	map<pNode*, pNode*, Heuristic::aStarMisplacedTiles> exist;
	vector<pNode*> mem;
	auto starter = new pNode(start.state, start.parent, start.action, start.blankPosition, start.parentCount);
	exist.insert(make_pair(starter, starter));
	mem.push_back(starter);

	string key = "";
	pNode* tmp = nullptr;

	while (!exist.empty())
	{
		tmp = exist.begin()->second;
		exist.erase(exist.begin());

		if (tmp->state == end.state)
		{
			success = true;
			auto endTime = high_resolution_clock::now();
			long long timeElapsed = duration_cast<std::chrono::milliseconds>(endTime - startTime).count();
			displaySearchOutput(searchType, timeElapsed, start, *tmp); //print out.
			visited.clear();
			exist.clear();
		}
		else
		{
			pNode::expandedNode++;
			//for each next state accessible from here, check if it's visited (and ignore it), else stick it in the openset and record parent.
			if (tmp->blankPosition > 2)//MOVE UP
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition - 3]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					pNode* newNode = new pNode(key, tmp, "UP", tmp->blankPosition - 3, tmp->parentCount + 1);
					exist.insert(make_pair(newNode, newNode));
					visited[key] = newNode;
					mem.push_back(newNode);
				}
			}
			if (tmp->blankPosition != 2 && tmp->blankPosition != 5 && tmp->blankPosition != 8) //MOVE RIGHT
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition + 1]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					pNode* newNode = new pNode(key, tmp, "RIGHT", tmp->blankPosition + 1, tmp->parentCount + 1);
					exist.insert(make_pair(newNode, newNode));
					visited[key] = newNode;
					mem.push_back(newNode);
				}
			}
			if (tmp->blankPosition < 6) //MOVE DOWN
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition + 3]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					pNode* newNode = new pNode(key, tmp, "DOWN", tmp->blankPosition + 3, tmp->parentCount + 1);
					exist.insert(make_pair(newNode, newNode));
					visited[key] = newNode;
					mem.push_back(newNode);
				}
			}

			if (tmp->blankPosition != 0 && tmp->blankPosition != 3 && tmp->blankPosition != 6) //MOVE LEFT
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition - 1]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					pNode* newNode = new pNode(key, tmp, "LEFT", tmp->blankPosition - 1, tmp->parentCount + 1);
					exist.insert(make_pair(newNode, newNode));
					visited[key] = newNode;
					mem.push_back(newNode);
				}
			}
		}
	}
	if (success == false)
	{
		auto endTime = high_resolution_clock::now();
		long long timeElapsed = duration_cast<std::chrono::milliseconds>(endTime - startTime).count();
		cout << "\nUnsolvable - " << searchType << endl;
		cout << "Time: " << timeElapsed << "ms" << endl;
		cout << "Expanded Nodes: " << pNode::expandedNode << endl;
	}
	pNode::expandedNode = 0;
	for (size_t i = 0; i < mem.size(); i++)
		delete mem[i];
}

void AStarSearchHammingManhattan(pNode& start, pNode& end, string searchType)
{
	bool success = false;
	//time it.
	auto startTime = high_resolution_clock::now();

	unordered_map<string, pNode*> visited; //closedset
	map<pNode*, pNode*, Heuristic::aStarCustomHeuristic> exist;
	vector<pNode*> mem;

	auto starter = new pNode(start.state, start.parent, start.action, start.blankPosition, start.parentCount);
	exist.insert(make_pair(starter, starter));
	mem.push_back(starter);
	string key = "";
	pNode* tmp = nullptr;

	while (!exist.empty())
	{
		tmp = exist.begin()->second;
		exist.erase(exist.begin());

		if (tmp->state == end.state)
		{
			success = true;
			auto endTime = high_resolution_clock::now();
			long long timeElapsed = duration_cast<std::chrono::milliseconds>(endTime - startTime).count();
			displaySearchOutput(searchType, timeElapsed, start, *tmp); //print out.
			visited.clear();
			exist.clear();
		}
		else
		{
			pNode::expandedNode++;
			//for each next state accessible from here, check if it's visited (and ignore it), else stick it in the openset and record parent.
			if (tmp->blankPosition > 2)//MOVE UP
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition - 3]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					pNode* newNode = new pNode(key, tmp, "UP", tmp->blankPosition - 3, tmp->parentCount + 1);
					exist.insert(make_pair(newNode, newNode));
					visited[key] = newNode;
					mem.push_back(newNode);
				}
			}
			if (tmp->blankPosition != 2 && tmp->blankPosition != 5 && tmp->blankPosition != 8) //MOVE RIGHT
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition + 1]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					pNode* newNode = new pNode(key, tmp, "RIGHT", tmp->blankPosition + 1, tmp->parentCount + 1);
					exist.insert(make_pair(newNode, newNode));
					visited[key] = newNode;
					mem.push_back(newNode);
				}
			}
			if (tmp->blankPosition < 6) //MOVE DOWN
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition + 3]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					pNode* newNode = new pNode(key, tmp, "DOWN", tmp->blankPosition + 3, tmp->parentCount + 1);
					exist.insert(make_pair(newNode, newNode));
					visited[key] = newNode;
					mem.push_back(newNode);
				}
			}

			if (tmp->blankPosition != 0 && tmp->blankPosition != 3 && tmp->blankPosition != 6) //MOVE LEFT
			{
				key = tmp->state;
				swap(key[tmp->blankPosition], key[tmp->blankPosition - 1]);
				try
				{
					visited.at(key)->state;
				}
				catch (out_of_range)
				{
					pNode* newNode = new pNode(key, tmp, "LEFT", tmp->blankPosition - 1, tmp->parentCount + 1);
					exist.insert(make_pair(newNode, newNode));
					visited[key] = newNode;
					mem.push_back(newNode);
				}
			}
		}
	}
	if (success == false)
	{
		auto endTime = high_resolution_clock::now();
		long long timeElapsed = duration_cast<std::chrono::milliseconds>(endTime - startTime).count();
		cout << "\nUnsolvable - " << searchType << endl;
		cout << "Time: " << timeElapsed << "ms" << endl;
		cout << "Expanded Nodes: " << pNode::expandedNode << endl;
	}
	pNode::expandedNode = 0;
	for (size_t i = 0; i < mem.size(); i++)
		delete mem[i];
}

void puzzleDisplay(string printPuz)
{
	int cnt = 0;
	cout << endl;
	while (cnt < PUZZLE_SIZE)
	{
		cout << "\t";
		for (int i = 0; i < 3; i++)
		{
			if (printPuz[cnt++] != '0')
				cout << printPuz[cnt - 1];
			else cout << "_";
		}
		cout << "\n";
	}
	cout << endl;
}

void displaySearchOutput(string searchType, long long timeTaken, pNode& start, pNode& end)
{
	cout << "\n" << searchType << ":\n" << endl;
	cout << "Initial Puzzle:\n";
	puzzleDisplay(start.state);
	cout << "Time: " << timeTaken << "ms\n";
	cout << "Expanded Nodes: " << end.expandedNode << endl;
	cout << "Solution Path, " << end.parentCount << " steps:\n\t";
	int printPath = 0, printEnd = end.parentCount;
	if (end.parentCount > 100)
		printPath = end.parentCount - 100;

	vector<string> path;
	string puzzle = end.state;
	int solLen = 0, lineLen = 0, stepNO = 0;

	for (int i = printPath; i < printEnd; i++)
	{
		path.push_back(end.action);
		end = *end.parent;
	}

	for (int i = path.size() - 1; i > 0; i--)
	{
		cout << path[i] << ", ";
		if (lineLen++ == PUZZLE_SIZE)
		{
			cout << "\n\t";
			lineLen = 0;
		}
	}
	cout << path.front() << ".\n";
	cout << "End Puzzle:\n";
	puzzleDisplay(puzzle);
}