#include "Parse.h"

using namespace std;


Parse::Parse(Scanner* ct) : ct(ct)
{
	ct->nextToken();
}


Parse::~Parse(void)
{
}

//statement:: =
//"{" {statement} "}"
//| expression ";"
//| "if" "(" expression ")" statement["else" statement]
//| "while" "(" expression ")" statement
//| "return"[expression] ";"
//| "cout" "<<" expression ";"
//| "cin" ">>" expression ";"
//;

void Parse::statement()
{
	//"{" {statement} "}"
	if (ct->getToken()->getType() == "Block Begin")
	{
		ct->nextToken();
		while (ct->getToken()->getType() == "Block Begin")
		{
			ct->nextToken();
			Parse::statement();
		}
		if (ct->getToken()->getType() == "Block End")
			;
		else
			Parse::genError("}");
	}
	else
		Parse::genError("a block, expression, or statement keyword");
}

//expression:: =
//"(" expression ")"[expressionz]
//| "true"[expressionz]
//| "false"[expressionz]
//| "null"[expressionz]
//| numeric_literal[expressionz]
//| character_literal[expressionz]
//| identifier[fn_arr_member][member_refz][expressionz]
//;


void Parse::expression()
{
	//"(" expression ")" [ expressionz ]
	if(ct->getToken()->getLexem() == "(")
	{
		
	}
	//"true" [ expressionz ]

	else if (ct->getToken()->getLexem() == "true")
	{

	}
	//identifier [ fn_arr_member ] [ member_refz ] [ expressionz ]

	else if (ct->getToken()->getType() == "Identifier" )
	{
		//optional [expressionz] terminal "="
		if (ct->peek(1)->getType() == "Assignment Operator")
		{
			ct->nextToken();
			Parse::expressionz();
		}
		else{}
			//valid
	}
	else
	{
		Parse::genError("keyword, literal, or identifier");
	}
}

void Parse::expressionz()
{
	//expressionz::=
 // "=" assignment_expression
	if (ct->getToken()->getType() != "Assignment Operator")
	{
		Parse::genError("=");
	}
	ct->nextToken();
	Parse::assignment_expression();
}

void Parse::assignment_expression()
{
	Parse::expression();
}

void Parse::genError(string expected)
{
	cout << "line number: " << ct->getLineNum() << " (Found: " << ct->getToken()->getLexem() << ", Expected: " << expected << ")." << endl;
}

//"Character"
//"Comment"
//"Number"
//"Identifier"
//"Assignment Operator"
//"Relational Operator"
//"Logical Connective Operator"
//"Math Operator"
//"Array Begin"
//"Array End"
//"Block Begin"
//"Block End"
//"Parenthese Open"
//"Parenthese Close"
//"atoi"
//"bool"
//"class"
//"char"
//"cin"
//"cout"
//"else"
//"false"
//"if"
//"int"
//"itoa"
//"main"
//"new"
//"null"
//"object"
//"public"
//"private"
//"return"
//"string"
//"this"
//"true"
//"void"
//"while"
//"Punctuation"
//"EOT"
//"EOF"