#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include "_auto_config.h"
#include "env.h"

const char* appname = "unknown";

/* test one case, returns error code */
int DoTest(int id);

#define MAX_ERRORS 1

/* capture total results for failure (0) and success (1) */
int totalErrorCodes[MAX_ERRORS];

void TestRange(int from, int to)
{
  int i;
  for(i = from ; i <= to ; ++i )
  {
    int status = DoTest(i);
    totalErrorCodes[status]++;
  }
}

void InitEnv();

void ExitWithUsage()
{
  PrintUsage(appname);
  exit(0);
}
        
#define Error(X, Y ) fprintf(stderr, X, Y );ExitWithUsage()

int main(int argc, char* argv[] )
{
  InitEnv();
  appname = argv[0];

  int from = 1;
  int to = CONFIG_NSIGS;
  int ncases;

  int i,j;
  int pos;
  pos = 0;
  for(i = 1 ; i < argc ; ++i ) {
    int number;

    if ( argv[i][0] == '-' ) {
      switch(argv[i][1]) {
        case 'v': OptionVerbose = 1; continue;
        case 'h': PrintUsage(appname); return 0;
        default: Error( "invalid option: %s", argv[i] );
      }      
    }

    number = atoi(argv[i]);
    switch(pos) {
      case 0: to   = from = number; ++pos; break;
      case 1: to   = number; break;
      default: Error("too many arguments", "");
    }
  }

  assert(from > 0);
  assert(to   <= CONFIG_NSIGS);
  assert(from <= to);

  ncases = (to - from) + 1;

  PrintHeader();
  TestRange(from, to);
  int totalResult = (totalErrorCodes[1] == ncases) ? 1 : 0; 
  PrintTotalResult(totalResult);

  return 0;
}

