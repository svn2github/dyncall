require "ldyncall"
require "dynload"

--- invoke dynamic foreign function call
-- This is a front-end function that provides several interfaces
-- @param target Target signature 
-- @param ... if target is a string, then the arguments follow.
-- @see dodyncall for details 

function dyncall(target, ...)
  local t = type(target)
  if t == "string" then
    local libnames, sym, sig = target:match("^@(.+)/(.+)%((.+)")
    local lib = dynload(libnames) -- hold reference as long as the call
    return ldyncall.dodyncall( dynsym( lib,sym ), sig, ...)
  else
    return ldyncall.dodyncall( target, ...)
  end
end
 
