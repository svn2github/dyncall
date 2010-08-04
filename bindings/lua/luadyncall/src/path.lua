--- path strings specify a pattern through which objects are located.

--- Initialize lua-style paths.
-- Looks up environment variable envname and substitute all ';;' by syspath
-- @param envname name of environment variable
-- @param syspath default value if envname is not set and substitution for all ';;'.
-- @return value from env variable or syspath. ';;' in env will be substituted by syspath.

function pathinit(envname, syspath)
  local s = os.getenv(envname)
  if s then 
    s = s:gsub(";;",syspath)
  else
    s = syspath
  end
  return s
end


--- find object by searching through the path 
-- @param openfun function(expanded)
-- @return found, expanded 

function pathfind(path,name,openfun)  
  local replaced = path:gsub("?", name)
  local found = nil
  local fails = {}
  for expanded in replaced:gmatch("([^;]+)") do
    found = openfun(expanded)
    if found then return found, expanded end
    table.insert(fails, expanded)
  end
  return nil, fails
end

