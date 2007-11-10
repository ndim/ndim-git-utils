#include <stdio.h>
#include <string.h>
#include "git-buildmsg.h"

int main(int argc, char *argv[])
{
  const char *const lastslash = strrchr(argv[0], '/');
  const char *const self = (lastslash)?(lastslash+1):(argv[0]);
  printf("%s: %s\n", self, GIT_MESSAGE);
  return 0;
}
