#include "dyncall.h"
#include "dyncall_signature.h"

size_t dtSize(const char* signature)
{
  char ch = *signature;
  switch(ch)
  {
    case DC_SIGCHAR_BOOL: return sizeof(DCbool);
    case DC_SIGCHAR_CHAR: return sizeof(DCchar);
    case DC_SIGCHAR_UCHAR: return sizeof(DCuchar);
    case DC_SIGCHAR_SHORT: return sizeof(DCshort);
    case DC_SIGCHAR_USHORT: return sizeof(DCushort);
    case DC_SIGCHAR_INT: return sizeof(DCint);
    case DC_SIGCHAR_UINT: return sizeof(DCuint);
    case DC_SIGCHAR_LONG: return sizeof(DClong);
    case DC_SIGCHAR_ULONG: return sizeof(DCulong);
    case DC_SIGCHAR_LONGLONG: return sizeof(DClonglong);
    case DC_SIGCHAR_ULONGLONG: return sizeof(DCulonglong);
    case DC_SIGCHAR_FLOAT: return sizeof(DCfloat);
    case DC_SIGCHAR_DOUBLE: return sizeof(DCdouble);
    case DC_SIGCHAR_POINTER: return sizeof(DCpointer);
    case DC_SIGCHAR_STRING: return sizeof(DCstring);
    case DC_SIGCHAR_VOID: return sizeof(DCvoid);
    default: return 0;
  }
}

size_t dtAlign(const char* signature)
{
  return dtSize(signature);
}


