local tlc = {}

--------------------------
--Table related functions
--------------------------

-- tableHasKey - checks if table has a specific key and retrurn TRUE if it does
tlc.tableHasKey = function (tbl, key)
	return tlc.isDefined(tbl[key])
end

-- tableKeys - get a table of keys from the source table
tlc.tableKeys = function (tbl)
	if not tlc.isTable( tbl ) then return error("Could not extract keys. Object is not a table.") end
	local keys = {}
	local n = 0
	
	for key, value in pairs(tbl) do
	  n = n + 1
	  keys[n] = key
	end
	return keys
end

-- Iterator - create an iterator object from source table
tlc.Iterator = function(tbl)
	if not tlc.isTable( tbl ) then return error("Could not create an Iterator. Object is not a table.") end
	local obj = tbl
	local keys = tlc.tableKeys(tbl)
	local cursor = 1
	local iterator = {}
	iterator.total = function()
		return #obj
	end
	iterator.hasNext = function()
		return tlc.switch (
				tlc.isMoreThen(tlc.increment(cursor), #obj),
				false,
				true
			)
	end
	iterator.key = function()
		return keys[cursor]
	end
	iterator.value = function()
		return obj[keys[cursor]]
	end
	iterator.next = function()
		cursor = tlc.increase(cursor)
		return obj[keys[cursor]]
	end
	iterator.getCursor = function()
		return cursor
	end
	iterator.setCursor = function(i)
		cursor = tlc.clamp( i, 0, #obj)
	end
	iterator.toBeginning = function()
		cursor = 1
	end
	iterator.toEnd = function()
		cursor = #obj
	end
	return iterator
end

-- tableCopy - create a shallow copy of the source table
tlc.tableCopy = function( tbl )
	if not tlc.isTable( tbl ) then return error("Could not create a copy. Object is not a table.") end
	local iterator = tlc.Iterator (tbl)
	local res = {}
	while( iterator.hasNext() ) do
		res[iterator.key()] = iterator.value()
		iterator.next()
	end
	return res
end

-- tableExtend - copy keys from source table to the destination table
tlc.tableExtend = function( dest, src )
	if not tlc.isTable( dest ) then return error("Destination is not a table.") end
	if not tlc.isTable( src ) then return dest end
	local iterator = tlc.Iterator (src)
	while( iterator.hasNext() ) do
		dest[iterator.key()] = iterator.value()
		iterator.next()
	end
	return dest
end

-- tableHasRequiredKeys -- check if the required keys are present in the table and their values is not a nil
tlc.tableHasRequiredKeys = function( tbl, rec )
	if not tlc.isTable( dest ) then return error("Destination is not a table.") end
	if not tlc.isTable( rec ) then return error("Requirement is not a table.") end
	local iterator = tlc.Iterator (rec)
	while( iterator.hasNext() ) do
		local test = iterator.next()
		if not tlc.tableHasKey( tbl, test ) or not tlc.isDefined( tbl[test] ) then
			return false
		end
	end
	return true
end

--------------------------
--Object type tests
--------------------------

-- isTable, isNumber, isString, isFunction, isBoolean, isNil - object type testers
tlc.isTable  = function( obj )
	return type(obj) == "table"
end
tlc.isNumber = function( obj )
	return type(obj) == "number"
end
tlc.isString = function( obj )
	return type(obj) == "string"
end
tlc.isFunction = function( obj )
	return type(obj) == "function"
end
tlc.isBoolean = function( obj )
	return type(obj) == "boolean"
end
tlc.isNil = function( obj )
	return type(obj) == "nil"
end
-- isDefined - checks if object exists
tlc.isDefined = function (object)
	return not tlc.isNil(object)
end

--------------------------
--Math functions
--------------------------

-- increase - increase a by the amount specified
tlc.increase = function(a, by)
	return (a + by)
end

-- increase - increase a by 1
tlc.increment = function(a)
	return tlc.increase(a,1)
end

-- decreaseBy - decrease a by the amount specified
tlc.decrease = function(a,by)
	return tlc.increase(a, by*-1)
end

-- increase - decrease a by 1
tlc.decrement = function(a)
	return tlc.increase(a,-1)
end

-- clamp — constrain a value to lie between two further values
tlc.clamp = function(a, limitA, limitB)
	if limitB
		and a > limitB then
			a = limitB
	end
	if limitA and
		(limitB and a < limitA)
		or
		(not limitB and a > limitA) then
			a=limitA
	end
	return a
end

--------------------------
--Logic functions
--------------------------

-- isBetween - check if value a is strictly between two further values
tlc.isBetween = function(a, min, max)
	return tlc.isMoreThen(a,min) and tlc.isLessThen(a,max)
end

-- isMoreThen - check is a is strictly more then limit
tlc.isMoreThen = function(a, limit)
	return (a > limit)
end

-- isLessThen - check is a is strictly less then limit
tlc.isLessThen = function(a,limit)
	return (a < limit)
end

-- isEqualTo - check is a is exactly equal to b
tlc.isEqualTo = function(a,b)
	return (a==b)
end

-- isZero - check is a is 0 value
tlc.isZero = function(a)
	return tlc.isEqualTo(a,0)
end

-- isPositive - check if a is strictly more then 0
tlc.isPositive = function(a)
	return (a>0)
end

-- isNegative - check if a is strictly less then 0
tlc.isNegative = function(a)
	return not tlc.isPositive(a)
end

-- isFactorOf - check if a is strictly less then 0
tlc.isFactorOf = function(a,b)
	return ((a - math.floor(a/b)*b) ~= 0)
end

-- isOdd - check if a is an odd number
tlc.isOdd = function(a)
	return ((a - math.floor(a/2)*2) ~= 0)
end

-- isEven - check if a is an even number
tlc.isEven = function(a)
	return not tlc.isOdd(a)
end

-- switch - if condition is satistied then return yes otherwise return no
tlc.switch = function(condition, yes, no)
	if condition then
		return yes
	else
		return no
	end
end

--------------------------
--String and Formatting functions
--------------------------

-- padString - pad a given string to be exactly len characters long
--				using padding character char or ' ' (space)
tlc.padString = function(str, len, char)
	if char == nil then char = ' ' end
	return string.rep(char, len - #str) .. str
end

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
