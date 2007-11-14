#include <stdio.h>
#include <string.h>
#include "config.h"
#include "git-buildmsg.h"

int main(int argc, char *argv[])
{
  const char *const lastslash = strrchr(argv[0], '/');
  const char *const self = (lastslash)?(lastslash+1):(argv[0]);
  printf("%s: v%s, %s\n", self, PACKAGE_VERSION, GIT_MESSAGE);
  return 0;
}
