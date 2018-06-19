#define MAS 1
#define MENOS 2
#define MUL 3
#define DIV 4
#define LPAR 5
#define RPAR 6
#define NUM 7
#define ID 8
#define NL 9

struct _tval
{
	struct{	
		int ival;
		int type;
		double dval;
	}num;
	char cval;
	char* sval;
};
typedef struct _tval tval;

tval val;