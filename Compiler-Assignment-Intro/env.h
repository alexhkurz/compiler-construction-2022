#ifndef ENV_H_   /* Include guard */
#define ENV_H_

#include<stdio.h>
void printInt(int x){
  printf("%d\n", x);
}

void printDouble(double x){
  printf("%lf\n", x);
}

int readInt() {
	int x;
	scanf("%d", &x);
	return x;
}

double readDouble() {
	double x;
	scanf("%lf", &x);
	return x;
}

#endif // ENV_H_

