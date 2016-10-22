#include "Cl.h"

using namespace std;


Cl::Cl(Scanner* ct) : ct(ct)
{
	ct->nextToken();
	Cl::compilation_unit();
}

Cl::~Cl()
{
}

//NAMES, TYPES, LITERALS

//modifier::= "public" | "private"
//;

void Cl::modifier()
{
	if (ct->getToken()->getType() == "public" || ct->getToken()->getType() == "private")
		ct->nextToken();
	else
		genError("public or private");
}

//class_name::= identifier
//;

void Cl::class_name()
{
	if (ct->getToken()->getType() == "Identifier")
		ct->nextToken();
	else
		genError("An Identifier");
}

//type::= "int" | "char" | "bool" | "void" | class_name
//;

void Cl::type()
{
	if (ct->getToken()->getType() == "int" || ct->getToken()->getType() == "char" || ct->getToken()->getType() == "bool" || ct->getToken()->getType() == "void" || ct->getToken()->getType() == "Identifier")
		ct->nextToken();
	else
		genError("valid type or class name");
}

//character_literal::= "\'" character "\'" ;

void Cl::character_literal()
{
	if (ct->getToken()->getType() == "Character")
	{
		//success, implicit NT character and NT printable / nonprintable ascii.
	}
	else
		genError("A Character");
}

//numeric_literal::= ["+" | "-"] number ;

void Cl::numeric_literal()
{
	//check optional ["+" | "-"]
	if (ct->getToken()->getType() == "Plus Operator")
	{
		ct->nextToken();
		Cl::number();
	}
	else if (ct->getToken()->getType() == "Minus Operator")
	{
		ct->nextToken();
		Cl::number();
	}
	else if (ct->getToken()->getType() == "Number")
		Cl::number();
	else
		genError("A Number");
}

//number::= "0"{number}|"1"{number}|"2"{number}|"3"{number}|"4"{number}|"5"{number}|"6"{number}|"7"{number}|"8"{number}|"9"{number}

void Cl::number()
{
	if (ct->getToken()->getType() == "Number")
	{
		ct->nextToken();
		//success, scanner implicitly groups together number digits.
	}
	else
		genError("A Number");
}

//START SYMBOL

//compilation_unit::=
//{class_declaration} "void" "main" "(" ")" method_body
//;

void Cl::compilation_unit()
{
	while (ct->getToken()->getType() == "class")
	{
		Cl::class_declaration();
	}
	if (ct->getToken()->getType() == "void")
	{
		ct->nextToken();
		if (ct->getToken()->getType() == "main")
		{
			ct->nextToken();
			if (ct->getToken()->getType() == "(")
			{
				ct->nextToken();
				if (ct->getToken()->getType() == ")")
				{
					ct->nextToken();
					Cl::method_body();
				}
				else
					genError(")");
			}
			else
				genError("(");
		}
		else
			genError("main");
	}
	else
		genError("void");
}

//DECLARATIONS

//class_declaration::= "class" class_name "{" {class_member_declaration} "}"
//;

void Cl::class_declaration()
{
	if (ct->getToken()->getType() == "class")
	{
		ct->nextToken();
		Cl::class_name();
		if (ct->getToken()->getType() == "{")
		{
			ct->nextToken();
			while (ct->getToken()->getType() == "public" || ct->getToken()->getType() == "private" || ct->getToken()->getType() == "Identifier")
			{
				Cl::class_member_declaration();
			}
			if (ct->getToken()->getType() == "}")
				ct->nextToken();
			else
				genError("}");
		}
		else
			genError("{");
	}
	else
		genError("keyword: class");
}

//class_member_declaration::=
// modifier type identifier field_declaration
// | constructor_declaration
//;

void Cl::class_member_declaration()
{
	if (ct->getToken()->getType() == "public" || ct->getToken()->getType() == "private")
	{
		ct->nextToken();
		Cl::type();
		if (ct->getToken()->getType() == "Identifier")
		{
			ct->nextToken();
			Cl::field_declaration();
		}
		else
			genError("An Identifier");
	}
	else if (ct->getToken()->getType() == "Identifier")
	{
		Cl::constructor_declaration();
	}
	else
		genError("Keyword: public or private or a constructor declaration");
}

//field_declaration::=
// ["[" "]"] ["=" assignment_expression] ";"
// | "(" [parameter_list] ")" method_body
//;

void Cl::field_declaration()
{
	// ["[" "]"] ["=" assignment_expression] ";"
	if (ct->getToken()->getType() == "[" || ct->getToken()->getType() == "=" || ct->getToken()->getType() == ";")
	{
		//optional [ "[" "]" ]
		if (ct->getToken()->getType() == "[")
		{
			ct->nextToken();
			if (ct->getToken()->getType() == "]")
				ct->nextToken();
			else
				genError("]");
		}
		//optional ["=" assignment_expression]
		if (ct->getToken()->getType() == "=")
		{
			ct->nextToken();
			Cl::assignment_expression();
		}
		if (ct->getToken()->getType() == ";")
			ct->nextToken();
		else
			genError(";");
	}
	// "(" [parameter_list] ")" method_body
	else if (ct->getToken()->getType() == "(")
	{
		ct->nextToken();
		//optional [parameter_list]
		if (ct->getToken()->getType() == "int" || ct->getToken()->getType() == "char" || ct->getToken()->getType() == "bool" || ct->getToken()->getType() == "void" ||
			ct->getToken()->getType() == "Identifier")
		{
			Cl::parameter_list();
		}
		if (ct->getToken()->getType() == ")")
		{
			ct->nextToken();
			Cl::method_body();
		}
		else
			genError(")");
	}
	else
		genError("'[', '=', ';', or '('");
}

//constructor_declaration::= class_name "(" [parameter_list] ")" method_body
//;

void Cl::constructor_declaration()
{
	if (ct->getToken()->getType() == "Identifier")
	{
		ct->nextToken();
		if (ct->getToken()->getType() == "(")
		{
			ct->nextToken();
			//optional [parameter_list]
			if (ct->getToken()->getType() == "int" || ct->getToken()->getType() == "char" || ct->getToken()->getType() == "bool" || ct->getToken()->getType() == "void" ||
				ct->getToken()->getType() == "Identifier")
			{
				Cl::parameter_list();
			}
			if (ct->getToken()->getType() == ")")
			{
				ct->nextToken();
				Cl::method_body();
			}
			else
				genError(")");
		}
		else
			genError("(");
	}
	else
		genError("An Identifier");
}

//method_body::= "{" {variable_declaration} {statement} "}"
//;

void Cl::method_body()
{
	if (ct->getToken()->getType() == "{")
	{
		ct->nextToken();
		//{variable_declaration}
		while (ct->getToken()->getType() == "int" || ct->getToken()->getType() == "char" || ct->getToken()->getType() == "bool" || ct->getToken()->getType() == "void" ||
			ct->getToken()->getType() == "Identifier")
		{
			Cl::variable_declaration();
		}
		//{statement}
		while (ct->getToken()->getType() == "{" || ct->getToken()->getType() == "Logical Connective Operator" || ct->getToken()->getType() == "Relational Operator" ||
			ct->getToken()->getType() == "Plus Operator" || ct->getToken()->getType() == "Minus Operator" || ct->getToken()->getType() == "Math Operator" || ct->getToken()->getType() == "if"
			|| ct->getToken()->getType() == "while" || ct->getToken()->getType() == "return" || ct->getToken()->getType() == "cout" || ct->getToken()->getType() == "cin")
		{
			Cl::statement();
		}
		if (ct->getToken()->getType() == "}")
			ct->nextToken();
		else
			genError("}");
	}
	else
		genError("{");
}

//variable_declaration::= type identifier ["[" "]"] ["=" assignment_expression] ";"
//;

void Cl::variable_declaration()
{
	if (ct->getToken()->getType() == "int" || ct->getToken()->getType() == "char" || ct->getToken()->getType() == "bool" || ct->getToken()->getType() == "void" ||
		ct->getToken()->getType() == "Identifier")
	{
		ct->nextToken();
		if (ct->getToken()->getType() == "Identifier")
		{
			ct->nextToken();
			//optional [ "[" "]" ]
			if (ct->getToken()->getType() == "[")
			{
				ct->nextToken();
				if (ct->getToken()->getType() == "]")
					ct->nextToken();
				else
					genError("]");
			}
			//optional ["=" assignment_expression]
			if (ct->getToken()->getType() == "=")
			{
				ct->nextToken();
				Cl::assignment_expression();
			}
			if (ct->getToken()->getType() == ";")
				ct->nextToken();
			else
				genError(";");
		}
		else
			genError("An Identifier");
	}
	else
		genError("valid type or class name");
}

//parameter_list::= parameter { "," parameter }
//;

void Cl::parameter_list()
{
	if (ct->getToken()->getType() == "int" || ct->getToken()->getType() == "char" || ct->getToken()->getType() == "bool" || ct->getToken()->getType() == "void" ||
		ct->getToken()->getType() == "Identifier")
	{
		Cl::parameter();
		while (ct->getToken()->getType() == ",")
		{
			ct->nextToken();
			Cl::parameter();
		}
	}
	else
		genError("valid type or class name");
}

//parameter::= type identifier ["[" "]"]
//;

void Cl::parameter()
{
	if (ct->getToken()->getType() == "int" || ct->getToken()->getType() == "char" || ct->getToken()->getType() == "bool" || ct->getToken()->getType() == "void" ||
		ct->getToken()->getType() == "Identifier")
	{
		Cl::type();
		if (ct->getToken()->getType() == "Identifier")
		{
			ct->nextToken();
			//optional [ "[" "]" ]
			if (ct->getToken()->getType() == "[")
			{
				ct->nextToken();
				if (ct->getToken()->getType() == "]")
					ct->nextToken();
				else
					genError("]");
			}
		}
		else
			genError("An Identifier");
	}
	else
		genError("valid type or class name");
}

//STATEMENT

//statement:: =
//"{" {statement} "}"
//| expression ";"
//| "if" "(" expression ")" statement["else" statement]
//| "while" "(" expression ")" statement
//| "return"[expression] ";"
//| "cout" "<<" expression ";"
//| "cin" ">>" expression ";"
//;

void Cl::statement()
{
	//"{" {statement} "}"
	if (ct->getToken()->getType() == "{")
	{
		ct->nextToken();
		//{statement}
		while (ct->getToken()->getType() == "{" || ct->getToken()->getType() == "Logical Connective Operator" || ct->getToken()->getType() == "Relational Operator" ||
			ct->getToken()->getType() == "Plus Operator" || ct->getToken()->getType() == "Minus Operator" || ct->getToken()->getType() == "Math Operator" || ct->getToken()->getType() == "if"
			|| ct->getToken()->getType() == "while" || ct->getToken()->getType() == "return" || ct->getToken()->getType() == "cout" || ct->getToken()->getType() == "cin")
		{
			Cl::statement();
		}
		if (ct->getToken()->getType() == "}")
			ct->nextToken();
		else
			genError("}");
	}
	// expression ";"
	else if (ct->getToken()->getType() == "Logical Connective Operator" || ct->getToken()->getType() == "Relational Operator" || ct->getToken()->getType() == "Plus Operator"
		|| ct->getToken()->getType() == "Minus Operator" || ct->getToken()->getType() == "Math Operator")
	{
		Cl::expression();
		if (ct->getToken()->getType() == ";")
			ct->nextToken();
		else
			genError(";");
	}
	// "if" "(" expression ")" statement ["else" statement]
	else if (ct->getToken()->getType() == "if")
	{
		ct->nextToken();
		if (ct->getToken()->getType() == "(")
		{
			ct->nextToken();
			Cl::expression();
			if (ct->getToken()->getType() == ")")
			{
				ct->nextToken();
				Cl::statement();
				//optional ["else" statement]
				if (ct->getToken()->getType() == "else")
				{
					ct->nextToken();
					Cl::statement();
				}
			}
			else
				genError(")");
		}
		else
			genError("(");
	}
	// "while" "(" expression ")" statement
	else if (ct->getToken()->getType() == "while")
	{
		ct->nextToken();
		if (ct->getToken()->getType() == "(")
		{
			ct->nextToken();
			Cl::expression();
			if (ct->getToken()->getType() == ")")
			{
				ct->nextToken();
				Cl::statement();
			}
			else
				genError(")");
		}
		else
			genError("(");
	}
	// "return" [expression] ";"
	else if (ct->getToken()->getType() == "return")
	{
		ct->nextToken();
		//optional [expression]
		if (ct->getToken()->getType() == "Logical Connective Operator" || ct->getToken()->getType() == "Relational Operator" || ct->getToken()->getType() == "Plus Operator"
			|| ct->getToken()->getType() == "Minus Operator" || ct->getToken()->getType() == "Math Operator")
		{
			Cl::expression();
		}
		if (ct->getToken()->getType() == ";")
			ct->nextToken();
		else
			genError(";");
	}
	// "cout" "<<" expression ";"
	else if (ct->getToken()->getType() == "cout")
	{
		ct->nextToken();
		if (ct->getToken()->getType() == "<<")
		{
			ct->nextToken();
			Cl::expression();
			if (ct->getToken()->getType() == ";")
				ct->nextToken();
			else
				genError(";");
		}
		else
			genError("<<");
	}
	// "cin" ">>" expression ";"
	else if (ct->getToken()->getType() == "cin")
	{
		ct->nextToken();
		if (ct->getToken()->getType() == ">>")
		{
			ct->nextToken();
			Cl::expression();
			if (ct->getToken()->getType() == ";")
				ct->nextToken();
			else
				genError(";");
		}
		else
			genError(">>");
	}
	else
		genError("a '{', valid expression, or keyword: if, while, return, cout, or cin");
}

//EXPRESSIONS

//expression:: =
//"(" expression ")"[expressionz]
//| "true"[expressionz]
//| "false"[expressionz]
//| "null"[expressionz]
//| numeric_literal[expressionz]
//| character_literal[expressionz]
//| identifier[fn_arr_member][member_refz][expressionz]
//;

void Cl::expression()
{
	//"(" expression ")" [ expressionz ]
	if (ct->getToken()->getType() == "(")
	{
		//check expression terminal.
		ct->nextToken();
		Cl::expression();
		if (ct->getToken()->getType() == ")")
		{
			ct->nextToken();
			// success, check first terminal of optional[expressionz]
			if (ct->getToken()->getType() == "Assignment Operator" || ct->getToken()->getType() == "Logical Connective Operator"
				|| ct->getToken()->getType() == "Relational Operator" || ct->getToken()->getType() == "Plus Operator"
				|| ct->getToken()->getType() == "Minus Operator" || ct->getToken()->getType() == "Math Operator")
			{
				Cl::expressionz();
			}
		}
	}
	// "true"[expressionz]
	else if (ct->getToken()->getType() == "true")
	{
		ct->nextToken();
		// success, check first terminal of optional[expressionz]
		if (ct->getToken()->getType() == "Assignment Operator" || ct->getToken()->getType() == "Logical Connective Operator"
			|| ct->getToken()->getType() == "Relational Operator" || ct->getToken()->getType() == "Plus Operator"
			|| ct->getToken()->getType() == "Minus Operator" || ct->getToken()->getType() == "Math Operator")
		{
			Cl::expressionz();
		}
	}
	// "false"[expressionz]
	else if (ct->getToken()->getType() == "false")
	{
		ct->nextToken();
		// success, check first terminal of optional[expressionz]
		if (ct->getToken()->getType() == "Assignment Operator" || ct->getToken()->getType() == "Logical Connective Operator"
			|| ct->getToken()->getType() == "Relational Operator" || ct->getToken()->getType() == "Plus Operator"
			|| ct->getToken()->getType() == "Minus Operator" || ct->getToken()->getType() == "Math Operator")
		{
			Cl::expressionz();
		}
	}
	// "null"[expressionz]
	else if (ct->getToken()->getType() == "null")
	{
		ct->nextToken();
		// success, check first terminal of optional[expressionz]
		if (ct->getToken()->getType() == "Assignment Operator" || ct->getToken()->getType() == "Logical Connective Operator"
			|| ct->getToken()->getType() == "Relational Operator" || ct->getToken()->getType() == "Plus Operator"
			|| ct->getToken()->getType() == "Minus Operator" || ct->getToken()->getType() == "Math Operator")
		{
			Cl::expressionz();
		}
	}
	// numeric_literal [expressionz]
	else if (ct->getToken()->getType() == "Plus Operator" || ct->getToken()->getType() == "Minus Operator" || ct->getToken()->getType() == "Number")
	{
		Cl::numeric_literal();
		//success, check first terminal of optional[expressionz]
		if (ct->getToken()->getType() == "Assignment Operator" || ct->getToken()->getType() == "Logical Connective Operator"
			|| ct->getToken()->getType() == "Relational Operator" || ct->getToken()->getType() == "Plus Operator"
			|| ct->getToken()->getType() == "Minus Operator" || ct->getToken()->getType() == "Math Operator")
		{
			Cl::expressionz();
		}
	}
	// character_literal[expressionz]
	else if (ct->getToken()->getType() == "Character")
	{
		Cl::character_literal();
		//success, check first terminal of optional[expressionz]
		if (ct->getToken()->getType() == "Assignment Operator" || ct->getToken()->getType() == "Logical Connective Operator"
			|| ct->getToken()->getType() == "Relational Operator" || ct->getToken()->getType() == "Plus Operator"
			|| ct->getToken()->getType() == "Minus Operator" || ct->getToken()->getType() == "Math Operator")
		{
			Cl::expressionz();
		}
	}
	// identifier[fn_arr_member][member_refz][expressionz]
	else if (ct->getToken()->getType() == "Identifier")
	{
		// success, check terminal of optional [fn_arr_member] [member_refz] [expressionz]

		//optional [expressionz]
		if (ct->getToken()->getType() == "Assignment Operator" || ct->getToken()->getType() == "Logical Connective Operator"
			|| ct->getToken()->getType() == "Relational Operator" || ct->getToken()->getType() == "Plus Operator"
			|| ct->getToken()->getType() == "Minus Operator" || ct->getToken()->getType() == "Math Operator")
		{
			Cl::expressionz();
		}
	}
	else
	{
		Cl::genError("(, keyword: true, false or null, a literal, or identifier");
	}
}

//fn_arr_member::=
//"(" [ argument_list ] ")"
// "[" expression "]"
//;

void Cl::fn_arr_member()
{
	//"(" [ argument_list ] ")"
	if (ct->getToken()->getType() == "(")
	{
		ct->nextToken();
		//optional [argument_list]
		if (ct->getToken()->getType() == "(" || ct->getToken()->getType() == "true" || ct->getToken()->getType() == "false" || ct->getToken()->getType() == "null" || ct->getToken()->getType() == "Plus Operator"
			|| ct->getToken()->getType() == "Minus Operator" || ct->getToken()->getType() == "Number" || ct->getToken()->getType() == "Character" || ct->getToken()->getType() == "Identifier")
		{
			Cl::argument_list();
		}
		if (ct->getToken()->getType() == ")")
		{
			ct->nextToken();
		}
		else
			genError(")");
	}
	// "[" expression "]"
	else if (ct->getToken()->getType() == "[")
	{
		ct->nextToken();

		if (ct->getToken()->getType() == "(" || ct->getToken()->getType() == "true" || ct->getToken()->getType() == "false" || ct->getToken()->getType() == "null" || ct->getToken()->getType() == "Plus Operator"
			|| ct->getToken()->getType() == "Minus Operator" || ct->getToken()->getType() == "Number" || ct->getToken()->getType() == "Character" || ct->getToken()->getType() == "Identifier")
		{
			Cl::expression();
		}
		else
			genError("(, keyword: true, false or null, a literal, or identifier");
	}
	else
		genError("A ( or [");
}

//argument_list::= expression { "," expression }
//;

void Cl::argument_list()
{
	Cl::expression();
	while (ct->getToken()->getType() == ",")
	{
		ct->nextToken();
		Cl::expression();
	}
}

//member_refz::= "." identifier [ fn_arr_member ] [ member_refz ]
//;

void Cl::member_refz()
{
	if (ct->getToken()->getType() == ".")
	{
		ct->nextToken();
		if (ct->getToken()->getType() == "Identifier")
		{
			ct->nextToken();
			//success, check optional terminal [fn_arr_member]
			if (ct->getToken()->getType() == "(")
			{
				Cl::fn_arr_member();
			}
			//check optional terminal [member_refz]
			if (ct->getToken()->getType() == ".")
			{
				Cl::member_refz();
			}
		}
		else
			genError("An Identifier");
	}
	else
		genError(".");
}

//expressionz::= 
//"=" assignment_expression
//| "&&" expression
//| "||" expression
//| "==" expression
//| "!=" expression
//| "<=" expression
//| ">=" expression
//| "<" expression
//| ">" expression
//| "+" expression
//| "-" expression
//| "*" expression
//| "/" expression
//;

void Cl::expressionz()
{
	//"=" assignment_expression
	if (ct->getToken()->getType() == "Assignment Operator")
	{
		ct->nextToken();
		Cl::assignment_expression();
	}
	// "&&" expression  | "||" expression  | "==" expression  | "!=" expression  | "<=" expression  | ">=" expression  | "<" expression  | ">" expression
	// | "+" expression | "-" expression | "*" expression | "/" expression
	else if (ct->getToken()->getType() == "Logical Connective Operator" || ct->getToken()->getType() == "Relational Operator" || ct->getToken()->getType() == "Plus Operator"
		|| ct->getToken()->getType() == "Minus Operator" || ct->getToken()->getType() == "Math Operator")
	{
		ct->nextToken();
		Cl::expression();
	}
}

//asignment_expression::=
// expression
//| "this"
//| "new" type new_declaration
//| "atoi" "(" expression ")"
//| "itoa" "(" expression ")"
//;

void Cl::assignment_expression()
{
	// expression
	if (ct->getToken()->getType() == "(" || ct->getToken()->getType() == "true" || ct->getToken()->getType() == "false" || ct->getToken()->getType() == "null" || ct->getToken()->getType() == "Plus Operator"
		|| ct->getToken()->getType() == "Minus Operator" || ct->getToken()->getType() == "Number" || ct->getToken()->getType() == "Character" || ct->getToken()->getType() == "Identifier")
	{
		Cl::expression();
	}
	// "this"
	else if (ct->getToken()->getType() == "this"){ ct->nextToken(); }
	// "new" type new_declaration
	else if (ct->getToken()->getType() == "new")
	{
		ct->nextToken();
		Cl::type();
		Cl::new_declaration();
	}
	// "atoi" "(" expression ")"
	else if (ct->getToken()->getType() == "atoi")
	{
		ct->nextToken();
		if (ct->getToken()->getType() == "(")
		{
			ct->nextToken();
			Cl::expression();
			if (ct->getToken()->getType() == ")")
			{
				//success
			}
			else
				genError(")");
		}
		else
			genError("(");
	}
	// "itoa" "(" expression ")"
	else if (ct->getToken()->getType() == "itoa")
	{
		ct->nextToken();
		if (ct->getToken()->getType() == "(")
		{
			ct->nextToken();
			Cl::expression();
			if (ct->getToken()->getType() == ")")
			{
				ct->nextToken();//success
			}
			else
				genError(")");
		}
		else
			genError("(");
	}
	else
		genError("A valid expression or keyword: this, new, atoi, or itoa");
}

//new_declaration::=
// "(" [ argument_list ] ")"
// "[" expression "]"
//;

void Cl::new_declaration()
{
	if (ct->getToken()->getType() == "(")
	{
		ct->nextToken();
		//optional [ argument_list]
		if (ct->getToken()->getType() == "(" || ct->getToken()->getType() == "true" || ct->getToken()->getType() == "false" || ct->getToken()->getType() == "null" || ct->getToken()->getType() == "Plus Operator"
			|| ct->getToken()->getType() == "Minus Operator" || ct->getToken()->getType() == "Number" || ct->getToken()->getType() == "Character" || ct->getToken()->getType() == "Identifier")
		{
			Cl::argument_list();
		}

		if (ct->getToken()->getType() == ")")
			ct->nextToken();
		else
			genError(")");
	}
	else if (ct->getToken()->getType() == "[")
	{
		ct->nextToken();
		Cl::expression();
		if (ct->getToken()->getType() == "]")
			ct->nextToken();
		else
			genError("]");
	}
	else
		genError("( or [");
}

void Cl::genError(string expected)
{
	cout << "line number: " << ct->getLineNum() << " ( Found: '" << ct->getToken()->getLexem() << "', Expected: '" << expected << "' )." << endl;
}