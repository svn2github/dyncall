#include <stdlib.h>
#include <stdio.h>

char get_next_char(char in) {
  return in+1;
}

int is_false(int in) {
  return !in;
}

short times_three(short in) {
  return in * 3;
}

long add_nineteen(long in) {
  return in + 19;
}

long long subtract_four(long long in) {
  return in - 4;
}

int add_seven(int in) {
  return in + 7;
}

int add_one(int in) {
  return in + 1;
}

void* coolmalloc(int sz) {
  void* ptr = malloc(sz);
  /* printf("I've allocated at addr %p\n",ptr); */
  return ptr;
}

void coolsetstr(void* buf, char* val) {
  sprintf(buf,"%s",val);
}

/* char* coolreadstr(void* ptr) { */
  
/* } */

void coolfree(void* ptr) {
  /* printf("The value to free is %s\n", ptr); */
  free(ptr);
}

char* interested_reply(char* yourname) {
  int totalmax = 256;
  char* buf = malloc(totalmax);
  snprintf(buf,totalmax,"Really, %s?  My name is Erik.",yourname);
  return buf;
}
