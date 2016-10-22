#include "icgen.h"

int ICGenerator::labelLength = 25;

ICGenerator::ICGenerator(Scanner* ct) : ct(ct){quadCounter = 1;}

void ICGenerator::insert(std::string lbl, std::string instr, std::string o1, std::string o2, std::string o3, std::string comm)
{
	//check counter. To see if it needs to be a push or an update.

	if ((int) quadCounter > (int) quads.size())
	{
		if (instr != "")
			quadCounter++;

		if (lineNumber != ct->lineNumber)
		{
			push(new quad(lbl, instr, o1, o2, o3, comm, ct->lineNumber));
			lineNumber = ct->lineNumber;
		}
		else
		{
			push(new quad(lbl, instr, o1, o2, o3, comm, 0));
		}
	}
	else
	{
		if (lineNumber != ct->lineNumber)
		{
			lineNumber = ct->lineNumber;
		}

		//updating a quad (it already had a label from an earlier push).
		update(lbl, instr, o1, o2, o3, comm, ct->lineNumber);
		if (instr != "")
			quadCounter++;
	}
}

void ICGenerator::push(quad* newQuad)
{
	quads.push_back(newQuad);
	if (newQuad->label.size() > (unsigned int) ICGenerator::labelLength)
		ICGenerator::labelLength = newQuad->label.size();
}

void ICGenerator::copyQuad(quad* newQuad)
{
	push(newQuad);
	quadCounter++;
	if (newQuad->label.size() > (unsigned int) ICGenerator::labelLength)
		ICGenerator::labelLength = newQuad->label.size();
}

void ICGenerator::update(std::string lbl, std::string instr, std::string o1, std::string o2, std::string o3, std::string comm, int ln)
{
	//Check for possible backpatching.
	if (quads.back()->label != "" && lbl != "" && quads.back()->label != lbl)
	{
		backpatch(lbl, quads.back()->label, quads.size() - 1);
	}

	quads.back()->instruction = instr;
	quads.back()->op1 = o1;
	quads.back()->op2 = o2;
	quads.back()->op3 = o3;
	quads.back()->comment = comm;
	quads.back()->lineNumber = ln;

}

void ICGenerator::backpatch(std::string newLabel, std::string oldLabel, int position)
{
	//update every label from array position back to 0 replacing old label with new one.
	for (int i = position; i >= 0; i--)
	{
		if (quads[i]->label == oldLabel)
			quads[i]->label = newLabel;
		else if (quads[i]->op1 == oldLabel)
			quads[i]->op1 = newLabel;
		else if (quads[i]->op2 == oldLabel)
			quads[i]->op2 = newLabel;
	}
}