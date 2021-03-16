%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char* s);
extern int yylineno;
%}

%token NOT
%token CALL
%token LP
%token RP
%token LCB
%token RCB
%token LSB
%token RSB
%token DOT
%token COMMA
%token SEMICOLON
%token ASSIGN_OP
%token DIVIDE_ASSIGN_OP
%token MULTIPLY_ASSIGN_OP
%token MOD_ASSIGN_OP
%token PLUS_ASSIGN_OP
%token MINUS_ASSIGN_OP
%token IS_EQUAL_OP
%token NOT_EQUAL_OP
%token STRING_IDENTIFIER
%token CHAR_IDENTIFIER
%token PLUS
%token MINUS
%token MULTIPLY_OP
%token DIVIDE_OP
%token MOD_OP
%token GT
%token LT
%token LTE
%token GTE
%token AND
%token OR
%token MAIN
%token SOUTH
%token NORTH
%token EAST
%token WEST
%token PLAYERX
%token PLAYERY
%token BEGIN
%token END
%token MOVE
%token NEW_LINE
%token UNDERSCORE
%token EGG_IN
%token EGG_OUT
%token INT
%token DOUBLE
%token STRING
%token CHAR
%token BOOL
%token IF
%token ELSE
%token ELIF
%token FOR
%token WHILE
%token DO
%token VOID
%token RETURN
%token POW
%token MAX
%token MIN
%token SQUARE_ROOT
%token BOOL_STMT
%token STRING_STMT
%token CONST
%token INT_STMT
%token DOUBLE_STMT
%token CHAR_STMT
%token IDENTIFIER
%token COMMENT
%token LINE_COMMENT

%start program
%%
program:
	BEGIN stmts END
stmts:
	stmt | stmt stmts
stmt:
	matched_stmt SEMICOLON
| unmatched_stmt SEMICOLON
| non_if_stmt SEMICOLON
matched_stmt:
IF LP logical_expression RP stmts
| ELIF LP logical_expression RP stmts
| non_if_stmt
unmatched_stmt:
IF LP logical_expression RP stmts
| ELIF LP logical_expression RP stmts
| IF LP logical_expression RP matched_stmt ELSE LP unmatched_stmt RP
non_if_stmt:
loops non_if_stmt
| arithmetic_operations non_if_stmt
| function_call non_if_stmt
| function_declaration non_if_stmt
| declaration non_if_stmt
| initialization non_if_stmt
| declaration_and_initilization non_if_stmt
| input_stmt non_if_stmt
| output_stmt non_if_stmt
| COMMENT non_if_stmt
| LINE_COMMENT non_if_stmt 
| loops
| arithmetic_operations
| function_call
| function_declaration
| declaration
| initialization
| declaration_and_initilization
| input_stmt
| output_stmt
| COMMENT
| LINE_COMMENT

loops:
while_loop
| for_loop
| do_while_loop

while_loop: 
WHILE LP logical_expression RP LCB stmts RCB

for_loop:
FOR LP loop_initialization SEMICOLON logical_expression SEMICOLON arithmetic_operations RP LCB stmts RCB

do_while_loop:
DO LCB stmts RCB WHILE LP logical_expression RP SEMICOLON


loop_initialization:
initialization
| declaration_and_initilization
logical_expression:
single_expression
| recursive_expression
single_expression: 
term logical_operator term 
| BOOL_STMT
| NOT BOOL_STMT
recursive_expression: 
recursive_expression logical_connector single_expression 
| single_expression
term:
	var
var:
IDENTIFIER
logical_connector:
AND
| OR

logical_operator:
IS_EQUAL_OP 
| NOT_EQUAL_OP 
| NOT 
| GT 
| LT
| GTE
| LTE

arithmetic_operations:
addition
| subtraction
| division
| multiplication
| modulo
| power
| sqrt

addition:
addition PLUS term
| term
| LP addition RP

subtraction:
subtraction MINUS term
| term
| LP subtraction RP

division: 
division DIVIDE_OP factor 
| factor 
| LP division RP

multiplication:
multiplication MULTIPLY_OP factor
| factor
| LP multiplication RP

modulo:
factor MOD_OP factor
power: 
POW LP INT_STMT COMMA INT_STMT RP
| POW LP INT_STMT COMMA DOUBLE_STMT RP
| POW LP DOUBLE_STMT COMMA INT_STMT RP
| POW LP DOUBLE_STMT COMMA DOUBLE_STMT RP

constant_identifier:
	CONST term
sign:
	PLUS 
| MINUS
factor:
	term
max:
MAX LP INT_STMT COMMA INT_STMT RP 
| MAX LP DOUBLE_STMT COMMA DOUBLE_STMT RP
min:
MIN LP INT_STMT COMMA INT_STMT RP
| MIN LP DOUBLE_STMT RP COMMA DOUBLE_STMT RP
sqrt:
SQUARE_ROOT LP INT_STMT RP
| SQUARE_ROOT LP DOUBLE_STMT RP
declaration: 
	types term SEMICOLON
	| types constant_identifier SEMICOLON
types:
	INT | DOUBLE | STRING | CHAR | BOOL
function_call:
	CALL IDENTIFIER LP IDENTIFIER RP SEMICOLON
function_types:
types | VOID
initialization : 
term assignment_operator assignment_values SEMICOLON
declaration_and_initilization:
	types term assignment_operator assignment_values SEMICOLON
	| types constant_identifier SEMICOLON

assignment_operator: 
ASSIGN_OP
| DIVIDE_ASSIGN_OP
| MULTIPLY_ASSIGN_OP
| MOD_ASSIGN_OP
| PLUS_ASSIGN_OP
| MINUS_ASSIGN_OP
assignment_values: 
BOOL_STMT
| INT_STMT
| STRING_STMT 
| DOUBLE_STMT
| CHAR_STMT

input_stmt: 
EGG_IN LP input_context RP

output_stmt: 
EGG_OUT LP output_context RP

input_context: 
term PLUS input_context 
| term

output_context: 
term 
| assignment_values
| term PLUS output_context
| assignment_values PLUS output_context

function_declaration:
function_types IDENTIFIER LP parameter RP LCB stmts RCB 
| function_types IDENTIFIER LP parameter RP LCB stmts RETURN assignment_values RCB 
| function_types IDENTIFIER LP parameter RP LCB stmts RETURN VOID RCB

parameter:
	parameter COMMA types IDENTIFIER
| types IDENTIFIER

%%
void yyerror(char* s) {
	fprintf(stdout, “line %d: %s\n”, yylineno, s);
}
int main(void) {
	yyparse();
if(yynerrs < 1) {
		printf(“Parsing is successful\n”);
	}
return 0;
}
