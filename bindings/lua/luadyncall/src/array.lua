require"larray"

local array_mt = {
  __index = function(t,i) 
    return larray.peek( t.pointer, t.typesize * (i-1), t.typeinfo ) 
  end,
  __newindex = function(t,i,v) 
    return larray.poke( t.pointer, t.typesize * (i-1), t.typeinfo, v) 
  end,
  __len = function(t)
    print("LEN!")
    return t.length
  end,
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


