#pragma once

#include "scanner.h"
#include "st.h"
#include "os.h"
#include "semdeb.h"
#include "icgen.h"

class Cl
{
	bool pass1;
	bool pass2;
	compilerArgs* argumentList;
	Scanner* ct;
	ST* st;
	OS* os;
	SAS* sas;
	ICGenerator* icgen;
	ICGenerator* staticicgen;
	int errorCount;
	static int phase;
	static int stackBase;
	std::vector<std::vector<std::string>> tokenAttributes;
	std::vector<std::string> scopeTokens;
	std::vector<std::string> idTokens;
	std::vector<std::string> mb_scopeTokens;
	std::vector<std::string> classTokens;
	std::vector<std::string> ifStack;
	std::vector<std::string> elseStack;
	std::vector<std::string> whileStack;
	int classOffsets;
	int stackOffsets;
	bool isCtor;
	std::string thisValue;
	bool inSpawn;
	bool cTorReturn;
	bool firstStackComputeOfPhase2;

	//Non-Terminals

	void modifier();
	void class_name();
	void type();
	void character_literal();
	void numeric_literal();
	void number();
	void character();
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
	void genError(std::string);
	void genError(std::string, std::string);
	void genSemError(std::string);
	void PMR();

	//Non-Terminal Predicates

	bool aModifier(Token*);
	bool aType(Token*);
	bool aNumeric_literal(Token*);
	bool aNumber(Token*);
	bool aClass_declaration(Token*);
	bool aClass_member_declaration(Token*);
	bool aConstructor_declaration(Token*);
	bool aVariable_declaration(Token*);
	bool aParameter_list(Token*);
	bool aStatement(Token*);
	bool anExpression(Token*);
	bool aFn_arr_member(Token*);
	bool anArgument_list(Token*);
	bool aMember_refz(Token*);
	bool anExpressionz(Token*);

	void computeInstanceOffset(std::string);
	void computeStackOffset(std::string, std::string);

	//Semantic Actions

	void callOpType(std::string);
	void oPush(std::string);
	void tPush(std::string);
	void iPush(std::string);
	void vPush(std::string);
	void lPush(std::string);

	void iExist();
	void rExist();
	void tExist();
	void CD(std::string);
	bool existence(std::string, std::string, SAR*&, SAR*&, bool, std::vector<semanticMessager*>&);

	void semanticIf();
	void semanticWhile();
	void semanticReturn();
	void semanticCout();
	void semanticCin();
	void semanticAtoi();
	void semanticItoA();
	void semanticThis();

	void BAL();
	void semanticComma();
	void semanticClosingParen();
	void semanticClosingBracket();
	void EAL();

	void semanticFunc();
	void semanticArr();
	void newObj();
	void newArray();

	void EOE();
	void semanticTypeCheckSAS(STData*&, STData*&);
	void semanticTypeCheckSAR(STData*&, std::string, std::string);
	std::string createSemanticTemporary(std::string, std::string);
	void createICodeStatement(std::string, std::string, std::string, std::string, std::string, std::string);

	void semanticEqual();
	void semanticAdd();
	void semanticSubtract();
	void semanticMultiply();
	void semanticDivide();
	void semanticLessThan();
	void semanticLessThanEqual();
	void semanticGreaterThan();
	void semanticGreaterThanEqual();
	void semanticBooleanEqual();
	void semanticBooleanNotEqual();
	void semanticAnd();
	void semanticOr();
	
	void semanticDebug();
public:
	Cl(compilerArgs*, Scanner*, ST*);
	Cl(compilerArgs*, Scanner*, ST*, OS*, SAS*, ICGenerator*, ICGenerator*);
	~Cl();
	void compilation_unit();
};