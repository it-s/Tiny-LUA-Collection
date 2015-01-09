local tlc = tlc or {}
--------------------------
--Misc seful functions
--------------------------

-- Check if module [name] is already loaded
-- http://stackoverflow.com/questions/15429236/how-to-check-if-a-module-exists-in-lua
tlc.isModuleAvailable = function (name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

-- UID - Generate a semi-random ID from os.time()
tlc.UID = function ()
	math.randomseed(os.time())
	local id = math.random( ) * 1000000
	return (string.format("%07d", id))
end

return tlc