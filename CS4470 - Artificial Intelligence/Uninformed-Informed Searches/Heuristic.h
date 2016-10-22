#pragma once
#include <string>
using namespace std;

const int PUZZLE_SIZE = 9, END_BLANK_POS = 8, MAX_EXPAND = 181441, MANHATTAN_MAX = 24;

struct pNode
{
	string state;
	pNode* parent;
	string action;
	int blankPosition;
	static int expandedNode;
	static int IDExpand;
	int parentCount;
	pNode(){}
	pNode(string _state, pNode* _parent, string _action, int _blankPosition, int _parentCount) : state(_state), parent(_parent), action(_action), blankPosition(_blankPosition), parentCount(_parentCount){}
};

class Heuristic
{
	static int offTiles(const string& puz, string solution);
	static int distTiles(const char& puzItem, string puz);
public:
	//greedy comparator - heuristic..Hamming Distance
	struct misplacedTiles
	{
		bool operator()(const string& p1, const string& p2)
		{
			string solution = "123456780";
			int cost1 = offTiles(p1, solution);
			int cost2 = offTiles(p2, solution);
			if (cost1 < cost2)
				return true;
			else if (cost1 == cost2)
			{
				if (p1 < p2)//this doesn't matter so much. It places similar cost items next to each other.
					return true;
				else return false;
			}
			else return false;
		}
	};

	//A* book comparator - Hamming Distance heuristic, just adds path cost.
	struct aStarMisplacedTiles
	{
	public:
		bool operator()(const pNode* p1, const pNode* p2)
		{
			string solution = "123456780";
			int cost1 = offTiles(p1->state, solution) + p1->parentCount;
			int cost2 = offTiles(p2->state, solution) + p2->parentCount;
			if (cost1 < cost2)
				return true;
			else if (cost1 == cost2)
			{
				if (p1->state < p2->state) //this doesn't matter so much. It places similar cost items next to each other.
					return true;
				else return false;
			}
			else return false;
		}
	};

	//A* custom comparator - Hamming + Manhattan Distance offset.
	struct aStarCustomHeuristic
	{
		bool operator()(const pNode* p1, const pNode* p2)
		{
			string solution = "123456780";
			int cost1 = offTiles(p1->state, solution) * MANHATTAN_MAX + p1->parentCount;
			int cost2 = offTiles(p2->state, solution) * MANHATTAN_MAX + p2->parentCount;
			for (int i = 0; i < PUZZLE_SIZE; i++)
			{
				cost1 = cost1 + distTiles(solution[i], p1->state);
				cost2 = cost2 + distTiles(solution[i], p2->state);
			}
			if (cost1 < cost2)
				return true;
			else if (cost1 == cost2)
			{
				if (p1->state < p2->state) //this doesn't matter so much. It places similar cost items next to each other.
					return true;
				else return false;
			}
			else return false;
		}
	};
};