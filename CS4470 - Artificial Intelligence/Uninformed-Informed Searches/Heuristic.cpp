#include "Heuristic.h"

int pNode::expandedNode = 0;
int pNode::IDExpand = 0;

int Heuristic::offTiles(const string& puz, string solution)
{
	int cost = PUZZLE_SIZE;
	for (int i = 0; i < PUZZLE_SIZE; i++)
	{
		if (puz[i] == solution[i])
			cost--;
	}
	return cost;
}

int Heuristic::distTiles(const char& puzItem, string puz)
{
	int distX1 = 0, distY1 = 0, distX2 = 0, distY2 = 0;
	if (puzItem == '1'){}
	else if (puzItem == '2')
		distX2 = 1;
	else if (puzItem == '3')
		distX2 = 2;
	else if (puzItem == '4')
		distY2 = 1;
	else if (puzItem == '5')
	{
		distX2 = 1;
		distY2 = 1;
	}
	else if (puzItem == '6')
	{
		distX2 = 2;
		distY2 = 1;
	}
	else if (puzItem == '7')
	{
		distX2 = 0;
		distY2 = 2;
	}
	else if (puzItem == '8')
	{
		distX2 = 1;
		distY2 = 2;
	}
	else if (puzItem == '0')
	{
		distX2 = 2;
		distY2 = 2;
	}
	for (int i = 0; i < PUZZLE_SIZE; i++)
	{
		if (puz[i] == puzItem)
		{
			if (i == '1'){}
			else if (i == '2')
				distX1 = 1;
			else if (i == '3')
				distX1 = 2;
			else if (i == '4')
				distY1 = 1;
			else if (i == '5')
			{
				distX1 = 1;
				distY1 = 1;
			}
			else if (i == '6')
			{
				distX1 = 2;
				distY1 = 1;
			}
			else if (i == '7')
			{
				distX1 = 0;
				distY1 = 2;
			}
			else if (i == '8')
			{
				distX1 = 1;
				distY1 = 2;
			}
			else if (i == '0')
			{
				distX1 = 2;
				distY1 = 2;
			}
		}
	}
	return abs(distX2 - distX1) + abs(distY2 - distY1);
}