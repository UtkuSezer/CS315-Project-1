%{
#include <stdio.h>
void yyerror(char *);
%}

hashtag 		\#
double_hashtag		\#\#
main_word		main
call_word		call
south_word		SOUTH
north_word		NORTH
east_word		EAST
west_word		WEST
playerx_word		PLAYERX
playery_word		PLAYERY
void_return		void
int_type		int
double_type		double
string_type		string
char_type		char
bool_type		bool
const_identifier	const
type			bool_type|char_type|string_type|double_type|int_type
if_stmt			if
else_stmt		else
for_stmt		for
while_stmt		while
do_stmt			do
return_stmt		return
input_stmt		eggin
output_stmt		eggout
pow_stmt		pow
max_stmt 		max
min_stmt		min
sqrt_stmt		sqrt
move_stmt		move
underscore		\_

newline			\n
true_bool		true
false_bool		false

line_comment		{double_hashtag}([^\n])*\n
comment			{hashtag}([^\#])*{hashtag}

digit			[0-9]
capital_letter		[A-Z]
lower_letter		[a-z]
letter			{capital_letter}|{lower_letter}
identifier		{lower_letter}({letter}|{digit}|{underscore})*


string_stmt 		\"(.)*\"
bool_stmt		{true_bool}|{false_bool}
int_stmt		[+-]?{digit}+
double_stmt 		[+-]?{digit}*(\.)?{digit}+
char_stmt		\'[^\\\']\'

%option yylineno
%%
\!			return("NOT");
\(            		return("LP");
\)            		return("RP");
\{            		return("LCB");
\}            		return("RCB");
\[            		return("LSB");
\]            		return("RSB");
\.            		return("DOT");
\,            		return("COMMA");
\;            		return("SEMICOLON");
\=            		return("ASSIGN_OP");
\/\=			return("DIVIDE_ASSIGN_OP");
\*\=			return("MULTIPLY_ASSIGN_OP");
\%\=			return("MOD_ASSIGN_OP");
\+\=			return("PLUS_ASSIGN_OP");
\-\=			return("MINUS_ASSIGN_OP");
\=\=			return("IS_EQUAL_OP");
\!\=			return("NOT_EQUAL_OP");
\"            		return("STRING_IDENTIFIER");
\'            		return("CHAR_IDENTIFIER");
\+        		return("PLUS");
\-        		return("MINUS");
\*			return("MULTIPLY_OP");
\/			return("DIVIDE_OP");
\%			return("MOD_OP");
\>			return("GT");
\<			return("LT");
\<\=			return("LTE");
\>\=			return("GTE");
\&			return("AND");
\|			return("OR");
{main_word}		return("MAIN");
{call_word}		return("CALL");
{south_word}		return("SOUTH");
{north_word}		return("NORTH");
{east_word}		return("EAST");
{west_word}		return("WEST");
{playerx_word}		return("PLAYERX");
{playery_word}		return("PLAYERY");
{move_stmt}		return("MOVE");
{newline}       	return("NEW_LINE");
{underscore}		return("UNDERSCORE");
{input_stmt}		return("EGG_IN");
{output_stmt}		return("EGG_OUT");
{int_type}		return("INT");
{double_type}		return("DOUBLE");
{string_type}		return("STRING");
{char_type}		return("CHAR");
{bool_type}		return("BOOL");
{if_stmt}		return("IF");
{else_stmt}		return("ELSE");
{for_stmt}		return("FOR");
{while_stmt}		return("WHILE");
{do_stmt}		return("DO");
{void_return}		return("VOID");
{return_stmt}		return("RETURN");
{pow_stmt}		return("POW");
{max_stmt}		return("MAX");
{min_stmt}		return("MIN");
{sqrt_stmt}		return("SQUARE_ROOT");
{bool_stmt}		return("BOOL_STMT");
{string_stmt} 		return("STRING_STMT");
{const_identifier}	return("CONST");
{int_stmt}		return("INT_STMT");
{double_stmt} 		return("DOUBLE_STMT");
{char_stmt}		return("CHAR_STMT");
{identifier}		return("IDENTIFIER");
{comment}		return("COMMENT");
{line_comment}		return("LINE_COMMENT");
.	          	;
%%

int yywrap(void){
	return 1;
}
