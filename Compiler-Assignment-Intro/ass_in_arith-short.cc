#include "env.h"

int main() {
  int x = 50;
  int y = x+++x--;
  printInt(y);
  printInt(x);
  return 0;
}
