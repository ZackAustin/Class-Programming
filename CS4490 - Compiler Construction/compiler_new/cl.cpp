#include "cl.h"

const int MAX_ERRORS = 3;
int Cl::phase = 1;

//0 is RTN ADDR, -4 is the PFP, -8 is THIS. We start at -12.
int Cl::stackBase = -12;

#define SSTR( x ) dynamic_cast< std::ostringstream & >( \
        ( std::ostringstream() << std::dec << x ) ).str()

//pass debugargs into cl along with the pass phase. This object is the parser.

Cl::Cl(compilerArgs* debug, Scanner* lexer, ST* symbolTable) : argumentList(debug), ct(lexer), st(symbolTable)
{
	errorCount = 0;
	pass1 = true, pass2 = false;
}

Cl::Cl(compilerArgs* debug, Scanner* lexer, ST* symbolTable, OS* operatorStack, SAS* semanticStack, ICGenerator* icg, ICGenerator* sticg)
	: argumentList(debug), ct(lexer), st(symbolTable), os(operatorStack), sas(semanticStack), icgen(icg), staticicgen(sticg)
{
	errorCount = 0;
	pass1 = false, pass2 = true;
}

Cl::~Cl(){}

//setup our ST for inserts.

//Start writing Cl from compilation_unit until x = y; works.
//Then try x=y; Then start adding statements that utilize expression, expressionz, and assignment_expression.
//Then start addons to statement which eventually adds to ST.

//modifier::= "unprotected" | "protected"
void Cl::modifier()
{
	argumentList->debugPrint(std::string{"Called modifier.\n"}, argumentList->debuggingParser);

	if (ct->token->lexem == "unprotected")
	{
		if (tokenAttributes.size() > 0)
			tokenAttributes.back().push_back(ct->token->lexem);
		ct->nextToken();
	}
	else if (ct->token->lexem == "protected")
	{
		if (tokenAttributes.size() > 0)
			tokenAttributes.back().push_back(ct->token->lexem);
		ct->nextToken();
	}
	else genError("protected or unprotected.");
}

//type::= "int" | "char" | "bool" | "void" | "sym" | class_name
void Cl::type()
{
	argumentList->debugPrint(std::string{"Called type.\n"}, argumentList->debuggingParser);
	
	if (aType(ct->token))
	{
		if (ct->token->lexem == "int" || ct->token->lexem == "char" || ct->token->lexem == "bool" || ct->token->lexem == "void" || ct->token->lexem == "sym")
		{
			if(st->insert(new STData(ct->lineNumber, "g", st->genSym("S"), ct->token->lexem, "literal", nullptr)))
				genError("A unique Identifier.", "Duplicate " + ct->token->lexem);
		}

		if (pass2) //#tPush
		{
			tPush(ct->token->lexem);
		}

		if (tokenAttributes.size() > 0)
			tokenAttributes.back().push_back(ct->token->lexem);
		ct->nextToken();
	}
	else genError("a type of: int, char, bool, void, sym, or user-defined.");
}

//charcacter_literal::= "\'" character "\'"
void Cl::character_literal()
{
	argumentList->debugPrint(std::string{"Called character_literal.\n"}, argumentList->debuggingParser);

	if (ct->token->lexem == "'")
	{
		tokenAttributes.push_back(std::vector<std::string>{});
		tokenAttributes.back().push_back(ct->token->lexem);

		if (ct->kxiFile.peek() == ' ')
		{
			 delete ct->token;
			ct->token = new Token(" ", "Character");
		}
		else ct->nextToken();
		
		character();
		if (ct->token->lexem == "'")
		{
			tokenAttributes.back().push_back(ct->token->lexem);
			std::string literalValue = "";
				for (size_t i = 0; i < tokenAttributes.back().size(); i++)
					literalValue += tokenAttributes.back()[i];

			if (pass1)
			{
				if(st->insert(new STData(ct->lineNumber, "g", st->genSym("S"), literalValue, "literal", new varData("0", "char", "unprotected"))))
					genError("A unique Identifier.", "Duplicate " + literalValue);
			}

			if (pass2) //#lPush
			{
				lPush(literalValue);
			}

			tokenAttributes.pop_back();

			ct->nextToken();
		}
		else genError("a '");
	}
	else genError("a '");
}

//numeric_literal::= ["+" | "-"] number
void Cl::numeric_literal()
{
	argumentList->debugPrint(std::string{"Called numeric_literal.\n"}, argumentList->debuggingParser);

	tokenAttributes.push_back(std::vector<std::string>{});
		
	if (ct->token->lexem == "+" || ct->token->lexem == "-")
	{
		tokenAttributes.back().push_back(ct->token->lexem);
		ct->nextToken();
	}
	number();

	std::string literalValue = "";
		for (size_t i = 0; i < tokenAttributes.back().size(); i++)
			literalValue += tokenAttributes.back()[i];

	if (pass1)
	{
		if(st->insert(new STData(ct->lineNumber, "g", st->genSym("S"), literalValue, "literal", new varData("0", "int", "unprotected"))))
			genError("A unique Identifier.", "Duplicate " + literalValue);
	}

	if (pass2) //#lPush
	{
		lPush(literalValue);
	}
	tokenAttributes.pop_back();
}

//number::= "0"{number} | "1"{number} | etc...
void Cl::number()
{
	argumentList->debugPrint(std::string{"Called number.\n"}, argumentList->debuggingParser);

	if (aNumber(ct->token))
	{
		if (tokenAttributes.size() > 0)
			tokenAttributes.back().push_back(ct->token->lexem);
		ct->nextToken();
		while (aNumber(ct->token))
		{
			number();
		}
	}
	else genError("a number");
}

void Cl::character()
{
	argumentList->debugPrint(std::string{"Called character.\n"}, argumentList->debuggingParser);

	//nonprintable ascii.
	if (ct->token->lexem == "\\")
	{
		if (tokenAttributes.size() > 0)
			tokenAttributes.back().push_back(ct->token->lexem);
		ct->nextToken();
		if (ct->token->lexem.size() == 1 && (ct->token->lexem.at(0) >= 32 && ct->token->lexem.at(0) <= 126))
		{
			if (tokenAttributes.size() > 0)
				tokenAttributes.back().push_back(ct->token->lexem);
			ct->nextToken();
		}
		else genError("an ascii value between 0-31 or 127.");
	}
	//printable ascii.
	else if (ct->token->lexem.size() == 1 && (ct->token->lexem.at(0) >= 32 && ct->token->lexem.at(0) <= 126))
	{
		if (tokenAttributes.size() > 0)
			tokenAttributes.back().push_back(ct->token->lexem);
		ct->nextToken();
	}
	else genError("an ascii value between 32 and 126 or a '\\'.");
}

// Start Symbol
// compilation_unit::=  {class_declaration}  "void" "kxi2015" "main" "(" ")" method_body

void Cl::compilation_unit()
{
	argumentList->debugPrint(std::string{"Called compilation_unit.\n"}, argumentList->debuggingParser);

	inSpawn = false;
	firstStackComputeOfPhase2 = false;
	//insert into ST size of types for a char / bool, and int / pointer.

	if (pass1)
	{
		//S0 and S1. S0 is 1 byte, S1 is 4 bytes. S2 holds number 0.
		if(st->insert(new STData(ct->lineNumber, "g", st->genSym("S"), "1", "literal", new varData("0", "int", "unprotected"))))
			genError("A unique Identifier.", "Duplicate 1");

		if(st->insert(new STData(ct->lineNumber, "g", st->genSym("S"), "4", "literal", new varData("0", "int", "unprotected"))))
			genError("A unique Identifier.", "Duplicate 4");

		if(st->insert(new STData(ct->lineNumber, "g", st->genSym("S"), "0", "literal", new varData("0", "int", "unprotected"))))
			genError("A unique Identifier.", "Duplicate 4");
	}

	if (pass2) //SETUP AND CALL MAIN FIRST.
	{
		createICodeStatement("", "FRAME", "g_main", "blank", "", "Create an activation record");
		createICodeStatement("", "CALL", "g_main", "", "", "Invoke the function");
		createICodeStatement("HALT", "TRP0", "", "", "", "");
		isCtor = false;
		firstStackComputeOfPhase2 = true;
	}

	//get first token.
	ct->nextToken();

	//{class_declaration} zero or more.
	while (aClass_declaration(ct->token))
	{
		class_declaration();
	}

	tokenAttributes.push_back(std::vector<std::string>{});

	if (ct->token->lexem == "void")
	{
		tokenAttributes.back().push_back(ct->token->lexem);
		ct->nextToken();
		if (ct->token->lexem == "kxi2015")
		{
			ct->nextToken();
			if (ct->token->lexem == "main")
			{
				scopeTokens.push_back(ct->token->lexem);
				tokenAttributes.back().push_back(ct->token->lexem);
				ct->nextToken();
				if (ct->token->lexem == "(")
				{
					ct->nextToken();
					if (ct->token->lexem == ")")
					{
						if (pass1)
						{
							if(st->insert(new STData(ct->lineNumber, st->scope, st->genSym("M"), scopeTokens.back(), "method", new methodData(SSTR(Cl::stackBase), tokenAttributes.back().front(), "[]", "unprotected"))))
								genError("A unique Identifier.", "Duplicate " + scopeTokens.back());
						}

						tokenAttributes.clear();

						ct->nextToken();
						method_body();
					}
					else genError("')");
				}
				else genError("'('");

			}
			else genError("keyword: main.");
		}
		else genError("keyword: kxi2015.");
	}
	else genError("keyword: void.");

	if (ct->token->tokenType != "EOF")
		genError("End of File.");

	std::ostringstream ss;
	ss << Cl::phase++;

	argumentList->debugPrint(std::string{"Finished Parse Phase " + ss.str() + ".\n"}, argumentList->debuggingParser);

	if (errorCount > 0)
	{
		std::ostringstream ss;
		ss << errorCount;
		throw std::runtime_error("\n " + ss.str() + " errors.\n");
	}
}

//Declarations
//class_declaration::= "class" class_name "{" {class_member_declaration} "}"

void Cl::class_declaration()
{
	argumentList->debugPrint(std::string{"Called class_declaration.\n"}, argumentList->debuggingParser);

	if (ct->token->lexem == "class")
	{
		ct->nextToken();
		if (ct->token->tokenType == "Identifier")
		{
			scopeTokens.push_back(ct->token->lexem);
			std::string tmpID = ct->token->lexem;
			STData* newClass = nullptr;
			if (pass1)
			{
				//class name
				newClass = new STData(ct->lineNumber, st->scope, st->genSym("C"), tmpID, "Class", new classData("0", tmpID));
				if(st->insert(newClass))
					genError("A unique Identifier.", "Duplicate " + tmpID);

				//it's static initializer function insert.
				if(st->insert(new STData(ct->lineNumber, st->scope + "." + tmpID, st->genSym("M"), "StaticInit", "method", new methodData(SSTR(Cl::stackBase), "void", "", "protected"))))
					genError("A unique Identifier.", "Duplicate StaticInit");
			}

			tokenAttributes.clear();

			ct->nextToken();
			if (ct->token->lexem == "{")
			{
				st->scope += "." + scopeTokens.back();

				//ICode Func for Static Initializer for class.
				if (pass2)
				{
					createICodeStatement("g_" + tmpID + "_StaticInit", "FUNC", "g_" + tmpID + "_StaticInit", "", "", "");
				}

				scopeTokens.pop_back();
				ct->nextToken();
				//{class_member_declaration}
					//reset offset counter.
				classOffsets = 0;
				while (aClass_member_declaration(ct->token))
				{
					class_member_declaration();
				}

				if (pass1)
				{
					newClass->setSize(SSTR(classOffsets));
				}

				if (ct->token->lexem == "}")
				{
					if (pass2)
					{
						//write out RTN for StaticInit of class.
						createICodeStatement("", "RTN", "", "", "", "");

						//write out everything from staticicgen to icgen.
						for (size_t i = 0; i < staticicgen->quads.size(); i++)
							icgen->copyQuad(staticicgen->quads[i]);

						staticicgen->quads.clear();
					}

					st->scope = st->scope.substr(0, st->scope.find_last_of("."));
					ct->nextToken();
				}
				else genError("'}'");
			}
			else genError("'{'");
		}
		else genError("an identifier.");
	}
	else genError("keyword: class");
}

//class_member_declaration::= modifier type identifier field_declaration
//							| constructor_declaration

void Cl::class_member_declaration()
{
	argumentList->debugPrint(std::string{"Called class_member_declaration.\n"}, argumentList->debuggingParser);

	if (aModifier(ct->token))
	{
		tokenAttributes.push_back(std::vector<std::string>{});
		modifier();
		type();

		if (pass2) //#tExist
		{
			tExist();
		}

		if (ct->token->tokenType == "Identifier")
		{
			scopeTokens.push_back(ct->token->lexem);
			tokenAttributes.back().push_back(ct->token->lexem);
			idTokens.push_back(ct->token->lexem);
			ct->nextToken();
			field_declaration();
		}
		else genError("an identifier.");
	}
	else if (aConstructor_declaration(ct->token))
	{
		constructor_declaration();
	}
	else genError("a modifier or constructor_declaration.");
}

//field_declaration::= [ "[" "]" ] ["=" assignment_expression] ";"
//					|  "(" [parameter_list] ")" method_body

void Cl::field_declaration()
{
	argumentList->debugPrint(std::string{"Called field_declaration.\n"}, argumentList->debuggingParser);

	if (ct->token->lexem == "[" || ct->token->lexem == "=" || ct->token->lexem == ";")
	{
		if (ct->token->lexem == "[")
		{
			ct->nextToken();
			if (ct->token->lexem == "]")
			{
				tokenAttributes.back()[1] = "@:" + tokenAttributes.back()[1];
				ct->nextToken();
			}
			else genError("']'");
		}

		if (pass2) //vPush
		{
			vPush(tokenAttributes.back().back());
		}

		if (ct->token->lexem == "=")
		{
			if (pass2) //#oPush
			{
				oPush(ct->token->lexem);
			}

			ct->nextToken();
			assignment_expression();
		}
		if (ct->token->lexem == ";")
		{
			if (pass1)
			{
				if(st->insert(new STData(ct->lineNumber, st->scope, st->genSym("V"), idTokens.back(), "ivar", new varData(SSTR(classOffsets), tokenAttributes.back()[1], tokenAttributes.back().front()))))
					genError("A unique Identifier.", "Duplicate " + idTokens.back());
				computeInstanceOffset(tokenAttributes.back()[1]);
				idTokens.pop_back();
			}

			if (pass2) //#EOE
			{
				EOE();
			}

			tokenAttributes.clear();

			ct->nextToken();
		}
		else genError("';'");
	}
	else if (ct->token->lexem == "(")
	{
		ct->nextToken();
		if (aParameter_list(ct->token))
		{
			parameter_list();
		}
		if (ct->token->lexem == ")")
		{
			if (pass1)
			{
				//parameter references for function.
				std::string tmpParams = "[";
				std::ostringstream ss;
				for (size_t i = 1; i < tokenAttributes.size(); i++)
				{
					ss.str(std::string());
					ss << st->symbolCounter + i;
					tmpParams += "P" + ss.str() + ", ";
				}
				if (tmpParams.find(','))
					tmpParams = tmpParams.substr(0, tmpParams.find_last_of(",")) + "]";
				else tmpParams += "]";
				
				//function insert.
				if(st->insert(new STData(ct->lineNumber, st->scope, st->genSym("M"), tokenAttributes.front().back(), "method", new methodData(SSTR(Cl::stackBase), tokenAttributes.front()[1], tmpParams, tokenAttributes.front().front()))))
					genError("A unique Identifier.", "Duplicate " + tokenAttributes.front().back());
			}

			ct->nextToken();
			method_body();
		}
		else genError("')'");
	}
	else genError("'[', '=', ';', or '('");
}

//constructor_declaration::= class_name "(" [parameter_list] ")" method_body
void Cl::constructor_declaration()
{
	argumentList->debugPrint(std::string{"Called constructor_declaration.\n"}, argumentList->debuggingParser);

	tokenAttributes.push_back(std::vector<std::string>{});

	if (ct->token->tokenType == "Identifier")
	{
		scopeTokens.push_back(ct->token->lexem);
		tokenAttributes.back().push_back(ct->token->lexem);


		if (pass2) //#CD
		{
			CD(ct->token->lexem);
		}

		ct->nextToken();
		if (ct->token->lexem == "(")
		{
			ct->nextToken();
			if (aParameter_list(ct->token))
			{
				parameter_list();
			}
			if (ct->token->lexem == ")")
			{
				if (pass1)
				{
					//parameter references for function.
					std::string tmpParams = "[";
					std::ostringstream ss;
					for (size_t i = 1; i < tokenAttributes.size(); i++)
					{
						ss.str(std::string());
						ss << st->symbolCounter + i;
						tmpParams += "P" + ss.str() + ", ";
					}
					if (tmpParams.find(','))
						tmpParams = tmpParams.substr(0, tmpParams.find_last_of(",")) + "]";
					else tmpParams += "]";
				
					//function insert.
					if(st->insert(new STData(ct->lineNumber, st->scope, st->genSym("M"), tokenAttributes.front().back(), "method", new methodData(SSTR(Cl::stackBase), "void", tmpParams, "unprotected"))))
						genError("A unique Identifier.", "Duplicate " + tokenAttributes.front().back());
				}

				ct->nextToken();

				if (pass2)
				{
					isCtor = true;
				}
				cTorReturn = true;
				method_body();
				isCtor = false;
				cTorReturn = false;
			}
			else genError("')'");
		}
		else genError("'('");
	}
	else genError("an identifier.");
}

//method_body::=  "{" {variable_declaration} {statement} "}"

void Cl::method_body()
{
	argumentList->debugPrint(std::string{"Called method_body.\n"}, argumentList->debuggingParser);

	mb_scopeTokens.push_back(st->scope);
	st->scope += "." + scopeTokens.back();
	scopeTokens.pop_back();
	//reset offsets for new stack.
		//0 is RTN ADDR, -4 is the PFP, -8 is THIS. We start at -12.
	stackOffsets = Cl::stackBase - 1; //11 because we compute size of types first. So char / bool at -12, ints at -15 (15,14,13,12).

	if (ct->token->lexem == "{")
	{
		if (pass1)
		{
			//parameters insert.
			for (size_t i = 1; i < tokenAttributes.size(); i++)
			{
				computeStackOffset(tokenAttributes[i].front(), st->scope);

				if(st->insert(new STData(ct->lineNumber, st->scope, st->genSym("P"), tokenAttributes[i].back(), "param", new varData(SSTR(stackOffsets), tokenAttributes[i].front(), "protected"))))
					genError("A unique Identifier.", "Duplicate " + tokenAttributes[i].back());
			}
		}

		if (pass2)
		{
			std::string functionLabel = st->scope;
			std::replace(functionLabel.begin(), functionLabel.end(), '.', '_');
			functionLabel = functionLabel.substr(2);
			createICodeStatement("g_" + functionLabel, "FUNC", "g_" + functionLabel, "", "", "");

			if (isCtor) //Call Static_Initializer if this is a constructor.
			{
				std::string frameName = st->scope.substr(st->scope.find_first_of(".") + 1, st->scope.find_last_of(".") - 2);
				std::replace(frameName.begin(), frameName.end(), '.', '_');
				createICodeStatement("", "FRAME", "g_" + frameName + "_StaticInit", "this", "", "Create an activation record");
				createICodeStatement("", "CALL", "g_" + frameName + "_StaticInit", "", "", "Invoke the function");
			}
			isCtor = false;
		}

		tokenAttributes.clear();

		ct->nextToken();

		//{variable declaration} 0 or more.

		while (aVariable_declaration(ct->token))
		{
			variable_declaration();
		}

		//{statement} 0 or more. Test if it's any of statements types.

		// '{' or, any expression type, if, while, return, cout, cin, spawn, block, lock release.

		while (aStatement(ct->token))
		{
			//it's a statement. go into statement and we run the checks again and consume that token..
			statement();
		}

		//"}"

		if (ct->token->lexem == "}")
		{
			if (pass2)
			{
				if (cTorReturn)
					createICodeStatement("", "RETURN", "this", "", "", "");
				createICodeStatement("", "RTN", "", "", "", "");
			}

			st->scope = st->scope.substr(0, st->scope.find_last_of("."));
			ct->nextToken();
		}
		else genError("'}'");
	}
	else genError("'{'");

	mb_scopeTokens.pop_back();
}

//variable_declaration::= type identifier ["[" "]"] ["=" assignment_expression] ";"

void Cl::variable_declaration()
{
	argumentList->debugPrint(std::string{"Called variable_declaration.\n"}, argumentList->debuggingParser);

	tokenAttributes.push_back(std::vector<std::string>{});
	type();

	if (pass2) //#tExist
	{
		tExist();
	}

	if (ct->token->tokenType == "Identifier")
	{
		tokenAttributes.back().push_back(ct->token->lexem);
		idTokens.push_back(ct->token->lexem);
		ct->nextToken();
		if (ct->token->lexem == "[")
		{
			ct->nextToken();
			if (ct->token->lexem == "]")
			{
				tokenAttributes.back().front() = "@:" + tokenAttributes.back().front();
				ct->nextToken();
			}
			else genError("']'");
		}

		if (pass2) //#vPush
		{
			vPush(tokenAttributes.back().back());
		}

		if (ct->token->lexem == "=")
		{
			if (pass2) //#oPush
			{
				oPush(ct->token->lexem);
			}

			ct->nextToken();
			assignment_expression();
		}
		if (ct->token->lexem == ";")
		{
			if (pass1)
			{
				computeStackOffset(tokenAttributes.back().front(), st->scope);

				if(st->insert(new STData(ct->lineNumber, st->scope, st->genSym("L"), idTokens.back(), "lvar", new varData(SSTR(stackOffsets), tokenAttributes.back().front(), "protected"))))
					genError("A unique Identifier.", "Duplicate " + idTokens.back());
				idTokens.pop_back();
			}

			if (pass2) //#EOE
			{
				EOE();
			}

			tokenAttributes.clear();

			ct->nextToken();
		}
		else genError("';'");
	}
	else genError("an identifier.");
}

//parameter_list::= parameter {"," parameter}

void Cl::parameter_list()
{
	argumentList->debugPrint(std::string{"Called parameter_list.\n"}, argumentList->debuggingParser);

	parameter();

	while (ct->token->lexem == ",")
	{
		ct->nextToken();
		parameter();
	}
}

//parameter::= type identifier [ "[" "]"]

void Cl::parameter()
{
	argumentList->debugPrint(std::string{"Called parameter.\n"}, argumentList->debuggingParser);

	tokenAttributes.push_back(std::vector<std::string>{});
	type();

	if (pass2) //#tExist
	{
		tExist();
	}

	if (ct->token->tokenType == "Identifier")
	{
		tokenAttributes.back().push_back(ct->token->lexem);
		ct->nextToken();
		if (ct->token->lexem == "[")
		{
			ct->nextToken();
			if (ct->token->lexem == "]")
			{
				tokenAttributes.back().front() = "@:" + tokenAttributes.back().front();
				ct->nextToken();
			}
			else genError("']'");
		}
	}
	else genError("an identifier.");
}

// Statement
// statement::=
// "{" {statement} "}"  
// | expression ";"  
// | "if" "(" expression ")" statement [ "else" statement ]  
// | "while" "(" expression ")" statement  
// | "return" [ expression ] ";"  
// | "cout" "<<" expression ";"  
// | "cin" ">>" expression ";"  
// | "spawn" expression "set" identifier ";"  
// | "block" ";"  
// | "lock" identifier ";"  
// | "release" identifier ";"

void Cl::statement()
{
	argumentList->debugPrint(std::string{"Called statement.\n"}, argumentList->debuggingParser);

	std::string elseKeyword = "";

	// "{" {statement} "}"  
	if (ct->token->lexem == "{")
	{
		st->scope += ".{";
		ct->nextToken();
		while (aStatement(ct->token))
		{
			statement();
		}
		if (ct->token->lexem == "}")
		{
			st->scope = st->scope.substr(0, st->scope.find_last_of("."));
			ct->nextToken();
		}
		else genError("'}'");
	}
	// | expression ";" 
	else if (anExpression(ct->token))
	{
		expression();
		if (ct->token->lexem == ";")
		{
			if (pass2) //#EOE
			{
				EOE();
			}

			ct->nextToken();
		}
		else genError("';'");
	}
	// | "if" "(" expression ")" statement [ "else" statement ]
	else if (ct->token->lexem == "if")
	{
		std::string skipElseLabel = "";
		ct->nextToken();
		if (ct->token->lexem == "(")
		{
			if (pass2) //#oPush
			{
				oPush(ct->token->lexem);
			}

			ct->nextToken();
			expression();
			if (ct->token->lexem == ")")
			{
				if (pass2) // #), #if
				{
					semanticClosingParen();
					semanticIf();
				}

				ct->nextToken();
				statement();

				if (pass2) //$skip
				{
					//$skip
					if (ct->token->lexem == "else")
					{
						//JMP SKIPELSE
							//create the skipif label.
						skipElseLabel = st->genSym("skipelse");

						createICodeStatement("", "JMP", skipElseLabel, "", "", "Generate as Part of ELSE");
					}
					//new quad with skipif label.
					if (ifStack.size() > 0)
					{
						createICodeStatement(ifStack.back(), "", "", "", "", "");
						
						ifStack.pop_back();
					}
				}

				if (ct->token->lexem == "else")
				{
					elseKeyword = ct->token->lexem;
					ct->nextToken();
					statement();
				}

				if (pass2) //$else
				{
					//$else
					if (skipElseLabel != "")
					{
						elseStack.push_back(skipElseLabel);
						createICodeStatement(elseStack.back(), "", "", "", "", "");
						elseStack.pop_back();
					}
				}
			}
			else genError("')'");
		}
		else genError("'('");
	}
	// | "while" "(" expression ")" statement  
	else if (ct->token->lexem == "while")
	{
		std::string beginLabel = "";

		if (pass2) //$begin
		{
			beginLabel = st->genSym("begin");
			createICodeStatement(beginLabel, "", "", "", "", "");
		}

		ct->nextToken();
		if (ct->token->lexem == "(")
		{
			if (pass2) //#oPush
			{
				oPush(ct->token->lexem);
			}

			ct->nextToken();
			expression();
			if (ct->token->lexem == ")")
			{
				if (pass2) // #), #while
				{
					semanticClosingParen();
					semanticWhile();
				}

				ct->nextToken();
				statement();

				if (pass2) //$end
				{
					if (beginLabel != "")
					{
						createICodeStatement("", "JMP", beginLabel, "", "", "");
					}

					if (whileStack.size() > 0)
					{
						createICodeStatement(whileStack.back(), "", "", "", "", "");
						whileStack.pop_back();
					}
				}
			}
			else genError("')'");
		}
		else genError("'('");
	}
	// | "return" [ expression ] ";" 
	else if (ct->token->lexem == "return")
	{
		ct->nextToken();
		if (anExpression(ct->token))
		{
			expression();
		}
		if (ct->token->lexem == ";")
		{
			if (pass2) //#return
			{
				semanticReturn();
			}
			ct->nextToken();
		}
		else genError("';'");
	}
	// | "cout" "<<" expression ";"
	else if (ct->token->lexem == "cout")
	{
		ct->nextToken();
		if (ct->token->lexem == "<<")
		{
			ct->nextToken();
			expression();
			if (ct->token->lexem == ";")
			{
				if (pass2) //#return
				{
					semanticCout();
				}
				ct->nextToken();
			}
			else genError("';'");
		}
		else genError("'<<'");
	}
	// | "cin" ">>" expression ";"  
	else if (ct->token->lexem == "cin")
	{
		ct->nextToken();
		if (ct->token->lexem == ">>")
		{
			ct->nextToken();
			expression();
			if (ct->token->lexem == ";")
			{
				if (pass2) //#return
				{
					semanticCin();
				}
				ct->nextToken();
			}
			else genError("';'");
		}
		else genError("'>>'");
	}
	// | "spawn" expression "set" identifier ";"
	else if (ct->token->lexem == "spawn")
	{
		inSpawn = true;
		ct->nextToken();
		expression();
		if (ct->token->lexem == "set")
		{
			ct->nextToken();
			if (ct->token->tokenType == "Identifier")
			{
				ct->nextToken();
				if (ct->token->lexem == ";")
				{
					ct->nextToken();
				}
				else genError("';'");
			}
			else genError("identifier");
		}
		else genError("'set'");
		inSpawn = false;
	}
	// | "block" ";"
	else if (ct->token->lexem == "block")
	{
		ct->nextToken();
		if (ct->token->lexem == ";")
		{
			ct->nextToken();
		}
		else genError("';'");
	}
	// | "lock" identifier ";"
	else if (ct->token->lexem == "lock")
	{
		ct->nextToken();
		if (ct->token->tokenType == "Identifier")
		{
			ct->nextToken();
			if (ct->token->lexem == ";")
			{
				ct->nextToken();
			}
			else genError("';'");
		}
		else genError("identifier");
	}
	// | "release" identifier ";"
	else if (ct->token->lexem == "release")
	{
		ct->nextToken();
		if (ct->token->tokenType == "Identifier")
		{
			ct->nextToken();
			if (ct->token->lexem == ";")
			{
				ct->nextToken();
			}
			else genError("';'");
		}
		else genError("identifier");
	}
	else genError("'{', '(', boolean, null, literal, or identifier, or keywords: if, while, return, cout, cin, spawn, block, lock, release.");
}

// Expression
// expression::=
// "(" expression ")" [ expressionz ]
// | "true" [ expressionz ]  
// | "false" [ expressionz ]  
// | "null" [ expressionz ]  
// | numeric_literal [ expressionz ]  
// | character_literal [ expressionz ]  
// | identifier [ fn_arr_member ] [ member_refz ] [ expressionz ]

//NT -> X | Y Z 

void Cl::expression()
{
	argumentList->debugPrint(std::string{"Called expression.\n"}, argumentList->debuggingParser);

	//"(" expression ")" [ expressionz ]
	if (ct->token->lexem == "(")
	{
		if (pass2) //#oPush
		{
			oPush(ct->token->lexem);
		}

		ct->nextToken();
		expression();
		if (ct->token->lexem == ")")
		{
			if (pass2) // #)
			{
				semanticClosingParen();
			}

			ct->nextToken();
		}
		else genError("')'");

		//[expressionz], try all terminals.
		if (anExpressionz(ct->token))
		{
			expressionz();
		}
	}
	// | "true" [ expressionz ]  | "false" [ expressionz ]  | "null" [ expressionz ]
	else if (ct->token->lexem == "true" || ct->token->lexem == "false" || ct->token->lexem == "null")
	{
		std::string literalValue = ct->token->lexem;

		if (pass1)
		{
			if (ct->token->lexem == "true" || ct->token->lexem == "false")
			{
				if(st->insert(new STData(ct->lineNumber, "g", st->genSym("S"), literalValue, "literal", new varData("0", "bool", "unprotected"))))
					genError("A unique Identifier.", "Duplicate " + literalValue);
			}
			else
			{
				if(st->insert(new STData(ct->lineNumber, "g", st->genSym("S"), literalValue, "literal", new varData("0", "ref", "unprotected"))))
					genError("A unique Identifier.", "Duplicate " + literalValue);
			}
		}

		if (pass2) //#lPush
		{
			lPush(literalValue);
		}

		ct->nextToken();

		//[ expressionz ], try all terminals.
		if (anExpressionz(ct->token))
		{
			expressionz();
		}
	}
	// | numeric_literal [ expressionz ] 
	else if (aNumeric_literal(ct->token))
	{
		numeric_literal();
		//[ expressionz ] 
		if (anExpressionz(ct->token))
		{
			expressionz();
		}
	}
	// | character_literal [ expressionz ] 
	else if (ct->token->lexem == "'")
	{
		character_literal();
		//[ expressionz ], try all terminals.
		if (anExpressionz(ct->token))
		{
			expressionz();
		}
	}
	//identifier [ fn_arr_member ] [ member_refz ] [ expressionz ]
	else if (ct->token->tokenType == "Identifier")
	{
		if (pass2) // #iPush
		{
			iPush(ct->token->lexem);
		}

		ct->nextToken();

		//[ fn_arr_member ]
			//For this to work the first non-terminal of member_refz must not be a terminal of fn_arr_member.

		if (aFn_arr_member(ct->token))
		{
			fn_arr_member();
		}

		if (pass2) // #iExist
		{
			iExist();
		}

		//[ member_refz ]
			//For this to work the first non-terminal of expressionz must not be a terminal of member_refz.

		if (aMember_refz(ct->token))
		{
			member_refz();
		}

		//[ expressionz ], try all terminals.
		if (anExpressionz(ct->token))
		{
			expressionz();
		}
		//no error here, it's optional.
	}
	//generate error
	else genError("'(', boolean, null, literal, or identifier.");
}

//fn_arr_member::= "(" [ argument_list ] ")"
//				|  "[" expression "]"

void Cl::fn_arr_member()
{
	argumentList->debugPrint(std::string{"Called fn_arr_member.\n"}, argumentList->debuggingParser);

	if (ct->token->lexem == "(")
	{
		if (pass2) //#oPush, #BAL
		{
			oPush(ct->token->lexem);
			BAL();
		}

		ct->nextToken();

		if (anArgument_list(ct->token))
		{
			argument_list();
		}
		if (ct->token->lexem == ")")
		{
			if (pass2) // #), #EAL, #func
			{
				semanticClosingParen();
				EAL();
				semanticFunc();
			}

			ct->nextToken();
		}
		else genError("')'");
	}
	else if (ct->token->lexem == "[")
	{
		if (pass2) //#oPush
		{
			oPush(ct->token->lexem);
		}

		ct->nextToken();

		expression();

		if (ct->token->lexem == "]")
		{
			if (pass2) // #], #arr
			{
				semanticClosingBracket();
				semanticArr();
			}

			ct->nextToken();
		}
		else genError("']'");
	}
	else genError("a '(' or '['.");
}

//argument_list::= expression {"," expression}
void Cl::argument_list()
{
	argumentList->debugPrint(std::string{"Called argument_list.\n"}, argumentList->debuggingParser);

	expression();

	while (ct->token->lexem == ",")
	{
		if (pass2) //#,
		{
			semanticComma();
		}

		ct->nextToken();
		expression();
	}
}

//member_refz::= "." identifier [fn_arr_member] [member_refz]
void Cl::member_refz()
{
	argumentList->debugPrint(std::string{"Called member_refz.\n"}, argumentList->debuggingParser);

	if (ct->token->lexem == ".")
	{
		ct->nextToken();
		if (ct->token->tokenType == "Identifier")
		{
			if (pass2) //#iPush
			{
				iPush(ct->token->lexem);
			}

			ct->nextToken();
			if (aFn_arr_member(ct->token))
			{
				fn_arr_member();
			}

			if (pass2) //#rExist
			{
				rExist();
			}

			if (aMember_refz(ct->token))
			{
				member_refz();
			}
		}
		else genError("an identifier.");
	}
	else genError("'.'");
}

// expressionz::=
//   "=" assignment_expression 
//   | "&&" expression  /* logical connective expression */  
//   | "||" expression  /* logical connective expression */
//   | "==" expression  /* boolean expression */  
//   | "!=" expression  /* boolean expression */  
//   | "<=" expression  /* boolean expression */  
//   | ">=" expression  /* boolean expression */  
//   | "<" expression  /* boolean expression */  
//   | ">" expression  /* boolean expression */
//   | "+" expression  /* mathematical expression */  
//   | "-" expression  /* mathematical expression */  
//   | "*" expression  /* mathematical expression */  
//   | "/" expression  /* mathematical expression */

void Cl::expressionz()
{
	argumentList->debugPrint(std::string{"Called expressionz.\n"}, argumentList->debuggingParser);

	if (ct->token->lexem == "=")
	{
		if (pass2) //#oPush
		{
			oPush(ct->token->lexem);
		}

		ct->nextToken();
		assignment_expression();
	}
	else if (ct->token->lexem == "&&" || ct->token->lexem == "||" || ct->token->lexem == "=="
		|| ct->token->lexem == "!=" || ct->token->lexem == "<=" || ct->token->lexem == ">="
		|| ct->token->lexem == "<" || ct->token->lexem == ">" || ct->token->lexem == "+"
		|| ct->token->lexem == "-" || ct->token->lexem == "*" || ct->token->lexem == "/")
	{
		if (pass2) //#oPush
		{
			oPush(ct->token->lexem);
		}

		ct->nextToken();
		expression();
	}
	else genError("assignment, logical, boolean, or math operator.");
}

/* assign either an expression, new class object or new array object */
// assignment_expression::=
// expression  
// | "this"
// | "new" type new_declaration 
// | "atoi" "(" expression ")" 
// | "itoa" "(" expression ")"

void Cl::assignment_expression()
{
	argumentList->debugPrint(std::string{"Called assignment_expression.\n"}, argumentList->debuggingParser);

	//check first token of all expressions.
	if (anExpression(ct->token))
	{
		expression();
	}
	else if (ct->token->lexem == "this")
	{
		if (pass2) //#this
		{
			semanticThis();
		}

		ct->nextToken();
	}
	// | "new" type new_declaration 
	else if (ct->token->lexem == "new")
	{
		ct->nextToken();
		type();
		new_declaration();
	}
	// | "atoi" "(" expression ")" 
	else if (ct->token->lexem == "atoi")
	{
		ct->nextToken();
		if (ct->token->lexem == "(")
		{
			if (pass2) //#oPush
			{
				oPush(ct->token->lexem);
			}

			ct->nextToken();
			expression();
			if (ct->token->lexem == ")")
			{
				if (pass2) // #), #atoi
				{
					semanticClosingParen();
					semanticAtoi();
				}

				ct->nextToken();
			}
			else genError("')");
		}
		else genError("'('");
	}
	// | "itoa" "(" expression ")"
	else if (ct->token->lexem == "itoa")
	{
		ct->nextToken();
		if (ct->token->lexem == "(")
		{
			if (pass2) //#oPush
			{
				oPush(ct->token->lexem);
			}

			ct->nextToken();
			expression();
			if (ct->token->lexem == ")")
			{
				if (pass2) // #), #itoa
				{
					semanticClosingParen();
					semanticItoA();
				}

				ct->nextToken();
			}
			else genError("')");
		}
		else genError("'('");
	}
	else genError("expression, or keywords: this, new, atoi, or itoa.");
}

//new_declaration::= "(" [ argument_list ] ")"
//				   | "[" expression "]"
void Cl::new_declaration()
{
	argumentList->debugPrint(std::string{"Called new_declaration.\n"}, argumentList->debuggingParser);

	if (ct->token->lexem == "(")
	{
		if (pass2) //#oPush, #BAL
		{
			oPush(ct->token->lexem);
			BAL();
		}

		ct->nextToken();

		if (anArgument_list(ct->token))
		{
			argument_list();
		}

		if (ct->token->lexem == ")")
		{
			if (pass2) // #), #EAL, #newObj
			{
				semanticClosingParen();
				EAL();
				newObj();
			}

			ct->nextToken();
		}
		else genError("')'");
	}
	else if (ct->token->lexem == "[")
	{
		if (pass2) //#oPush
		{
			oPush(ct->token->lexem);
		}

		ct->nextToken();
		expression();
		if (ct->token->lexem == "]")
		{
			ct->nextToken();

			if (pass2) //#], #new[]
			{
				semanticClosingBracket();
				newArray();
			}
		}
		else genError("']'");
	}
	else genError("'(' or '['");
}

void Cl::genError(std::string expected)
{
	errorCount++;
	std::stringstream is;
	is << ct->lineNumber;
	std::string error = "\nError On Line: " + is.str() + "\nExpected: " + expected + " Found: " + ct->token->lexem + "\n";
	std::cout << error;

	if (argumentList->ofs != nullptr)
		argumentList->debugPrint(error, argumentList->debugging);
	//panic mode recovery.
	PMR();

	inSpawn = false;
	cTorReturn = false;

	if (errorCount > MAX_ERRORS)
		throw std::runtime_error("");
}

void Cl::genError(std::string expected, std::string found)
{
	errorCount++;
	std::stringstream is;
	is << ct->lineNumber;
	std::string error = "\nError On line: " + is.str() + "\nExpected: " + expected + " Found: " + found + ".\n";
	std::cout << error;

	if (argumentList->ofs != nullptr)
		argumentList->debugPrint(error, argumentList->debugging);

	inSpawn = false;
	cTorReturn = false;

	if (errorCount > MAX_ERRORS)
		throw std::runtime_error("");
}

void Cl::genSemError(std::string e)
{
	errorCount++;
	std::stringstream is;
	is << ct->lineNumber;
	std::string error = "\n Error on line: " + is.str() + ". " + e + "\n";
	std::cout << error;

	if (argumentList->ofs != nullptr)
		argumentList->debugPrint(error, argumentList->debugging);

	inSpawn = false;
	cTorReturn = false;

	if (errorCount >= MAX_ERRORS)
		throw std::runtime_error("");
}

void Cl::PMR()
{
	while (ct->token->lexem != ";" && ct->token->lexem != "}" && ct->token->lexem.at(0) != -1)
		ct->nextToken();
	//ct->nextToken();
}

bool Cl::aModifier(Token* t)
{
	if (t->lexem == "unprotected" || t->lexem == "protected")
		return true;
	else return false;
}

bool Cl::aType(Token* t)
{
	if (t->lexem == "int" || t->lexem == "char" || t->lexem == "bool" || t->lexem == "void" || t->lexem == "sym"
		|| t->tokenType == "Identifier")
		return true;
	else return false;
}

bool Cl::aNumeric_literal(Token* t)
{
	if (t->lexem == "+" || t->lexem == "-" || (t->lexem.size() == 1 && t->lexem.at(0) >= 48 && t->lexem.at(0) <= 57))
		return true;
	else return false;
}

bool Cl::aNumber(Token* t)
{
	if (t->lexem.size() == 1 && t->lexem.at(0) >= 48 && t->lexem.at(0) <= 57)
		return true;
	else return false;
}

bool Cl::aClass_declaration(Token* t)
{
	if (t->lexem == "class")
		return true;
	else return false;
}

bool Cl::aClass_member_declaration(Token* t)
{
	if (aModifier(t) || aConstructor_declaration(t))
		return true;
	else return false;
}

bool Cl::aConstructor_declaration(Token* t)
{
	if (t->tokenType == "Identifier")
		return true;
	else return false;
}

bool Cl::aVariable_declaration(Token* t)
{
	if (aType(t))
	{
		ct->peek(1);
		if (ct->peekToken->tokenType == "Identifier")
			return true;
		else return false;
	}
	else return false;
}

bool Cl::aParameter_list(Token* t)
{
	if (aType(t))
		return true;
	else return false;
}

bool Cl::aStatement(Token* t)
{
	if (t->lexem == "{" || anExpression(t) || t->lexem == "if" || t->lexem == "while" || t->lexem == "return"
		|| t->lexem == "cout" || t->lexem == "cin" || t->lexem == "spawn" || t->lexem == "block"
		|| t->lexem == "lock" || t->lexem == "release")
		return true;
	else return false;
}

bool Cl::anExpression(Token* t)
{
	if (t->lexem == "(" || t->lexem == "true" || t->lexem == "false" || t->lexem == "null" || t->lexem == "'"
		||  t->lexem == "'" || aNumeric_literal(t) || t->tokenType == "Identifier")
		return true;
	else return false;
}

bool Cl::aFn_arr_member(Token* t)
{
	if (t->lexem == "(" || t->lexem == "[")
		return true;
	else return false;
}

bool Cl::anArgument_list(Token* t)
{
	if (anExpression(t))
		return true;
	else return false;
}

bool Cl::aMember_refz(Token* t)
{
	if (t->lexem == ".")
		return true;
	else return false;
}

bool Cl::anExpressionz(Token* t)
{
	if (t->lexem == "=" || t->lexem == "&&" || t->lexem == "||" || t->lexem == "==" || t->lexem == "!=" || t->lexem == "<="
		|| t->lexem == ">=" || t->lexem == "<" || t->lexem == ">" || t->lexem == "+" || t->lexem == "-" || t->lexem == "*"
		|| t->lexem == "/")
		return true;
	else return false;
}

void Cl::computeInstanceOffset(std::string type)
{
	if (type.substr(0, 1) == "@:") //pointer to array reference to instance.
		classOffsets += 4;
	else if (type == "bool" || type == "char")
		classOffsets += 1;
	else if (type == "int")
		classOffsets += 4;
	else if (type == "ref")
		classOffsets += 4;
	else if (type != "") //pointer to ref of a class type.
		classOffsets += 4;

}

void Cl::computeStackOffset(std::string type, std::string passedScope)
{
	//find method in ST for current scope. update it's size to reflect offset (for calculating temporaries).
	std::string functionScope = passedScope;

	while (functionScope.substr(functionScope.length() - 2) == ".{")
	{
		functionScope = functionScope.substr(0, functionScope.length() - 2);
	}
	std::string methodName = functionScope.substr(functionScope.find_last_of(".") + 1);
	std::string searchScope = functionScope.substr(0, functionScope.find_last_of("."));
	std::string methodSymID = st->scopeSearch(searchScope, methodName);

	if (methodSymID.at(0) == 'M')
	{
		std::string methodSize = st->symbolTable[methodSymID]->getSize();
		int offset = 0;
		std::istringstream (methodSize) >> offset;

		if (type.substr(0, 1) == "@:") //pointer to array reference to instance.
			offset -= 4;
		else if (type == "bool" || type == "char")
			offset -= 1;
		else if (type == "int")
			offset -= 4;
		else if (type == "ref")
			offset -= 4;
		else if (type != "") //pointer to ref of a class type.
			offset -= 4;
		else offset -= 4;

		stackOffsets = offset + 1;

		st->symbolTable[methodSymID]->setSize(SSTR(offset));
	}
}

void Cl::callOpType(std::string lexem)
{
	if (lexem == "=") // #=
	{
		semanticEqual();
	}
	else if(lexem == "+") // #+
	{
		semanticAdd();
	}
	else if(lexem == "-") // #-
	{
		semanticSubtract();
	}
	else if(lexem == "*") // #*
	{
		semanticMultiply();
	}
	else if(lexem == "/") // #/
	{
		semanticDivide();
	}
	else if(lexem == "<") // #<
	{
		semanticLessThan();
	}
	else if(lexem == "<=") // #<=
	{
		semanticLessThanEqual();
	}
	else if(lexem == ">") // #>
	{
		semanticGreaterThan();
	}
	else if(lexem == ">=") // #>=
	{
		semanticGreaterThanEqual();
	}
	else if(lexem == "==") // #==
	{
		semanticBooleanEqual();
	}
	else if(lexem == "!=") // #!=
	{
		semanticBooleanNotEqual();
	}
	else if(lexem == "&&") // #&&
	{
		semanticAnd();
	}
	else if(lexem == "||") // #||
	{
		semanticOr();
	}
}

void Cl::oPush(std::string lexem)
{
	while(!os->opush(ct->token->lexem))
	{
		Operator* tmpOp = os->pop();
		if (tmpOp != nullptr)
		{
			callOpType(tmpOp->operatorLexem);
		}
	}
	semanticDebug();
}

void Cl::tPush(std::string lexem)
{
	sas->push(new type_SAR(lexem, "#tPush"));

	semanticDebug();
}

void Cl::iPush(std::string lexem)
{
	sas->push(new _sar(lexem, "#iPush"));

	semanticDebug();
}

void Cl::vPush(std::string lexem)
{
	std::string junk = "";

	std::string symID = st->scopeSearch(st->scope, lexem);

	std::string type = st->symbolTable[symID]->getType();
	sas->push(new id_SAR(lexem, type, symID, "#vPush", false));

	semanticDebug();
}

void Cl::lPush(std::string lexem)
{
	std::string symID = st->scopeSearch("g", lexem);
	std::string type = st->symbolTable[symID]->getType();
	sas->push(new id_SAR(lexem, type, symID, "#lPush", false));

	semanticDebug();
}

void Cl::iExist()
{
	argumentList->debugPrint(std::string{"Called iExist.\n"}, argumentList->debuggingParser);

	auto topSar = sas->pop();
	SAR* nextSar = nullptr;
	bool fullyScoped = false;
	std::string searchScope = st->scope;

	try
	{
		bool finished = false;
		std::vector<semanticMessager*> messages;

		while (fullyScoped == false && finished == false)
		{
			if (searchScope == "g")
				fullyScoped = true;

			finished = existence(st->scopeSearch(searchScope, topSar->getName()), "#iExist", topSar, nextSar, fullyScoped, messages);

			searchScope = searchScope.substr(0, searchScope.find_last_of("."));
		}

		for (size_t i = 0; i < messages.size(); ++i)
		{
			delete messages[i];
		}
	}
	catch(...) {genSemError(topSar->getName() + " failed #iExist.");}

	delete topSar;
	semanticDebug();
}

void Cl::rExist()
{
	argumentList->debugPrint(std::string{"Called rExist.\n"}, argumentList->debuggingParser);

	auto topSar = sas->pop();
	auto classSar = sas->pop();

	//get classSar's type, search symbolTable for type, find member x.
	try
	{
		std::string classType = st->symbolTable[classSar->getSymID()]->getType();
		if (classType != "")
		{
			std::string arrayType = classType.substr(0, 2);

			if (arrayType == "@:" && classSar->isArr() == true)
				classType = classType.substr(2);

			std::string classTypeSymID = st->scopeSearch("g", classType);

			std::string searchScope = st->symbolTable[classTypeSymID]->scope + "." + st->symbolTable[classTypeSymID]->value;
			std::vector<semanticMessager*> messages;

			existence(st->scopeSearch(searchScope, topSar->getName()), "#rExist", topSar, classSar, true, messages);

			for (size_t i = 0; i < messages.size(); ++i)
			{
				delete messages[i];
			}
		}
		else genSemError(classSar->getName() + " is not a valid reference.");
	}
	catch(...) {genSemError(topSar->getName() + " failed #rExist.");}

	delete topSar;
	delete classSar;
	semanticDebug();
}

void Cl::tExist()
{
	argumentList->debugPrint(std::string{"Called tExist.\n"}, argumentList->debuggingParser);

	auto typeSar = sas->pop();
	SAR* nextSar = nullptr;
	try
	{
		std::vector<semanticMessager*> messages;
		existence(st->scopeSearch("g", typeSar->getName()), "#tExist", typeSar, nextSar, true, messages);

		for (size_t i = 0; i < messages.size(); ++i)
		{
			delete messages[i];
		}
	}
	catch (...) {genSemError(typeSar->getName() + " failed #tExist.");}
	delete typeSar;

	semanticDebug();
}

void Cl::CD(std::string className)
{
	argumentList->debugPrint(std::string{"Called CD.\n"}, argumentList->debuggingParser);

	//check parameter className matches current scope class Name.
	try
	{
		//get scope class name from current scope.
		std::string scopeClassName = st->scope.substr(2);

		//compare
		if (className != scopeClassName)
			genSemError("Constructor Declaration does not match class name.");
	}
	catch(...){genSemError("Class Name does not exist.");}

	semanticDebug();
}

bool Cl::existence(std::string existence, std::string existType, SAR* &topSar, SAR* &classSar, bool lastScope, std::vector<semanticMessager*> &messages)
{
	argumentList->debugPrint(std::string{"Called existence.\n"}, argumentList->debuggingParser);

	if (existence != "")
	{
		//check sar existence type.
		messages.push_back(topSar->checkExistance(existence, st));

		if(existType == "#rExist" && messages.back()->success == false)
		{
			genSemError(messages.back()->message);
		}
		else if(messages.back()->success)
		{
			//Existence success, grab the type and test if topSar is an array sar.
			std::string type = st->symbolTable[existence]->getType();
			bool asAnArray = false;
			if (topSar->isArr())
			{
				asAnArray = true;
				//It's an array, use the type of for array.
				type = type.substr(2);
			}

			if (existType == "#iExist")
			{
				if (topSar->isArr())
				{
					//create temporary that's used as ref that the symid is an alias of.
					std::string temporary = createSemanticTemporary(type, "Y");
					sas->push(new id_SAR(temporary, type, temporary, existType, asAnArray));
				}
				else
				{
					sas->push(new id_SAR(topSar->getName(), type, existence, existType, asAnArray));
				}

				try
				{
					//ICode for a function frame.
					if (topSar->isFunc())
					{
						std::string frameName = st->symbolTable[existence]->getScope();
						std::replace(frameName.begin(), frameName.end(), '.', '_');
						frameName = frameName.substr(frameName.find_first_of("_") + 1) + "_" + st->symbolTable[existence]->getValue();

						createICodeStatement("", "FRAME", "g_" + frameName, "this", "", "Create an activation record");
						auto funcArgs = topSar->getAL();
						//loop through argument list, pushing args.
						for (unsigned int i = 0; i < funcArgs.size(); i++)
							createICodeStatement("", "PUSH", funcArgs[i]->getSymID(), "", "", "PUSH " + funcArgs[i]->getSymID());
						createICodeStatement("", "CALL", "g_" + frameName, "", "", "Invoke the function");

						if (topSar->getType() != "void")
						{
							std::string peekTemp = "";
							if (topSar->getType() != "char" && topSar->getType() != "int" && topSar->getType() != "bool")
								peekTemp = createSemanticTemporary(topSar->getType(), "N");
							else peekTemp = createSemanticTemporary(topSar->getType(), "N");


							createICodeStatement("", "PEEK", peekTemp, "", "", "");
							sas->sas.back()->setSymID(peekTemp);
						}
					}
					else if(topSar->isArr())
					{
						createICodeStatement("", "AEF", existence, topSar->getAL().back()->getSymID(), sas->sas.back()->getSymID(), "compute address");
					}
				}
				catch(...){}
			}
			else if (existType == "#rExist")
			{
				//check that it's unprotected.
				if (st->symbolTable[existence]->data->getAccessMod() == "unprotected")
				{
					std::string temporary = "";
					if (topSar->isArr())
					{
						temporary = createSemanticTemporary(st->symbolTable[existence]->getType(), "Y");
						sas->push(new ref_SAR(classSar->getName() + "." + topSar->getName(), type, st->symbolTable[temporary]->symID, existType, asAnArray));
						//create temporary that's used as ref that the symid is an alias of.
						std::string arrTemporary = createSemanticTemporary(type, "Y");
						sas->push(new ref_SAR(arrTemporary, type, arrTemporary, existType, asAnArray));
					}
					else
					{
						temporary = createSemanticTemporary(st->symbolTable[existence]->getType(), "Y");
						sas->push(new ref_SAR(classSar->getName() + "." + topSar->getName(), type, st->symbolTable[temporary]->symID, existType, asAnArray));
					}
					try
					{
						//ICode for a function frame.
						if (topSar->isFunc())
						{
							std::string frameName = st->symbolTable[existence]->getScope();
							std::replace(frameName.begin(), frameName.end(), '.', '_');
							frameName = frameName.substr(frameName.find_first_of("_") + 1) + "_" + st->symbolTable[existence]->getValue();

							createICodeStatement("", "FRAME", "g_" + frameName, classSar->getSymID(), "", "Create an activation record");
							auto funcArgs = topSar->getAL();
							//loop through argument list, pushing args.
							for (unsigned int i = 0; i < funcArgs.size(); i++)
								createICodeStatement("", "PUSH", funcArgs[i]->getSymID(), "", "", "PUSH  " + funcArgs[i]->getSymID());
							createICodeStatement("", "CALL", "g_" + frameName, "", "", "Invoke the function");

							if (topSar->getType() != "void")
							{
								// std::string peekTemp = "";
								// if (topSar->getType() != "char" && topSar->getType() != "int" && topSar->getType() != "bool")
								// 	peekTemp = createSemanticTemporary(topSar->getType(), "Y");
								// else peekTemp = createSemanticTemporary(topSar->getType(), "N");

								createICodeStatement("", "PEEK", temporary, "", "", classSar->getName() + " + offset(" + topSar->getName() + ")" + " -> " + temporary);
							}
						}
						else if(topSar->isArr())
						{
							createICodeStatement("", "AEF", existence, topSar->getAL().back()->getSymID(), sas->sas.back()->getSymID(), "compute address");
						}
						else
							createICodeStatement("", "REF", classSar->getSymID(), existence, temporary, classSar->getName() + " + offset(" + topSar->getName() + ")" + " -> " + temporary);
					}
					catch(...){}
				}
				else genSemError(st->symbolTable[existence]->value + " is protected.");
			}
			else if (existType == "#tExist")
			{

			}
			return true;
		}
	}
	else if (lastScope == true)
	{
		std::string possibleMessages = "";
		for (size_t i = 0; i < messages.size(); i++)
		{
			possibleMessages = messages[i]->message + "\n";
		}
		if (possibleMessages != "")
			genSemError(topSar->getName() + " does not exist. Possible errors include:\n\t" + possibleMessages);
		else genSemError(topSar->getName() + " does not exist.");
		return false;
	}
	return false;
}

void Cl::semanticIf()
{
	argumentList->debugPrint(std::string{"Called semanticIf.\n"}, argumentList->debuggingParser);

	//test if top sar is of type boolean.
	auto topSar = sas->pop();

	if (topSar->getType() != "bool")
		genSemError("Expression is not of type bool.");

	semanticDebug();

	std::string leftSide = "";
	//going to be top label on if stack. gensym that label.
	try
	{
		auto lhST = st->symbolTable[topSar->getSymID()];
		leftSide = lhST->getSymID();
	}
	catch(...){}
	
	//create the skipif label.
	ifStack.push_back(st->genSym("skipif"));
	std::string rightSide = ifStack.back();

	createICodeStatement("", "BF", leftSide, rightSide, "", "BranchFalse " + leftSide + ", " + rightSide);

	delete topSar;
}
	
void Cl::semanticWhile()
{
	argumentList->debugPrint(std::string{"Called semanticWhile.\n"}, argumentList->debuggingParser);
	//test if top sar is of type boolean.
	auto topSar = sas->pop();

	if (topSar->getType() != "bool")
		genSemError("Expression is not of type bool.");

	semanticDebug();

	std::string leftSide = "";
	//going to be top label on if stack. gensym that label.
	try
	{
		auto lhST = st->symbolTable[topSar->getSymID()];
		leftSide = lhST->getSymID();
	}
	catch(...){}
	
	//create the skipif label.
	whileStack.push_back(st->genSym("endWhile"));
	std::string rightSide = whileStack.back();

	createICodeStatement("", "BF", leftSide, rightSide, "", "BranchFalse " + leftSide + ", " + rightSide);

	delete topSar;
}

void Cl::semanticReturn()
{
	argumentList->debugPrint(std::string{"Called semanticReturn.\n"}, argumentList->debuggingParser);

	//eoe, then check if final expression matches return type of function were currently parsing.
	EOE();

	std::string functionScope = st->scope;
	auto topSar = sas->pop();

	try
	{
		//take current scope and while last two characters equal ".{" remove them.
		while (functionScope.substr(functionScope.length() - 2) == ".{")
		{
			functionScope = functionScope.substr(0, functionScope.length() - 2);
		}

		std::string functionName = functionScope.substr(functionScope.find_last_of(".") + 1);
		std::string searchScope = functionScope.substr(0, functionScope.find_last_of("."));

		//get return type of function.
		std::string funcSYMID = st->scopeSearch(searchScope, functionName);
		std::string returnType = st->symbolTable[funcSYMID]->getType();

		
		//if (returnType == "void")
		//	genSemError("Found keyword: Return, Expected: '}'");

		//test if the top sar on the SAS is the same value as function return type.
		if (returnType != topSar->getType())
			genSemError("Return type is not of type " + returnType + ".");

		createICodeStatement("", "RETURN", topSar->getSymID(), "", "", "");
	}
	catch(...){genSemError("Failed #return.");}

	semanticDebug();

	delete topSar;
}

void Cl::semanticCout()
{
	argumentList->debugPrint(std::string{"Called semanticCout.\n"}, argumentList->debuggingParser);

	//eoe, check if final expressions matches a type that can be printed (int or char).
	EOE();

	auto topSar = sas->pop();

	try
	{
		if (topSar->getType() != "int" && topSar->getType() != "char")
			genSemError(topSar->getType() + " is not a printable type.");
	}
	catch(...){genSemError("Failed #Cout.");}

	semanticDebug();

	try
	{
		if (topSar->getType() == "int")
			createICodeStatement("", "WRITE", "1", topSar->getSymID(), "", "Write out int: " + topSar->getSymID());
		else if (topSar->getType() == "char")
			createICodeStatement("", "WRITE", "2", topSar->getSymID(), "", "Write out char: " + topSar->getSymID());
	}
	catch(...){}

	delete topSar;
}

void Cl::semanticCin()
{
	argumentList->debugPrint(std::string{"Called semanticCin.\n"}, argumentList->debuggingParser);

	//eoe, check if final expressions matches a type that can be printed (int or char).
	EOE();

	auto topSar = sas->pop();

	try
	{
		std::string dataKind = st->symbolTable[topSar->getSymID()]->getKind();

		if (dataKind == "literal")
			genSemError("Constant data are not a readable type.");

		if (topSar->getType() != "int" && topSar->getType() != "char")
			genSemError(topSar->getType() + " is not a readable type.");
	}
	catch(...){genSemError("Failed #Cout.");}

	semanticDebug();
	try
	{
		if (topSar->getType() == "int")
			createICodeStatement("", "READ", "1", topSar->getSymID(), "", "Read in int: " + topSar->getSymID());
		else if (topSar->getType() == "char")
			createICodeStatement("", "READ", "2", topSar->getSymID(), "", "Read in char: " + topSar->getSymID());
	}
	catch(...){}

	delete topSar;
}

void Cl::semanticAtoi()
{
	argumentList->debugPrint(std::string{"Called semanticAtoi.\n"}, argumentList->debuggingParser);

	//pop SAS, test type of expression can converted to int (type of char).
	auto topSar = sas->pop();
	try
	{
		if (topSar->getType() != "char")
			genSemError("Expression cannot be converted to an integer.");

		std::string temporary = createSemanticTemporary("int", "N");
		sas->push(new id_SAR(temporary, "int", temporary, "#atoi", false));

		createICodeStatement("", "AtoI", topSar->getSymID(), temporary, "", topSar->getSymID() + " -> " + temporary);
	}
	catch(...){genSemError("Failed #atoi.");}

	semanticDebug();

	delete topSar;
}

void Cl::semanticItoA()
{
	argumentList->debugPrint(std::string{"Called semanticItoA.\n"}, argumentList->debuggingParser);
	//pop SAS, test type of expression can converted to int (type of char).
	auto topSar = sas->pop();
	try
	{
		if (topSar->getType() != "int")
			genSemError("Expression cannot be converted to a char.");

		std::string temporary = createSemanticTemporary("char", "N");
		sas->push(new id_SAR(temporary, "char", temporary, "#itoa", false));

		createICodeStatement("", "ItoA", topSar->getSymID(), temporary, "", topSar->getSymID() + " -> " + temporary);
	}
	catch(...){genSemError("Failed #itoa.");}

	semanticDebug();

	delete topSar;
}

void Cl::semanticThis()
{
	argumentList->debugPrint(std::string{"Called semanticThis.\n"}, argumentList->debuggingParser);

	//grab top token from stack of method_body scope tokens.
	std::string className = mb_scopeTokens.back().substr(mb_scopeTokens.back().find_last_of(".") + 1);
	try
	{
		if (className == "g")
			throw std::runtime_error("Can't reference this in function main.");

		//eventual creation of id_sar with type that of classtype.
		std::string symID = st->scopeSearch("g", className);

		if (symID == "")
			throw std::runtime_error(symID + " does not exist.");

		sas->push(new id_SAR("this", className, "this", "#this", false));
	}
	catch(std::exception &x) 
	{
		std::string e = x.what();
		genSemError("Failed #this, " + e);
	}

	semanticDebug();
}

void Cl::BAL()
{
	sas->push(new bal_SAR());

	semanticDebug();
}

void Cl::semanticComma()
{
	argumentList->debugPrint(std::string{"Called semanticComma.\n"}, argumentList->debuggingParser);

	//while os.top isn't the '(' pop it off and run op.
	while (os->os.size() > 0 && os->os.back()->operatorLexem != "(")
	{
		Operator* tmpOp = os->pop();
		if (tmpOp != nullptr)
		{
			callOpType(tmpOp->operatorLexem);
		}
	}

	semanticDebug();
}

void Cl::semanticClosingParen()
{
	argumentList->debugPrint(std::string{"Called semanticClosingParen.\n"}, argumentList->debuggingParser);

	//while os.top isn't the '(' pop it off and run op.
	while (os->os.size() > 0 && os->os.back()->operatorLexem != "(")
	{
		Operator* tmpOp = os->pop();
		if (tmpOp != nullptr)
		{
			callOpType(tmpOp->operatorLexem);
		}
	}

	if (os->os.size() > 0 && os->os.back()->operatorLexem == "(")
		os->pop();

	semanticDebug();
}

void Cl::semanticClosingBracket()
{
	argumentList->debugPrint(std::string{"Called semanticClosingBracket.\n"}, argumentList->debuggingParser);

		//while os.top isn't the '[' pop it off and run op.
	while (os->os.size() > 0 && os->os.back()->operatorLexem != "[")
	{
		Operator* tmpOp = os->pop();
		if (tmpOp != nullptr)
		{
			callOpType(tmpOp->operatorLexem);
		}
	}

	if (os->os.size() > 0 && os->os.back()->operatorLexem == "]")
		os->pop();

	semanticDebug();
}

void Cl::EAL()
{
	argumentList->debugPrint(std::string{"Called EAL.\n"}, argumentList->debuggingParser);

	std::vector<SAR*> tempALSARS;
	//while top sar isn't of type "bal_sar"
	while (sas->sas.size() > 0 && sas->sas.back()->isASentinel() == false)
	{
		tempALSARS.insert(tempALSARS.begin(), sas->pop());
	}

	if (sas->sas.size() > 0 && sas->sas.back()->isASentinel())
	{
		sas->pop();
	}

	sas->push(new al_SAR(tempALSARS, "#EAL"));

	semanticDebug();
}

void Cl::semanticFunc()
{
	argumentList->debugPrint(std::string{"Called semanticFunc.\n"}, argumentList->debuggingParser);

	//pop al_SAR
	auto al_sar = sas->pop();
	//pop identifier SAR
	auto func_identifier_sar = sas->pop();
	//push func sar with al_SAR and identifier_SAR
	sas->push(new func_SAR(al_sar, func_identifier_sar));

	semanticDebug();
}

void Cl::semanticArr()
{
	argumentList->debugPrint(std::string{"Called semanticArr.\n"}, argumentList->debuggingParser);

	//pop arraySize SAR
	auto arrSize_sar = sas->pop();
	//pop identifier sar
	auto arrID_sar = sas->pop();

	//test arrSize sar is type integer.
	try
	{
		//get symid from sar first.
		std::string  type = st->symbolTable[arrSize_sar->getSymID()]->getType();

		//test for int.
		if (type != "int")
			throw std::runtime_error(" Expected type int for array size.");

		//sas push #arr.

		sas->push(new arr_SAR(arrID_sar->getName(), std::vector<SAR*>{arrSize_sar}, "#arr"));
	}
	catch(std::exception& x)
	{
		std::string e = x.what();
		genSemError("Failed #arr" + e);
	}

	semanticDebug();

	delete arrID_sar;
}

void Cl::newObj()
{
	argumentList->debugPrint(std::string{"Called newObj.\n"}, argumentList->debuggingParser);

	//pop an AL_SAR
	auto al_sar = sas->pop();
	//pop a type_sar
	auto type_sar = sas->pop();
	auto al = al_sar->getAL();

	//Find type Ctor symid.
	std::string id = st->scopeSearch("g." + type_sar->getName(), type_sar->getName());

	//get class sar params.
	std::string params;
	try
	{
		params = (st->symbolTable[id]->getParams()).substr(1);
		params.pop_back();

		std::vector<std::string> arity;

		std::stringstream ss(params);
		std::string item;

		while (std::getline(ss, item, ','))
		{
			size_t first = item.find_first_not_of(' ');
			size_t last = item.find_last_not_of(' ');
			item = item.substr(first, (last-first+1));
			arity.push_back(item);
		}

		//test alsar args and arity.
		//Arity check.
		if (arity.size() != al.size())
		{
			std::stringstream ss;
			ss << arity.size();
			throw std::runtime_error("Incorrect Arity - should be " + ss.str() + ".");
		}

		for (size_t i = 0; i < arity.size(); i++)
		{
			//Type Check each Parameter.
			std::string nextParamType = st->symbolTable[arity[i]]->getType();
			std::string nextALType = al[i]->getType();

			if (nextParamType != nextALType)
			{
				throw std::runtime_error("Type mismatch between " + arity[i] + " and " + al[i]->getSymID() + ".");
			}
		}

		//we need the symid of LHS for this.
		std::string symID = "";

		if (sas->sas.back() != nullptr && sas->sas.size() > 0)
		{
			symID = sas->sas.back()->getSymID();
		}

		//create new_sar

			//create temporary that's used as ref that the symid is an alias of.
		std::string temporary = createSemanticTemporary("int", "N");
		std::string temporary2 = createSemanticTemporary("ref", "N");
		sas->push(new new_SAR(al_sar, type_sar, temporary2, "#newObj"));

		//ICode ; malloc sizeof(type) -> temporary.
			//Find type Ctor symid.
		std::string classID = st->scopeSearch("g", type_sar->getName());

		try
		{
			createICodeStatement("", "NEWI", st->symbolTable[classID]->getSize(), temporary, "", "malloc (sizeof(" + type_sar->getName() + ")) -> " + temporary);

			//ICode for a function frame.
			createICodeStatement("", "FRAME", "g_" + type_sar->getName() + "_" + type_sar->getName(), temporary, "", "Create an activation record");
			//loop through argument list, pushing args.
			for (unsigned int i = 0; i < al.size(); i++)
				createICodeStatement("", "PUSH", al[i]->getSymID(), "", "", "PUSH " + al[i]->getSymID());
			createICodeStatement("", "CALL", "g_" + type_sar->getName() + "_" + type_sar->getName(), "", "", "Invoke the function");		

			createICodeStatement("", "PEEK", temporary2, "", "", "");
		}
		catch(...){}
	}
	catch(std::runtime_error& x)
	{
		std::string e = x.what();
		genSemError("Failed #newObj. " + e);
	}
	catch(std::exception& x)
	{
		genSemError("Failed #newObj. Constructor does not exist.");
	}
	delete al_sar;
	delete type_sar;

	semanticDebug();
}

void Cl::newArray()
{
	argumentList->debugPrint(std::string{"Called newArr.\n"}, argumentList->debuggingParser);

	//#new[]
	auto arrayParamSar = sas->pop();
	//Type Sar -- unused atm.
	auto type_sar = sas->pop();

	//get symid from arrayParamSar
	try
	{
		std::string paramType = st->symbolTable[arrayParamSar->getSymID()]->getType();

		//Test arrayParamSar is of type integer.
		if (paramType != "int")
			throw std::runtime_error(", expected int for array parameter.");

		//Test that array of type_sar can be created. I supposed everything can?

		//we need the symid of LHS for this.
		std::string symID = sas->sas.back()->getSymID();

		//Create new_sar for an array of type type_sar with arrayParamSar elements.

			//create temporary that's used as ref that the symid is an alias of.
		std::string temporary = createSemanticTemporary("int", "N");
		std::string temporary2 = createSemanticTemporary("ref", "N");
		sas->push(new new_SAR(temporary2, "@:" + type_sar->getType(), "#new[]"));

		try
		{
			std::string type = type_sar->getType();
			std::string op1 = "";
			std::string op2 = "";
			std::string op3 = "";

			if (type == "bool" || type == "char")
				op1 = "S0";
			else 
			{
				op1 = "S1";
				if (type != "int")
					type = "pointer";
			}

			//op1 is sizeof(type), op2 is symid of arrayParamSar, op3 is an int temporary.
			createICodeStatement("", "MUL", op1, arrayParamSar->getSymID(), temporary, "sizeof(" + type + ") * " + arrayParamSar->getSymID() + " -> " + temporary);
			createICodeStatement("", "NEW", temporary, temporary2, "", "malloc(" + temporary + ") -> " + temporary2);
		}
		catch(...){}
	}
	catch(std::exception& x)
	{
		std::string e = x.what();
		genSemError("Failed #new[]" + e);
	}

	delete arrayParamSar;
	delete type_sar;

	semanticDebug();
}

void Cl::EOE()
{
	argumentList->debugPrint(std::string{"Called EOE.\n"}, argumentList->debuggingParser);

	while (os->os.size() > 0)
	{
		Operator* tmpOp = os->pop();
		if (tmpOp != nullptr)
		{
			callOpType(tmpOp->operatorLexem);
		}
	}
}

void Cl::semanticTypeCheckSAS(STData* &lhST, STData* &rhST)
{
	argumentList->debugPrint(std::string{"Called semanticTypeCheckSAS.\n"}, argumentList->debuggingParser);

	int counter = 1;
	try
	{
		//test lhs = rhs is valid.
		auto rhs = sas->pop();
		auto lhs = sas->pop();
		//get type of lhs and rhs.
		if (lhs->getName() != "this")
			lhST = st->symbolTable[lhs->getSymID()];
		else thisValue = "this";
		counter++;
		if (rhs->getName() != "this")
			rhST = st->symbolTable[rhs->getSymID()];
		else thisValue = "this";
		counter++;
		std::string lhsType = lhs->getType();
		counter++;
		std::string rhsType = rhs->getType();
		counter++;


		bool nullComparison = false;
		bool nullSuccess = false;

		if (rhsType == "ref")
			nullComparison = true;

		if (nullComparison)
		{
			if (lhsType != "int" && lhsType != "char" && lhsType != "bool" && lhsType != "void" && lhsType != "sym")
				nullSuccess = true;
		}

		//compare types.
		if(lhsType != rhsType && !(nullSuccess))
		{
			genSemError(lhsType + ", " + rhsType + ". Types are not equal.");
		}

		delete rhs;
		delete lhs;
	}
	catch (...)
	{
		if (counter == 1)
			genSemError("LHS does not exist.");
		else if (counter == 2)
			genSemError("RHS does not exist.");
	}
}

void Cl::semanticTypeCheckSAR(STData* &val, std::string correctType1, std::string correctType2)
{
	argumentList->debugPrint(std::string{"Called semanticTypeCheckSAR.\n"}, argumentList->debuggingParser);

	std::string valType = "";

	//Check if the type is also correct for the operator.
	if (val != nullptr)
		valType = val->getType();

	//compare types.
	if(valType != correctType1 && valType != correctType2 && val != nullptr)
	{
		if (correctType1 == correctType2)
			genSemError(val->value + " is not a " + correctType1 + ".");
		else genSemError(val->value + " is not a " + correctType1 + " or " + correctType2 + ".");
	}
		
}

std::string Cl::createSemanticTemporary(std::string type, std::string ref)
{
	argumentList->debugPrint(std::string{"Called createSemanticTemporary.\n"}, argumentList->debuggingParser);

	//find method in ST for current scope. update it's size to reflect offset (for calculating temporaries).
	std::string functionScope = st->scope;
	
	while (functionScope.substr(functionScope.length() - 2) == ".{")
	{
		functionScope = functionScope.substr(0, functionScope.length() - 2);
	}

	std::string methodName = functionScope.substr(functionScope.find_last_of(".") + 1);
	std::string searchScope = functionScope.substr(0, functionScope.find_last_of("."));
	std::string methodSymID = st->scopeSearch(searchScope, methodName);

	//for the temporary we need to check if our scope:
		// is a class (then we write it into the staticInit function scope) or a function (do what we are doing now).

	if (methodSymID.size() > 0 && methodSymID.at(0) == 'C')
	{
		functionScope = functionScope + ".StaticInit";
		methodName = functionScope.substr(functionScope.find_last_of(".") + 1);
		searchScope = functionScope.substr(0, functionScope.find_last_of("."));
		methodSymID = st->scopeSearch(searchScope, methodName);
	}

	std::string offsetType = type;

	if ((offsetType == "char" || offsetType == "bool") && ref == "Y")
		offsetType = "ref";

	computeStackOffset(offsetType, functionScope);

	std::string temporary = st->genSym("T");
	std::string methodSize = st->symbolTable[methodSymID]->getSize();
	int offset = 0;

	std::istringstream (methodSize) >> offset;
	offset += 1;

	if(st->insert(new STData(ct->lineNumber, functionScope, temporary, temporary, "temp", new tempData(SSTR(offset), type, "N"))))
		genError("A unique Identifier.", "Duplicate " + temporary);
	

	return temporary;
}

void Cl::createICodeStatement(std::string label, std::string instruction, std::string op1, std::string op2, std::string op3, std::string comment)
{
	//Make sure it's not a multithreaded semantic action.
	if (inSpawn == false)
	{
		//check if scope is that of a class and actually write it to our static initializer quad. 
			//This needs to be a map of quads with the key being each class name which is the scope.substr(scope.find_last_of(".")  + 1).
				//Which we already found when we determine if it is a class.

		//find method in ST for current scope. update it's size to reflect offset (for calculating temporaries).
		std::string functionScope = st->scope;
		std::string methodName = "", searchScope = "", methodSymID = "";
		
		while (functionScope.size() > 2 && functionScope.substr(functionScope.length() - 2) == ".{")
		{
			functionScope = functionScope.substr(0, functionScope.length() - 2);
		}

		methodName = functionScope.substr(functionScope.find_last_of(".") + 1);
		searchScope = functionScope.substr(0, functionScope.find_last_of("."));
		methodSymID = st->scopeSearch(searchScope, methodName);

		if (methodSymID.size() > 0 && methodSymID.at(0) == 'C')
		{
			//insert the statement into the map with key of this methodName.

			//NEVERMIND: WE WRITE OUT THE INITIALIZER STACK AT THE END OF THE CLASS WITH A LABEL FOR THE FUNCTION NAME JUST LIKE BEFORE.
				//Just need a differnt quad array to write into main one.
				//So we just insert into a differnt quad. No keys or anything since we can use labels!!

			staticicgen->insert(label, instruction, op1, op2, op3, comment);
		}
		else
		{
			//ordinary insert into our main quad array.
			icgen->insert(label, instruction, op1, op2, op3, comment);
		}
	}
}

void Cl::semanticEqual()
{
	argumentList->debugPrint(std::string{"Called semanticEqual.\n"}, argumentList->debuggingParser);

	STData* lhST = nullptr;
	STData* rhST = nullptr;
	semanticTypeCheckSAS(lhST, rhST);

	semanticDebug();

	try
	{
		if (lhST != nullptr && rhST != nullptr)
			createICodeStatement("", "MOV", lhST->getSymID(), rhST->getSymID(), "", rhST->getValue() + " -> " + lhST->getValue());
		else if (thisValue == "this" && lhST != nullptr)
			createICodeStatement("", "MOV", lhST->getSymID(), "this", "", "this -> " + lhST->getValue());
		else if (thisValue == "this" && rhST != nullptr)
			createICodeStatement("", "MOV", "this", rhST->getSymID(), "",rhST->getValue() + " -> this");

		thisValue = "";
	}
	catch(...){}
}

void Cl::semanticAdd()
{
	argumentList->debugPrint(std::string{"Called semanticAdd.\n"}, argumentList->debuggingParser);

	STData* lhST = nullptr;
	STData* rhST = nullptr;
	std::string temporary = "";
	semanticTypeCheckSAS(lhST, rhST);
	if (lhST != nullptr)
	{
		temporary = createSemanticTemporary(lhST->getType(), "N");
		sas->push(new id_SAR(temporary, "int", temporary, "#+", false));
	}

	semanticDebug();

	try
	{
		if (lhST != nullptr && rhST != nullptr)
			createICodeStatement("", "ADD", lhST->getSymID(), rhST->getSymID(), temporary, lhST->getValue() + " + " + rhST->getValue() + " -> " + temporary);
	}
	catch(...){}
}

void Cl::semanticSubtract()
{
	argumentList->debugPrint(std::string{"Called semanticSubtract.\n"}, argumentList->debuggingParser);

	STData* lhST = nullptr;
	STData* rhST = nullptr;
	std::string temporary = "";
	semanticTypeCheckSAS(lhST, rhST);
	if (lhST != nullptr)
	{
		temporary = createSemanticTemporary(lhST->getType(), "N");
		sas->push(new id_SAR(temporary, "int", temporary, "#-", false));
	}

	semanticDebug();

	try
	{
		if (lhST != nullptr && rhST != nullptr)
			createICodeStatement("", "SUB", lhST->getSymID(), rhST->getSymID(), temporary, lhST->getValue() + " - " + rhST->getValue() + " -> " + temporary);
	}
	catch(...){}
}

void Cl::semanticMultiply()
{
	argumentList->debugPrint(std::string{"Called semanticMultiply.\n"}, argumentList->debuggingParser);

	STData* lhST = nullptr;
	STData* rhST = nullptr;
	std::string temporary = "";
	semanticTypeCheckSAS(lhST, rhST);
	if (lhST != nullptr)
	{
		temporary = createSemanticTemporary(lhST->getType(), "N");
		sas->push(new id_SAR(temporary, "int", temporary, "#*", false));
	}

	semanticDebug();

	try
	{
		if (lhST != nullptr && rhST != nullptr)
			createICodeStatement("", "MUL", lhST->getSymID(), rhST->getSymID(), temporary, lhST->getValue() + " * " + rhST->getValue() + " -> " + temporary);
	}
	catch(...){}
}

void Cl::semanticDivide()
{
	argumentList->debugPrint(std::string{"Called semanticDivide.\n"}, argumentList->debuggingParser);

	STData* lhST = nullptr;
	STData* rhST = nullptr;
	std::string temporary = "";
	semanticTypeCheckSAS(lhST, rhST);
	if (lhST != nullptr)
	{
		temporary = createSemanticTemporary(lhST->getType(), "N");
		sas->push(new id_SAR(temporary, "int", temporary, "#/", false));
	}

	semanticDebug();

	try
	{
		if (lhST != nullptr && rhST != nullptr)
			createICodeStatement("", "DIV", lhST->getSymID(), rhST->getSymID(), temporary, lhST->getValue() + " / " + rhST->getValue() + " -> " + temporary);
	}
	catch(...){}
}

void Cl::semanticLessThan()
{
	argumentList->debugPrint(std::string{"Called semanticLessThan.\n"}, argumentList->debuggingParser);

	STData* lhST = nullptr;
	STData* rhST = nullptr;
	std::string temporary = "";
	semanticTypeCheckSAS(lhST, rhST);
	//Check if the types are also an int or char.
	semanticTypeCheckSAR(lhST, "int", "char");
	semanticTypeCheckSAR(rhST, "int", "char");

	if (lhST != nullptr)
	{
		temporary = createSemanticTemporary("bool", "N");
		sas->push(new id_SAR(temporary, "bool", temporary, "#<", false));
	}

	semanticDebug();

	try
	{
		if (lhST != nullptr && rhST != nullptr)
			createICodeStatement("", "LT", lhST->getSymID(), rhST->getSymID(), temporary, lhST->getValue() + " < " + rhST->getValue() + " -> " + temporary);
	}
	catch(...){}
}

void Cl::semanticLessThanEqual()
{
	argumentList->debugPrint(std::string{"Called semanticLessThanEqual.\n"}, argumentList->debuggingParser);

	STData* lhST = nullptr;
	STData* rhST = nullptr;
	std::string temporary = "";
	semanticTypeCheckSAS(lhST, rhST);
	//Check if the types are also an int or char.
	semanticTypeCheckSAR(lhST, "int", "char");
	semanticTypeCheckSAR(rhST, "int", "char");
	if (lhST != nullptr)
	{
		temporary = createSemanticTemporary("bool", "N");
		sas->push(new id_SAR(temporary, "bool", temporary, "#<=", false));
	}

	semanticDebug();

	try
	{
		if (lhST != nullptr && rhST != nullptr)
			createICodeStatement("", "LE", lhST->getSymID(), rhST->getSymID(), temporary, lhST->getValue() + " <= " + rhST->getValue() + " -> " + temporary);
	}
	catch(...){}
}

void Cl::semanticGreaterThan()
{
	argumentList->debugPrint(std::string{"Called semanticGreaterThan.\n"}, argumentList->debuggingParser);

	STData* lhST = nullptr;
	STData* rhST = nullptr;
	std::string temporary = "";
	semanticTypeCheckSAS(lhST, rhST);
	//Check if the types are also an int or char.
	semanticTypeCheckSAR(lhST, "int", "char");
	semanticTypeCheckSAR(rhST, "int", "char");
	if (lhST != nullptr)
	{
		temporary = createSemanticTemporary("bool", "N");
		sas->push(new id_SAR(temporary, "bool", temporary, "#>", false));
	}

	semanticDebug();

	try
	{
		if (lhST != nullptr && rhST != nullptr)
			createICodeStatement("", "GT", lhST->getSymID(), rhST->getSymID(), temporary, lhST->getValue() + " > " + rhST->getValue() + " -> " + temporary);
	}
	catch(...){}
}

void Cl::semanticGreaterThanEqual()
{
	argumentList->debugPrint(std::string{"Called semanticGreaterThanEqual.\n"}, argumentList->debuggingParser);

	STData* lhST = nullptr;
	STData* rhST = nullptr;
	std::string temporary = "";
	semanticTypeCheckSAS(lhST, rhST);
	//Check if the types are also an int or char.
	semanticTypeCheckSAR(lhST, "int", "char");
	semanticTypeCheckSAR(rhST, "int", "char");
	if (lhST != nullptr)
	{
		temporary = createSemanticTemporary("bool", "N");
		sas->push(new id_SAR(temporary, "bool", temporary, "#>=", false));
	}

	semanticDebug();

	try
	{
		if (lhST != nullptr && rhST != nullptr)
			createICodeStatement("", "GE", lhST->getSymID(), rhST->getSymID(), temporary, lhST->getValue() + " >= " + rhST->getValue() + " -> " + temporary);
	}
	catch(...){}
}

void Cl::semanticBooleanEqual()
{
	argumentList->debugPrint(std::string{"Called semanticBooleanEqual.\n"}, argumentList->debuggingParser);

	STData* lhST = nullptr;
	STData* rhST = nullptr;
	std::string temporary = "";
	semanticTypeCheckSAS(lhST, rhST);
	if (lhST != nullptr)
	{
		temporary = createSemanticTemporary("bool", "N");
		sas->push(new id_SAR(temporary, "bool", temporary, "#==", false));
	}

	semanticDebug();

	try
	{
		if (lhST != nullptr && rhST != nullptr)
			createICodeStatement("", "EQ", lhST->getSymID(), rhST->getSymID(), temporary, lhST->getValue() + " == " + rhST->getValue() + " -> " + temporary);
	}
	catch(...){}
}

void Cl::semanticBooleanNotEqual()
{
	argumentList->debugPrint(std::string{"Called semanticBooleanNotEqual.\n"}, argumentList->debuggingParser);

	STData* lhST = nullptr;
	STData* rhST = nullptr;
	std::string temporary = "";
	semanticTypeCheckSAS(lhST, rhST);
	if (lhST != nullptr)
	{
		temporary = createSemanticTemporary("bool", "N");
		sas->push(new id_SAR(temporary, "bool", temporary, "#!=", false));
	}

	semanticDebug();

	try
	{
		if (lhST != nullptr && rhST != nullptr)
			createICodeStatement("", "NE", lhST->getSymID(), rhST->getSymID(), temporary, lhST->getValue() + " != " + rhST->getValue() + " -> " + temporary);
	}
	catch(...){}
}

void Cl::semanticAnd()
{
	argumentList->debugPrint(std::string{"Called semanticAnd.\n"}, argumentList->debuggingParser);

	STData* lhST = nullptr;
	STData* rhST = nullptr;
	std::string temporary = "";
	semanticTypeCheckSAS(lhST, rhST);
	//Check if the types are also booleans.
	semanticTypeCheckSAR(lhST, "bool", "bool");
	semanticTypeCheckSAR(rhST, "bool", "bool");
	if (lhST != nullptr)
	{
		temporary = createSemanticTemporary("bool", "N");
		sas->push(new id_SAR(temporary, "bool", temporary, "#&&", false));
	}

	semanticDebug();

	try
	{
		if (lhST != nullptr && rhST != nullptr)
			createICodeStatement("", "AND", lhST->getSymID(), rhST->getSymID(), temporary, lhST->getValue() + " && " + rhST->getValue() + " -> " + temporary);
	}
	catch(...){}
}

void Cl::semanticOr()
{
	argumentList->debugPrint(std::string{"Called semanticOr.\n"}, argumentList->debuggingParser);

	STData* lhST = nullptr;
	STData* rhST = nullptr;
	std::string temporary = "";
	semanticTypeCheckSAS(lhST, rhST);
	//Check if the types are also booleans.
	semanticTypeCheckSAR(lhST, "bool", "bool");
	semanticTypeCheckSAR(rhST, "bool", "bool");
	if (lhST != nullptr)
	{
		temporary = createSemanticTemporary("bool", "N");
		sas->push(new id_SAR(temporary, "bool", temporary, "#||", false));
	}

	semanticDebug();

	try
	{
		if (lhST != nullptr && rhST != nullptr)
			createICodeStatement("", "OR", lhST->getSymID(), rhST->getSymID(), temporary, lhST->getValue() + " || " + rhST->getValue() + " -> " + temporary);
	}
	catch(...){}
}

void Cl::semanticDebug()
{
	if (argumentList->debuggingSemantics)
	{
		SADebugger tmp(os, sas);
		argumentList->debugPrint(&tmp, argumentList->debuggingSemantics);
	}
}