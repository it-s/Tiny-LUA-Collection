local tlc = {}

--------------------------
--Useful functions
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

tlc.isModulePresent = 	tlc.isModuleAvailable -- ALIAS
tlc.isModuleLoaded 	= 	tlc.isModuleAvailable -- ALIAS
tlc.isLoaded 		= 	tlc.isModuleAvailable -- ALIAS
tlc.hasModule		= 	tlc.isModuleAvailable -- ALIAS

-- isDefined - checks if object exists
tlc.isDefined = function (object)
	return object ~= nil
end
tlc.existis = tlc.isDefined -- ALIAS
tlc.isDef =   tlc.isDefined -- ALIAS

-- tableHasKey - checks if table has a specific key and retrurn TRUE if it does
tlc.tableHasKey = function (table, key)
	return tlc.isDefined(table[key])
end
tlc.thK 	=	tlc.tableHasKey -- ALIAS
tlc.hk 		=	tlc.tableHasKey -- ALIAS

--------------------------
--Math and logic functions
--------------------------

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
tlc.cmp 	=	tlc.isBetween -- ALIAS
tlc.cl 		=	tlc.isBetween -- ALIAS

-- isBetween - check if value a is strictly between two further values
tlc.isBetween = function(a, min, max)
	return tlc.isMoreThen(a,min) and tlc.isLessThen(a,max)
end
tlc.isBN 	=	tlc.isBetween -- ALIAS
tlc.bwn 	=	tlc.isBetween -- ALIAS

-- isMoreThen - check is a is strictly more then limit
tlc.isMoreThen = function(a, limit)
	return (a > limit)
end
tlc.isMT 	=	tlc.isMoreThen -- ALIAS
tlc.mt 		=	tlc.isMoreThen -- ALIAS

-- isLessThen - check is a is strictly less then limit
tlc.isLessThen = function(a,limit)
	return (a < limit)
end
tlc.isLT 	=	tlc.isLessThen -- ALIAS
tlc.lt 		=	tlc.isLessThen -- ALIAS

-- isEqualTo - check is a is exactly equal to b
tlc.isEqualTo = function(a,b)
	return (a==b)
end
tlc.isEQ 	=	tlc.isEqualTo -- ALIAS
tlc.eq 		=	tlc.isEqualTo -- ALIAS

-- isZero - check is a is 0 value
tlc.isZero = function(a)
	return tlc.isEqualTo(a,0)
end
tlc.isZ 	=	tlc.isZero -- ALIAS
tlc.zro		=	tlc.isZero -- ALIAS

-- increaseBy - increase a by the amount specified
tlc.increaseBy = function(a, by)
	return (a+by)
end
tlc.incB 	=	tlc.increaseBy -- ALIAS
tlc.ib		=	tlc.increaseBy -- ALIAS

-- increase - increase a by 1
tlc.increase = function(a)
	return tlc.increaseBy(a,1)
end
tlc.inc 	=	tlc.increase -- ALIAS
tlc.i		=	tlc.increase -- ALIAS

-- decreaseBy - decrease a by the amount specified
tlc.decreaseBy = function(a,by)
	return tlc.increaseBy(a,by*-1)
end
tlc.decB 	=	tlc.decreaseBy -- ALIAS
tlc.db		=	tlc.decreaseBy -- ALIAS

-- increase - decrease a by 1
tlc.decrease = function(a)
	return tlc.increaseBy(a,-1)
end
tlc.dec 	=	tlc.decrease -- ALIAS
tlc.d		=	tlc.decrease -- ALIAS

-- isPositive - check if a is strictly more then 0
tlc.isPositive = function(a)
	return (a>0)
end
tlc.isP 	=	tlc.isPositive -- ALIAS
tlc.p		=	tlc.isPositive -- ALIAS

-- isNegative - check if a is strictly less then 0
tlc.isNegative = function(a)
	return not tlc.isPositive(a)
end
tlc.isN 	=	tlc.isNegative -- ALIAS
tlc.n		=	tlc.isNegative -- ALIAS

-- isFactorOf - check if a is strictly less then 0
tlc.isFactorOf = function(a,b)
	return ((a - math.floor(a/b)*b) ~= 0)
end

-- isOdd - check if a is an odd number
tlc.isOdd = function(a)
	return ((a - math.floor(a/2)*2) ~= 0)
end
tlc.isO 	=	tlc.isOdd -- ALIAS
tlc.o		=	tlc.isOdd -- ALIAS

-- isEven - check if a is an even number
tlc.isEven = function(a)
	return not tlc.isOdd(a)
end
tlc.isE 	=	tlc.isEven -- ALIAS
tlc.e		=	tlc.isEven -- ALIAS

-- switch - if condition is satistied then return yes otherwise return no
tlc.switch = function(condition, yes, no)
	if condition then
		return yes
	else
		return no
	end
end
tlc.swt 	=	tlc.isEven -- ALIAS
tlc.s		=	tlc.isEven -- ALIAS

--------------------------
--String and Formatting functions
--------------------------

-- padString - pad a given string to be exactly len characters long
--				using padding character char or ' ' (space)
tlc.padString = function(str, len, char)
	if char == nil then char = ' ' end
	return string.rep(char, len - #str) .. str
end
tlc.pad 	=	tlc.padString -- ALIAS

return tlc
