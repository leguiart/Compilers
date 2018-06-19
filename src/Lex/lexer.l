%{
#include <stdio.h>
#include <stdlib.h>
#include "tokens.h"
%}


letra [a-zA-Z]
digito [0-9]
id ({letra}|_)({letra}|{digito}|_)*
entero {digito}+
real {digito}*"."{digito}+

%option yylineno
%option noyywrap


%%

"+"	{ 
		val.cval = yytext[0];
		val.num.type = MAS;
		printf("[Clase: %i  , Valor: %c]\n", val.num.type, val.cval);
		return MAS; 
	}
	
"-"	{
		val.cval = yytext[0];
		val.num.type = MENOS;  
		printf("[Clase: %i  , Valor: %c]\n", val.num.type, val.cval);     
      		return MENOS; 
    	}
    
"*"	{       
		val.cval = yytext[0];
		val.num.type = MUL;
		printf("[Clase: %i  , Valor: %c]\n", val.num.type, val.cval);
      		return MUL; 
        } 
    
"/"	{
		val.cval = yytext[0];
		val.num.type = DIV;  
		printf("[Clase: %i  , Valor: %c]\n", val.num.type, val.cval);   
      		return DIV; 
    	}
    
"("	{
		val.cval = yytext[0];
		val.num.type = LPAR;
		printf("[Clase: %i  , Valor: %c]\n", val.num.type, val.cval);    
      		return LPAR; 
    	}
    
")"	{ 
		val.cval = yytext[0];
		val.num.type = RPAR;  
		printf("[Clase: %i  , Valor: %c]\n", val.num.type, val.cval);    
      		return RPAR; 
    	}
    
{entero}    {   
		val.num.ival = atoi(yytext);  
		val.num.type = NUM; 
		printf("[Clase: %i  , Valor: %i]\n", val.num.type, val.num.ival);        
              	return NUM;
            }	

{real}	{   
	    val.num.dval = atof(yytext);
	    val.num.type = NUM;
	    printf("[Clase: %i  , Valor: %f]\n", val.num.type, val.num.dval);
            return NUM;
        }

{id}  	{
		val.num.type = ID;		
		val.sval = (char*)malloc(strlen(yytext)*sizeof(char));
		strcpy(val.sval, yytext);
		printf("[Clase: %i  , Valor: %s]\n", val.num.type, val.sval);
		return ID;
	}


[ \t]+	{}

\n  {   
	val.cval = yytext[0];
	val.num.type = NL;
	printf("[Clase: %i  , Valor: Salto de Linea]\n", val.num.type);
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



