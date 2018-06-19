#define TERM 1
#define NL 5
#define MAS 9
#define MUL 10
#define ENT 11
#define AND 14
#define OR 15
#define NOT 16
#define ID 20
#define ASIG 22
#define REAL 25
#define UNA 26
#define TIPO1 28
#define SI 30
#define TIPO2 33
#define COMM 36
#define SINO 37
#define WHILE 38


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
