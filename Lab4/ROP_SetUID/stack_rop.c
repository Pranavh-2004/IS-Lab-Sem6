#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int foo(char *str)
{
    char buffer[100];
    unsigned int *framep;

    // Copy ebp into framep
    asm("movl %%ebp, %0" : "=r" (framep));      

    /* print out information for experiment purpose */
    printf("Address of buffer[] inside foo():  0x%.8x\n", (unsigned)buffer);
    printf("Frame Pointer value inside foo():  0x%.8x\n", (unsigned)framep);
     printf("Distance (EBP - buffer) in bytes: %d\n",
           (int)((char *)framep - (char *)buffer));

    strcpy(buffer, str);   

    return 1;
}

//For the purpose of experiment
void bar(){
    static int i = 1;
    printf("Function bar() is invoked %d times\n", i++);
    return;
}

//For the purpose of experiment
void baz(int x){
    printf("The value of baz's argument : 0x%.8X\n", x);
}

int main(int argc, char **argv)
{
   char str[2000];
   FILE *badfile;
   
   char *shell = (char *)getenv("MYSHELL");
   
   if(shell)
   	printf("The '%s' strings address : 0x%.8x\n", shell, (unsigned int)shell);
   	
   badfile = fopen("badfile", "r");
   int length = fread(str, sizeof(char), 2000, badfile);
   printf("Address of str[] inside main():  0x%x\n", (unsigned int) str);
   printf("Input size: %d\n", length);

   foo(str);

   printf("Returned Properly\n");
   return 1;
}
