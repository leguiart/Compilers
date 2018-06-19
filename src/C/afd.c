//Eguiarte Morett Luis Andres ---- Programa 1 ---- Compiladores ---- Grupo:03
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdint.h>

//Seccion de declaraciones
char c;
//stream de archivo
FILE* archivo;
//Tabla de transicion de AFD
			 //espacio letra  i  f  e  l  s [<>] [{}[]]    =   @  digito  .
int afd[16][13] = {{ 1,    2, 2, 2, 2, 2, 2,   3,    4,    5,  6,     13,-1}, //q0
				   { 0,    0, 0, 0, 0, 0, 0,   0,    0,    0,  6,     -1,-1}, //q1
		           { 0,    2, 2, 2, 2, 2, 2,   0,    0,    0, -1,     -1,-1}, //q2
		           { 0,    0, 0, 0, 0, 0, 0,   0,    0,    0, -1,      0,-1}, //q3
		           { 0,    0, 0, 0, 0, 0, 0,   0,    0,    0,  6,      0,-1}, //q4
				   { 0,    0, 0, 0, 0, 0, 0,  -1,   -1,   -1, -1,      0,-1}, //q5
				   {-1,   -1, 7,-1, 9,-1,-1,  -1,   -1,   -1, -1,     -1,-1}, //q6
				   {-1,   -1,-1, 8,-1,-1,-1,  -1,   -1,   -1, -1,     -1,-1}, //q7
				   { 0,   -1,-1,-1,-1,-1,-1,  -1,   -1,   -1, -1,     -1,-1}, //q8
				   {-1,   -1,-1,-1,-1,10,-1,  -1,   -1,   -1, -1,     -1,-1}, //q9
				   {-1,   -1,-1,-1,-1,-1,11,  -1,   -1,   -1, -1,     -1,-1}, //q10
				   {-1,   -1,-1,-1,12,-1,-1,  -1,   -1,   -1, -1,     -1,-1}, //q11
				   { 0,   -1,-1,-1,-1,-1,-1,  -1,   -1,   -1, -1,     -1,-1}, //q12
			       {-1,   -1,-1,-1,-1,-1,-1,  -1,   -1,   -1, -1,     13,14}, //q13
			       {-1,   -1,-1,-1,-1,-1,-1,  -1,   -1,   -1, -1,     15,-1}, //q14
				   { 0,   -1,-1,-1,-1,-1,-1,  -1,   -1,   -1, -1,     15,-1}};//q15
				   
			//   q0  q1 q2 q3 q4 q5 q6 q7 q8 q9 q10 q11 q12 q13 q14 q15
int finales[] = { 0 , 1, 1, 1, 0, 1, 1, 0, 1, 0,  0,  0,  1,  1,  0,  1};

//Definicion de tipo estructura token
struct _token
{
	int clase;
	char* valor;
};
typedef struct _token token;

//definiendo funciones
token nextToken();
int clase(int edo);
int posicion(char c);
void error();

//Main
/* Main con argumentos para manejo de archivos
   Incluye verificacion de validez del archivo
   Llama a la funcion nextToken hasta llegar al final
   del archivo*/
//@Eguiarte
int main(int argc, char** argv)
{
	if(argc>1)
	{
		archivo = fopen(argv[1], "r");
		if(!archivo)
			exit(1);
	}
	else
	{
		printf("\nArgumento invalido\n");
		exit(1);
	}
	c = fgetc(archivo);
	token tok;
	tok = nextToken();
	
	while(!feof(archivo))
	{	
		//c = fgetc(archivo);
		printf("\t[Clase: %i , Valor:  %s]\n", tok.clase, tok.valor);
		tok = nextToken();
		if(tok.clase == -1)
		{
			printf("\t[Clase: %i , Valor:  %s]\n", tok.clase, tok.valor);
			exit(0);
		}
	}
	fclose(archivo);
	return 0;
}

//nextToken
/*Obtiene el siguiente Token:
  Si afd en el estado q con posicion del caracter actual leido c:
	-diferente de -1 y de 0
		concatenar(buffer,c)
	-igual a 0
		regresar token
		q = afd[q][posicion(c)]
	-igual a -1
		regresar mensaje de error seguido de token*/
//@Eguiarte
token nextToken()
{
	char* buffer = "";
	int q = 0;
	while(1)
	{
		if(afd[q][posicion(c)]!=-1 && afd[q][posicion(c)]!=0)
		{
			char* aux;			
			size_t len = strlen(buffer);
			aux = malloc(len+2);
			strcpy(aux, buffer);
			aux[len]=c;
			aux[len+1]='\0';
			buffer = aux;
			q = afd[q][posicion(c)];
			c = fgetc(archivo);
		}
		else if (afd[q][posicion(c)]==0)
		{
			if(q!=1 && finales[q])
			{
				token tok;
				tok.clase = clase(q);
				tok.valor = (char*)malloc(strlen(buffer)*sizeof(char));
				strcpy(tok.valor, buffer);
				return tok;
			}
			q=afd[q][posicion(c)];
			buffer = "";

		}
		else
		{	
			error();
			token tok;
			tok.clase = clase(-1);
			tok.valor = (char*)malloc(strlen(buffer)*sizeof(char));
			strcpy(tok.valor, buffer);
			return tok;
		}
	}

}

//clase
/*Regresa la clase lexica correspondiente con base en el estado de entrada*/
//@Eguiarte
int clase(int edo)
{
	switch(edo)
	{	
		case -1: return -1;
		case 2: return 2;
		case 3: return 3;
		case 5: return 5;
		case 6: return 6;
		case 8: return 8;
		case 12: return 12;
		case 13: return 13;
		case 15: return 15;
	}
	return 0;
}

//posicion
/*Regresa la posicion de la columna en el AFD correspondiente al caracter leido */
//@Eguiarte
int posicion(char c)
{
	if(c==' '||c=='\n'||c=='\t') return 0;
	else if(c=='i') return 2;
	else if(c=='f') return 3;
	else if(c=='e') return 4;
	else if(c=='l') return 5;
	else if(c=='s') return 6;
	else if(c=='<'||c=='>') return 7;
	else if(c=='['||c=='{'||c=='}'||c==']') return 8;
	else if(c=='=') return 9;
	else if(c=='@') return 10;
	else if(c=='.') return 12;
	else if(isalpha(c)) return 1;
	else if(isdigit(c)) return 11; 
}

//error
/*Regresa un mensaje de error lexico*/
//@Eguiarte
void error()
{
	printf("Error Lexico:\t");
}

