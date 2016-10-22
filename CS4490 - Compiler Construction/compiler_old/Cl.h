#include "Scanner.h"

#pragma once
class Cl
{
	Scanner* ct;
public:
	Cl(Scanner* ct);
	~Cl();
	void modifier();
	void class_name();
	void type();
	void character_literal();
	void numeric_literal();
	void number();
	void compilation_unit();
	void class_declaration();
	void class_member_declaration();
	void field_declaration();
	void constructor_declaration();
	void method_body();
	void variable_declaration();
	void parameter_list();
	void parameter();
	void statement();
	void expression();
	void fn_arr_member();
	void argument_list();
	void member_refz();
	void expressionz();
	void assignment_expression();
	void new_declaration();
	void genError(std::string expected);
	
};

