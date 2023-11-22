#include <stdlib.h>
#include <unistd.h>

void
function(void)
{
  char *name[2];

  name[0] = "/bin/sh";
  name[1] = NULL;

  execve(name[0], name, NULL);
}

int
main()
{
  function();

  return (0);
}
