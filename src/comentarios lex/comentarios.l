%{
#include <stdio.h>
%}


%option noyywrap
%option yylineno

%s comentario


id [a-zA-Z_][a-zA-Z0-9_]*


%%
<INITIAL>{
{id}	{ }
[ \n\t]+	{}
"/*"	{ printf("Inicia comentario\n");
	  BEGIN comentario;}
"*/"	{ printf("Error con %s\n", yytext);}
.	{ printf("Error con %s\n", yytext);}
}

<comentario>{
"*/"	{ printf("Termina comentario\n"); BEGIN INITIAL;}
[^*/]	{ }
"/"    { }
"*"  { }
}

%%

int main(int argc, char** argv){
	FILE *f;
	if(argc > 1){
		f = fopen(argv[1], "r");
		if(!f){
			printf("Error al abrir el archivo %s\n", argv[1]);
			 return 1;
		}
		yyin = f;
		yylex();
	}
	return 0;
}
