%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#define YY_DECL int yylex()

#include "provera.tab.h"
%}

%%
"if"|"else"|"let"|"in"|"end"|"skip"|"then"|"fi"|"while"|"do"|"read"|"write"|"true"|"false" {
    printf("%s",yytext);
    if(strcmp(yytext,"if")){
        return T_IF;
    }
    if(strcmp(yytext,"else")){
        return T_ELSE;
    }
    if(strcmp(yytext,"let")){
        return T_LET;
    }
    if(strcmp(yytext,"in")){
        return T_IN;
    }
    if(strcmp(yytext,"end")){
        return T_END;
    }
    if(strcmp(yytext,"skip")){
        return T_SKIP;
    }
    if(strcmp(yytext,"then")){
        return T_THEN;
    }
    if(strcmp(yytext,"fi")){
        return T_FI;
    }
    if(strcmp(yytext,"while")){
        return T_WHILE;
    }
    if(strcmp(yytext,"do")){
        return T_DO;
    }
    if(strcmp(yytext,"read")){
        return T_READ;
    }
    if(strcmp(yytext,"write")){
        return T_WRITE;
    }
    if(strcmp(yytext,"write")){
        return T_WRITE;
    }
    if(strcmp(yytext,"true")){
        return T_BOOL;
    }
    if(strcmp(yytext,"false")){
        return T_BOOL;
    }

}
"+"|"-"|"*"|"/"|"%"|"<"|"<="|">"|">="|"="|"=="|"!="|"&&"|"||"|"!"|";"|","|"."|"("|")"|"^"|"\\" {
    printf("%s",yytext);
    if(strcmp(yytext,"+")){
        return T_PLUS;
    }
     if(strcmp(yytext,"-")){
        return T_MINUS;
    }
     if(strcmp(yytext,"*")){
        return T_MUL;
    }
     if(strcmp(yytext,"/")){
        return T_DIV;
    }
     if(strcmp(yytext,"%")){
        return T_MOD;
    }
     if(strcmp(yytext,"<")){
        return T_LESST;
    }
     if(strcmp(yytext,"<=")){
        return T_LESSTE;
    }
     if(strcmp(yytext,">")){
        return T_GREATERT;
    }
     if(strcmp(yytext,">=")){
        return T_GREATERTE;
    }
     if(strcmp(yytext,"=")){
        return T_EQUAL;
    }
    if(strcmp(yytext,"==")){
        return T_EQUALEQUAL;
    }
    if(strcmp(yytext,"!=")){
        return T_NOTEQUAL;
    }
    if(strcmp(yytext,"&&")){
        return T_AND;
    }
    if(strcmp(yytext,"||")){
        return T_OR;
    }
    if(strcmp(yytext,"!")){
        return T_NOT;
    }
    if(strcmp(yytext,";")){
        return T_SEMICOLON;
    }
    if(strcmp(yytext,",")){
        return T_COMMA;
    }
    if(strcmp(yytext,".")){
        return T_DOT;
    }
    if(strcmp(yytext,"(")){
        return T_LBRACKET;
    }
    if(strcmp(yytext,")")){
        return T_RBRACKET;
    }
    if(strcmp(yytext,"^")){
        return T_DEG;
    }
    if(strcmp(yytext,"\\")){
        return T_BSLASH;
    }
    
    
}
"//".* {
    printf("%s",yytext)
}

[A-Za-z_$][A-Za-z_$0-9]{1,31}	{   //regularni izraz za indentifikato ili kljucne rijeci
				printf("%s",yytext);//stampa id koji prepozna
                return T_IDENTIFIER
			} 

[0-9][0-9]*|0[xX][0-9a-fA-F]+ {//regularni izraz za integer 
    printf("%s",yytext);
    return T_INT
}

[0-9]+\.[0-9]*([Ee][+-]?[0-9]+)? {//regularni izraz za double ili ovako [0-9]+\.[0-9]*([Ee][+-]?[0-9]+)?
    printf("%s",yytext);
    return T_DOUBLE
}
["]([^"\\\n]|\\.|\\\n)*["] {//regularni izraz za string
    printf("%s",yytext);
    return T_STRING
}
[ \t\r\n] {   //ignorisanje bjelina
}
.			{//nesto sto se nije poklopilo sa izrazima iznad poklopi ce se u tacku koju pisemo na dnu
printf("greska\n");
}
%%