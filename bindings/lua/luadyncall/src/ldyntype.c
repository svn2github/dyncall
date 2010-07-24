#include "lua.h"
#include "lauxlib.h"
#include "dyntype.h"

int lua_dtSize(lua_State *L)
{ 
  const char* signature = luaL_checkstring(L, 1);
  lua_pushinteger(L, dtSize(signature));
  return 1;
}

int lua_dtAlign(lua_State *L)
{ 
  const char* signature = luaL_checkstring(L, 1);
  lua_pushinteger(L, dtAlign(signature));
  return 1;
}


static const struct luaL_Reg luareg_ldyntype[] =
{
  { "dtSize", lua_dtSize },
  { "dtAlign", lua_dtAlign },
  { NULL, NULL }
};

LUA_API int luaopen_ldyntype(lua_State *L)
{
  luaL_register(L, "ldyntype", luareg_ldyntype);
  return 1;
}

