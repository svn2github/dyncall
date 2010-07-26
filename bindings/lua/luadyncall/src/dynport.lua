require "dynload"
require "dyncall"

local function makewrapper(addr, signature)
  return function(...) return dyncall(addr, signature, ...) end
end

loaded = { }

function dynport(name, t)

  local iter = io.lines(name..".dynport")
  local unit = t
  
  if not unit then
    unit = loaded[name]
    if unit then return unit end
    unit = { }
  end
  
  local libs = { }

  function dolib()
    local libnames = ""
    for line in iter do
      if line == "." then break end
      libnames = line
    end
    libs[#libs+1] = dynload(libnames)
  end

  function dofun()
    local index = 1
    local unresolved = {}
    for line in iter do

      if line == "." then break end

      local pos       = line:find("[(]")
      local symbol    = line:sub(1, pos-1)
      local stop      = line:find("[;]", pos+1)
      local signature = line:sub(pos+1,stop-1)

      local addr      = dynsym(libs[#libs], symbol)

      if type(addr) == "userdata" then
        rawset(unit, symbol, makewrapper(addr, signature) )
        -- module[symbol] = makewrapper(addr, signature)
      else
        unresolved[#unresolved] = symbol
      end

    end

    if #unresolved ~= 0 then
      print("unresolved symbols:")
      print(table.concat(unresolved,"\n"))
    end
  end

  function doconst() 
    for line in iter do
      if line == "." then break end
      local pos = line:find("=")
      local key = line:sub(1, pos-1)
      local value = line:sub(pos+1)
      -- module[key] = tonumber(value)
      rawset( unit, key, tonumber(value) )
    end
  end

  function dostruct()
    for line in iter do
      if line == "." then break end
    end
  end

  function dounion()
    for line in iter do
      if line == "." then break end
    end
  end
  
  for line in iter do
    if line == "." then break 
    elseif line == ":lib" then dolib() 
    elseif line == ":fun" then dofun() 
    elseif line == ":const" then doconst() 
    elseif line == ":struct" then dostruct()
    elseif line == ":union" then dounion()
    end
  end

  -- module._libs = libs
  rawset(unit, "_LIBS", libs)

  return unit

end
