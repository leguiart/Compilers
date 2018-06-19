
# define YYTOKENTYPE
  enum yytokentype
  {
    MAS = 1,
    MUL = 2,
    LPAR = 3,
    RPAR = 4,
    NUM = 5,
    INT = 6,
    REAL = 7
  };

typedef struct _num{
	int ival;
	double dval;
	int tipo;
}num;

