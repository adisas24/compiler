%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%left T_PLUS T_MINUS
%left T_MUL T_DIV
%token T_MOD
%token T_LESST
%token T_LESSTE
%token T_GREATERT
%token T_GREATERTE
%token T_EQUAL
%token T_EQUALEQUAL
%token T_NOTEQUAL
%token T_AND
%token T_OR
%token T_NOT
%token T_SEMICOLON
%token T_COMMA
%token T_DOT
%token T_LBRACKET
%token T_RBRACKET
%token T_DEG
%token T_BSLASH
%token T_LET
%token T_IN
%token T_END
%token T_IDENTIFIER
%token T_SKIP
%token T_IF
%token T_THEN
%token T_ELSE
%token T_FI
%token T_WHILE
%token T_DO
%token T_INT
%token T_DOUBLE
%token T_BOOL
%token T_STRING


%start program

%%
program:T_LET[declarations] T_IN command sequence T_END;
declarations: declarations.. type ident_decl
ident_decl:[id seq]... T_IDENTIFIER .
id seq: id seq...T_IDENTIFIER ,
command sequence: command... command
command: T_SKIP;
        | T_IDENTIFIER:=expression;
        | T_IF exp T_THEN command sequence T_ELSE command sequence T_FI;
        | T_WHILE exp T_DO command sequence T_END;
        | T_READ T_IDENTIFIER;
        | T_WRITE expression;
expression: constant| identifier | '(' expression ')'
        | expression T_PLUS expression | expression T_MINUS expression
        | expression T_MUL expression | expression / expression
        | expression T_DEG expression
        | expression T_EQUAL expression
        | expression T_LESST expression
        | expression T_GREATERT expression
        | expression T_GREATERTE expression
        | expression T_LESSTE expression
        | expression T_NOTEQUAL expression
        | expression T_AND expression
        | expression T_OR expression
        | T_NOT expression
constant: T_INT | T_DOUBLE | T_BOOL | T_STRING
type: T_INT | T_DOUBLE | T_BOOL | T_STRING


%%

int main(){
    yyin=stdin;
    do{
        yyparse();
    }while(!feof(yyin));
    printf("pravilna gramatika")//samo provera da je gramatika pravino napisana
    return 0;

}
void yyerror(const char* s){
    fprint(stderr, "Error: %s\n",s);
    exit(1);
}
