#include <stdlib.h>
#include <stdio.h>
#include <string.h>

FILE* archivo;
char* imprimeArchivo();

int main(int argc, char** argv)
{
	if(argc>1)
	{
		archivo = fopen(argv[1], "r");
		if(!archivo)
			exit(1);
		
		c = fgetc(archivo);
	}
	else
	{
		printf("\nArgumento invalido\n");
		exit(1);
	}
	return 0;
}

char* imprimeArchivo()
{
	char* buffer = "";
	while(c!=EOF)
	{
		char* name = "hello";
		const char* extension = ".txt";
		char* aux;
		aux = malloc(strlen(name)+1+4); /* make space for the new string (should check the return value ...) */
		strcpy(aux, name); /* copy name into the new var */
		strcat(aux, extension); /* add the extension */
		aux = malloc(strlen(c)+1+4);
		strcpy(aux, c);
		strcat(buffer, aux);
		c =fgetc(archivo);
		//strcat(buffer,(char*)malloc(strlen((char*)c)*sizeof(char)));
		//strncat(buffer, &c, 1);
		//strcat(buffer, (char *) (intptr_t) c);
		//strcat(buffer, aux);
		//strcat(buffer, fgetc(c));
	}
}