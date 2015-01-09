--------------------------
--Misc useful functions
--------------------------
local type = type
local pairs = pairs
local ipairs = ipairs
local randomseed = math.randomseed
local random = math.random
local format = string.format

local function _e( b,c ) for d,e in pairs(c)do b[d]=e end;return b end
local function _f( obj ) return type(obj) == "function" end
local function _t( obj ) return type(obj) == "table" end

-- Check if module [name] is already loaded
-- http://stackoverflow.com/questions/15429236/how-to-check-if-a-module-exists-in-lua
local function isModuleAvailable (name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if _f(loader) then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

-- requireModule - add all functions from the required module to the object
local function requireModule(modules, baseDir)
  baseDir = baseDir or ""
  modules = modules or {}
  for i, name in ipairs(modules) do
    local module = require (baseDir .. name)
    _c(self, module)
  end
  return self
end

-- UID - Generate a semi-random ID from os.time()
local function UID ()
	randomseed(os.time())
	local id = random( ) * 1000000
	return (format("%07d", id))
end

local class = {
	isModuleAvailable = isModuleAvailable,
	requireModule = requireModule,
	UID = UID
}

-- finally we return the result
if _t(TLC) then
	_e(TLC, class)
else return class end