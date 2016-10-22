#include <iostream>
#include <string>
#include <vector>
#include <random>
#include <fstream>

std::random_device rd; // obtain a random number from hardware
std::mt19937 eng(rd()); // seed the generator

struct side
{
	int reward;
	double qValue;
	double visits;
	virtual void process(void) = 0;
	int directionWent;
	std::string name;
	void updateVisits()
	{
		visits = 1 / (1 + visits);
	}
};

struct open : public side
{
	open(bool isGoal)
	{
		if (isGoal)
			reward = 100;
		else reward = 0;
		qValue = 0;
		visits = 0;
		name = "open";
		//std::cout << name << " ";
		directionWent = -1;
	}
	void process()
	{
		//movement does move character.

	}
};

struct wall : public side
{
	wall()
	{
		reward = -5;
		qValue = 0;
		visits = 0;
		name = "wall";
		//std::cout << name << " ";
		directionWent = -1;
	}
	void process()
	{
		//movement does not move character.

	}
};

struct stateGrid
{
	int pos;
	std::vector<side*> sides;
	int reward;
	stateGrid(){}
	~stateGrid()
	{
		//for (int i = 0; i < sides.size(); ++i)
			//delete sides[i];
	}

	stateGrid(int cellType)
	{
		//std::cout << "cell type: " << cellType << std::endl;
		pos = -1;
		//has 4 sides. Sides sequentially top, right, down, left.
		sides.resize(4);
		//open all.
		if (cellType == 0)
		{
			//types for each wall. 0 open, 1 wall, 2 goal.
			createSides(0, 0, 0, 0);
		}
		//goal state in top-right.
		else if (cellType == 1)
			createSides(1, 1, 2, 2);
		else if (cellType == 2)
			createSides(0, 0, 0, 1);
		else if (cellType == 3)
			createSides(0, 0, 1, 0);
		else if (cellType == 4)
			createSides(0, 0, 1, 1);
		else if (cellType == 5)
			createSides(0, 1, 0, 0);
		else if (cellType == 6)
			createSides(0, 1, 0, 1);
		else if (cellType == 7)
			createSides(0, 1, 1, 0);
		else if (cellType == 8)
			createSides(0, 1, 1, 1);
		else if (cellType == 9)
			createSides(1, 0, 0, 0);
		else if (cellType == 10)
			createSides(1, 0, 0, 1);
		else if (cellType == 11)
			createSides(1, 0, 1, 0);
		else if (cellType == 12)
			createSides(1, 0, 1, 1);
		else if (cellType == 13)
			createSides(1, 1, 0, 0);
		else if (cellType == 14)
			createSides(1, 1, 0, 1);
		else if (cellType == 15)
			createSides(1, 1, 1, 0);
		else if (cellType == 16)
			createSides(1, 1, 1, 1);
		else if (cellType == 17)//under goal
			createSides(2, 1, 0, 0);
		else if (cellType == 18)//left of goal
			createSides(1, 2, 0, 0);

	}
	void createSides(int top, int right, int bot, int left)
	{
		std::vector<int> sideReps = {top, right, bot, left};
		for (int i = 0; i < sideReps.size(); i++)
		{
			side* aSide;
			if (sideReps[i] == 0)
				aSide = new open(false);
			else if (sideReps[i] == 1)
				aSide = new wall();
			else if (sideReps[i] == 2)
				aSide = new open(true);
			sides[i] = aSide;
		}
	}
};

class agent
{
	public:
	stateGrid* currentGrid;
	int exploration;
	int exploitation;
	agent()
	{
		exploration = 25;
		exploitation = 75;
	}
	int chooseStrategy()
	{
		std::uniform_int_distribution<int> distrIndex(1, 100); // define the range_
		int index = distrIndex(eng);
		if (index <= exploration)
			return 0;
		else return 1;
	}
	side* action()
	{
		int strategy = chooseStrategy();
		if (strategy == 0)
		{
			//explore.
			std::uniform_int_distribution<int> sideIndex(0, 3);
			int index = sideIndex(eng);
			currentGrid->sides[index]->directionWent = index;
			return currentGrid->sides[index];
		}
		else
		{
			//exploit. Choose best qValue.
			side* bestSide = currentGrid->sides[0];
			bestSide->directionWent = 0;
			for (int i = 1; i < currentGrid->sides.size(); ++i)
			{
				if (currentGrid->sides[i]->qValue > bestSide->qValue)
				{
					bestSide = currentGrid->sides[i];
					bestSide->directionWent = i;
				}
			}
			return bestSide;
		}
	}
};

class environment
{
	agent player;
	std::vector<stateGrid> theMaze;
	int directionSpecified;
	int leftOfDirection;
	int rightOfDirection;
	const int COLUMN_SIZE = 10;
	const int ROW_SIZE = 10;
	double discountFactor;
	int currentDirectionChosen;

public:
	std::vector<std::string> path;
	
	environment()
	{
		discountFactor = 0.9;
		theMaze.resize(100);
		std::vector<int> preDeterminedObstacles = {55, 74};

		for (int i = 0; i < theMaze.size(); ++i)
		{
			int row = i / 10;
			int rowStart = row * 10;
			int rowEnd = row * 10 + (COLUMN_SIZE - 1);
			//std::cout << "\ncell: " << i << std::endl;

			if (i == 99 - ROW_SIZE)//below goal
				theMaze[i] = stateGrid(17);
			else if (i == 99 - 1)//left of goal
				theMaze[i] = stateGrid(18);
			else if (i == rowStart && row == 0)//b-l corner
				theMaze[i] = stateGrid(4);
			else if (i > rowStart && i < rowEnd && row == 0)//b-mid
				theMaze[i] = stateGrid(3);			
			else if (i == rowEnd && row == 0)//b-r corner
				theMaze[i] = stateGrid(7);			
			else if (i == rowStart && row == (ROW_SIZE - 1))//t-l corner
				theMaze[i] = stateGrid(10);	
			else if (i > rowStart && i < rowEnd && row == (ROW_SIZE - 1))//t-mid
				theMaze[i] = stateGrid(9);		
			else if (i == rowEnd && row == (ROW_SIZE - 1))//t-r corner, goal
				theMaze[i] = stateGrid(1);
			else if (i > 0 && i == rowStart && i < 90)//mid-l
				theMaze[i] = stateGrid(2);
			else if (i > 9 && i == rowEnd && i < 99)//mid-r
				theMaze[i] = stateGrid(5);
			else
			{
				bool setState = false;//check for obstacles
				for (int j = 0; j < preDeterminedObstacles.size(); j++)
				{
					if (i == preDeterminedObstacles[j] - 1)//left of
					{
						theMaze[i] = stateGrid(5);
						setState = true;
					}
					else if (i == preDeterminedObstacles[j] + 1)//right of
					{
						theMaze[i] = stateGrid(2);
						setState = true;
					}
					else if (i == preDeterminedObstacles[j] + 10)//above
					{
						theMaze[i] = stateGrid(3);
						setState = true;
					}
					else if (i == preDeterminedObstacles[j] - 10)//below
					{
						theMaze[i] = stateGrid(9);
						setState = true;
					}
					else if (i == preDeterminedObstacles[j])//inside
					{
						theMaze[i] = stateGrid(16);
						setState = true;
					}
				}
				if (!setState)//open block
					theMaze[i] = stateGrid(0);
			}
		}
		directionSpecified = 100;
		leftOfDirection = 10;
		rightOfDirection = 10;
		player.currentGrid = &theMaze[0];
		player.currentGrid->pos = 0;
	}
	void runMaze()
	{
		std::ofstream myFile;
		myFile.open("output.txt", std::ios::out | std::ios::trunc);
		myFile.close();
		int thirdsFinished = 0;
		for (int i = 0; i < 60001; ++i)
		{
			player.currentGrid = &theMaze[0];
			player.currentGrid->pos = 0;
			path.clear();
			int counter = 0;
			//while the agent is not at the goal.
			while (player.currentGrid->pos != theMaze.size() - 1)
			{
				//use this side for updating the qvalue and visits.
				side* agentChosenSide = player.action();
				agentChosenSide->updateVisits();

				//environment chooses the actual side.
				side* chosenSide = chooseDirection(player.currentGrid, agentChosenSide);

				//std::cout << "\nchosen side name: " << chosenSide->name << std::endl;
				//std::cout << "chosen side type: " << chosenSide->directionWent << std::endl;

				//update player position.
				processDirection(chosenSide);

				//find max qValue for this state.
				double bestDirection = takeBestDirection();

				//qvalue changed will be for agent's side, using environment's chosen side.
				updateSide(agentChosenSide, chosenSide, bestDirection);
				counter++;
				//std::cout << counter++ << " position: " << player.currentGrid->pos << std::endl;
			}
			if (i % 20000 == 0 && i > 0)
			{
				myFile.open("output.txt", std::ios::out | std::ios::app);

				thirdsFinished++;
				std::cout << (double)(thirdsFinished / 3.0) << " Finished. Loops Taken: " << counter << std::endl;
				myFile << (double)(thirdsFinished / 3.0) << " Finished. Loops Taken: " << counter << std::endl;

				std::cout << "Solution Path:\n";
				myFile << "Solution Path:\n";

				for (int i = 0; i < path.size(); ++i)
				{
					if (path[i] != "")
					{
						std::cout << path[i] + " ";
						myFile << path[i] + " ";
					}
				}
				std::cout << std::endl;
				myFile << std::endl;

				//qvalue print
				for (int z = 0; z < theMaze.size(); ++z)
				{
					std::cout << "\nQ Values for Cell: " << z << std::endl;
					myFile << "\nQ Values for Cell: " << z << std::endl;

					for (int b = 0; b < theMaze[z].sides.size(); ++b)
					{
						std::cout << theMaze[z].sides[b]->qValue << " ";
						myFile << theMaze[z].sides[b]->qValue << " ";
					}
					std::cout << std::endl;
					myFile << std::endl << std::endl;
				}
				myFile.close();
			}
		}
	}
	side* chooseDirection(stateGrid* playerPos, side* agentChosenSide)
	{
		std::uniform_int_distribution<int> directionIndex(1, 100); // define the range_
		side* realSideChosen = agentChosenSide;
		int index = directionIndex(eng);
		if (index <= leftOfDirection)
		{
			//choose left of side.
			for (int i = 0; i < playerPos->sides.size(); ++i)
			{
				if (agentChosenSide == playerPos->sides[i])
				{
					if (i > 0)
					{
						realSideChosen = playerPos->sides[i-1];
						realSideChosen->directionWent = i - 1;
					}
					else
					{
						realSideChosen = playerPos->sides[playerPos->sides.size() - 1];
						realSideChosen->directionWent = playerPos->sides.size() - 1;
					}
				}
			}
		}
		else if (index > leftOfDirection && index <= leftOfDirection + rightOfDirection)
		{
			//choose right of side.
			for (int i = 0; i < playerPos->sides.size(); ++i)
			{
				if (agentChosenSide == playerPos->sides[i])
				{
					if (i < (playerPos->sides.size() - 1))
					{
						realSideChosen = playerPos->sides[i+1];
						realSideChosen->directionWent = i + 1;
					}
					else
					{
						realSideChosen = playerPos->sides[0];
						realSideChosen->directionWent = 0;
					}
				}
			}
		}
		return realSideChosen;
	}

	void processDirection(side* sideUsed)
	{
		if (sideUsed->name == "open")
		{
			int index = -1;
			//std::cout << "Current Position: " << player.currentGrid->pos << std::endl;
			//std::cout << sideUsed->directionWent << " ";
			std::string tmp = "";

			if (sideUsed->directionWent == 0) //up
			{
				index = player.currentGrid->pos + 10;
				//std::cout << "up" << std::endl;
				tmp = "up";
			}
			else if (sideUsed->directionWent == 1) //right
			{
				index = player.currentGrid->pos + 1;
				//std::cout << "right" << std::endl;
				tmp = "right";
			}
			else if (sideUsed->directionWent == 2) //down
			{
				index = player.currentGrid->pos - 10;
				//std::cout << "down" << std::endl;
				tmp = "down";
			}
			else if (sideUsed->directionWent == 3) //left
			{
				index = player.currentGrid->pos - 1;
				//std::cout << "left" << std::endl;
				tmp = "left";
			}
			path.push_back(tmp);
			player.currentGrid = &theMaze[index];
			player.currentGrid->pos = index;
		}
		else
		{
			//std::cout << "Current Position: " << player.currentGrid->pos << std::endl;
			//std::cout << "not open" << std::endl;
			path.push_back("");
		}
	}

	double takeBestDirection()
	{
		double bestDirection = -999;
		for (int i = 0; i < player.currentGrid->sides.size(); ++i)
		{
			if (bestDirection < player.currentGrid->sides[i]->qValue)
				bestDirection = player.currentGrid->sides[i]->qValue;
		}
		return bestDirection;
	}

	void updateSide(side* agentChosenSide, side* environmentChosenSide, double maxActionNextState)
	{
		//nondet training rule.
		environmentChosenSide->qValue = (1 - agentChosenSide->visits) * (agentChosenSide->qValue) + agentChosenSide->visits * (agentChosenSide->reward + (discountFactor * maxActionNextState));
	}
};

int main()
{
	environment openMaze;

	openMaze.runMaze();

	return 0;
}