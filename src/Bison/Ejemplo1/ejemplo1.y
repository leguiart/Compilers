%{
	#include <stdio.h>
	void yyerror(char* s);
%}

%union{
		int ival;
		double dval;
		int tipo;
	}

%left MAS
%left MUL
%nonassoc LPAR RPAR
%token <ival> NUM

%type <ival> exp term factor

%start line 

%%
	line: exp{printf("%d\n", $1);};
	
	exp: exp MAS term{$$=$1+$3;}
	     | term{$$=$1;};
	
	term: term MUL factor{$$=$1*$3;}
	      |	factor{$$=$1;};
	
	factor: NUM {$$=$1;}
		| LPAR exp RPAR{$$=$2;};
	
%%

extern FILE *yyin;

int main(int argc, char* argv[])
{
	if(argc>1)
		yyin = fopen(argv[1], "r");
	yyparse();
	fclose(yyin);
	return 0; 
}

void yyerror(char* s)
{
	printf("%s\n",s);
}
