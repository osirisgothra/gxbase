#include <stdio.h>
#include <stdlib.h>
#ifndef _WIN32
	#include <caca_conio.h>
#else
	#include <conio.h>
#endif
#include <string.h>

// char .... char v        phys/phys
// char*.... char v[]      ptr to chars,phys[x]
// char** .. char* v[]     ptr to ptr of chars, ptr to char[]s
// char*** . char** v[]	   ptr to ptrs of chars, ptr to ptrs of char[]s
// & = ref
int main(int argc, char* argv[], char**)
{
	if (argc > 1)
	{
		if (!strcmp(argv[1],"char"))
		{
			return getch();
		}	
		else
			printf("bad argument\n");
	}
	if (kbhit())
		return getch();
	else
		return 0;
}
