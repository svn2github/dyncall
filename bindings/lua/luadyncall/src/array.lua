require"larray"

local array_mt = {
  __index = function(t,i) 
    if type(i) == "number" then
      return larray.peek( t.pointer, t.typesize * (i-1), t.typeinfo ) 
    else 
      local result = rawget(t,i)
      if not result then
        return getmetatable(t)[i]
      end
    end
  end,
  __newindex = function(t,i,v) 
    if type(i) == "number" then
      return larray.poke( t.pointer, t.typesize * (i-1), t.typeinfo, v) 
    else
      return rawset(t,i,v)
    end
  end,
  copy = function(array,src,nelements) 
    return larray.copy( array.pointer, 0, src, 0, array.typesize * nelements)
  end
}

function typesize(typeinfo)
  return typesizes[typeinfo]
end

function array(typeinfo, length)
  local typesize = larray.sizeof(typeinfo)
  local size     = typesize * length
  local pointer  = larray.newudata(size)
  local o = { 
    pointer   = pointer, 
    size      = size, 
    length    = length, 
    typesize  = typesize, 
    typeinfo  = typeinfo,
  }
  setmetatable(o, array_mt)
  return o
end


