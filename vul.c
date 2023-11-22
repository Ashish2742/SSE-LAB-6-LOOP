/*
 * Stack-smashing example against vulnerable program based on one in Smashing
 * the Stack for Fun and Profit by Aleph One.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

unsigned int
getesp()
{
  __asm__("movl     %esp,%eax");
}

int
copy(const char *input)
{
  char vbuf[1024];

  strcpy(vbuf, input);

  printf("Vulnerable buffer at %p\n", (void *)&vbuf);

  return (0);
}

int
main(int argc, const char *argv[])
{
  printf("Vulnerable stack top at %p\n", (void *)getesp());

  if (argc != 2) {
    printf("Usage: %s string\n", argv[0]);
    exit(EXIT_FAILURE);
  }

  copy(argv[1]);

  return (0);
}
