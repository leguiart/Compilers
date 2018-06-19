%{
#include <stdio.h>
#include <stdlib.h>
#include "tokens.h"
%}


letra [a-zA-Z]
digito [0-9]
id (v{letra}({letra}|{digito})*)|(v{digito}({letra}|{digito})*)
entero {digito}+
real {digito}*"."{digito}+
comentarios --[^--]*--

%option yylineno
%option noyywrap


%%

{comentarios}	{
			val.num.type = COMM;		
			val.sval = (char*)malloc(strlen(yytext)*sizeof(char));
			strcpy(val.sval, yytext);
			printf("[Clase: %i  , Valor: %s]\n", val.num.type, val.sval);
			return COMM;
		}		

"%" 	{
			val.cval = yytext[0];
			val.num.type = TERM;
			printf("[Clase: %i  , Valor: %c]\n", val.num.type, val.cval);
			return TERM;	
		}

"+"		{ 
			val.cval = yytext[0];
			val.num.type = MAS;
			printf("[Clase: %i  , Valor: %c]\n", val.num.type, val.cval);
			return MAS; 
		}
	
    
"*"		{       
			val.cval = yytext[0];
			val.num.type = MUL;
			printf("[Clase: %i  , Valor: %c]\n", val.num.type, val.cval);
		  	return MUL; 
        } 
    
        
"<="	{
			val.num.type = ASIG;
			val.sval = (char*)malloc(strlen(yytext)*sizeof(char));
			strcpy(val.sval, yytext);
			printf("[Clase: %i  , Valor: %s]\n", val.num.type, val.sval);
			return ASIG;
		}
		
"ent"	{
			val.num.type = TIPO1;
			val.sval = (char*)malloc(strlen(yytext)*sizeof(char));
			strcpy(val.sval, yytext);
			printf("[Clase: %i  , Valor: %s]\n", val.num.type, val.sval);
			return TIPO1;
		}
		
"real"  {
			val.num.type = TIPO2;
			val.sval = (char*)malloc(strlen(yytext)*sizeof(char));
			strcpy(val.sval, yytext);
			printf("[Clase: %i  , Valor: %s]\n", val.num.type, val.sval);
			return TIPO2;
		}
	
"shi"	{
			val.num.type = SI;
			val.sval = (char*)malloc(strlen(yytext)*sizeof(char));
			strcpy(val.sval, yytext);
			printf("[Clase: %i  , Valor: %s]\n", val.num.type, val.sval);
			return SI;
		}
		
"shino" {
			val.num.type = SINO;
			val.sval = (char*)malloc(strlen(yytext)*sizeof(char));
			strcpy(val.sval, yytext);
			printf("[Clase: %i  , Valor: %s]\n", val.num.type, val.sval);
			return SINO;
		}
		
"guail" {
			val.num.type = WHILE;
			val.sval = (char*)malloc(strlen(yytext)*sizeof(char));
			strcpy(val.sval, yytext);
			printf("[Clase: %i  , Valor: %s]\n", val.num.type, val.sval);
			return WHILE;
		}
		
":)"	{
			val.num.type = UNA;
			val.sval = (char*)malloc(strlen(yytext)*sizeof(char));
			strcpy(val.sval, yytext);
			printf("[Clase: %i  , Valor: %s]\n", val.num.type, val.sval);
			return UNA;
		}
		
"Y"		{
			val.cval = yytext[0];
			val.num.type = AND;
			printf("[Clase: %i  , Valor: %c]\n", val.num.type, val.cval);
			return AND;	
		}
		
"O"		{
			val.cval = yytext[0];
			val.num.type = OR;
			printf("[Clase: %i  , Valor: %c]\n", val.num.type, val.cval);
			return OR;	
		}
		
"~"		{
			val.cval = yytext[0];
			val.num.type = NOT;
			printf("[Clase: %i  , Valor: %c]\n", val.num.type, val.cval);
			return NOT;	
		}
		
{entero} {   
			val.num.ival = atoi(yytext);  
			val.num.type = ENT; 
			printf("[Clase: %i  , Valor: %i]\n", val.num.type, val.num.ival);        
		    return ENT;
         }	

{real}	{   
			val.num.dval = atof(yytext);
			val.num.type = REAL;
			printf("[Clase: %i  , Valor: %f]\n", val.num.type, val.num.dval);
		    return REAL;
        }

{id}  	{
			val.num.type = ID;		
			val.sval = (char*)malloc(strlen(yytext)*sizeof(char));
			strcpy(val.sval, yytext);
			printf("[Clase: %i  , Valor: %s]\n", val.num.type, val.sval);
			return ID;
		}	
		
[ \t]+	{ }

\n		{
			val.cval = yytext[0];
			val.num.type = NL;
			printf("[Clase: %i  , Valor: Separador]\n", val.num.type);
			return NL; 
		}	
		
.   {printf("Error léxico: en la línea %d, con el símbolo %s\n", yylineno, yytext);}

<<EOF>>   {exit(0);}
%%

extern FILE* yyin;
int main(int argc, char** argv)
{
	int cont = 0;
	if(argc>1)
	{
		FILE* archivo = fopen(argv[1], "r");
		if(!archivo)
			exit(1);
		yyin = archivo;
	}
	else
	{
		printf("\nArgumento invalido\n");
		exit(1);
	}
	while(yywrap())
		yylex();
		/*
		switch(val.num.type)
		{
			case(1): printf("[Clase: %i  , Valor: %c]\n", val.num.type, val.cval);
			case(2): printf("[Clase: %i  , Valor: %c]\n", val.num.type, val.cval);
			case(3): printf("[Clase: %i  , Valor: %c]\n", val.num.type, val.cval);
			case(4): printf("[Clase: %i  , Valor: %c]\n", val.num.type, val.cval);
			case(5): printf("[Clase: %i  , Valor: %c]\n", val.num.type, val.cval);
			case(6): printf("[Clase: %i  , Valor: %c]\n", val.num.type, val.cval);
			case(7): 
			case(8):
			case(9):
		}
		*/
	return 0;
}



