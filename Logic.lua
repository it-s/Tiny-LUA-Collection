--------------------------
--Logic functions
--------------------------
local function _e( b,c ) for d,e in pairs(c)do b[d]=e end;return b end
local function _f( obj ) return type(obj) == "function" end

-- isMoreThen - check is a is strictly more then limit
local function isMoreThen (a, limit, strict)
	if strict then 
        return (a > limit)
	else
		return (a >= limit)
	end
end

-- isLessThen - check is a is strictly less then limit
local function isLessThen (a,limit, strict)
	if strict then 
        return (a < limit)
	else
		return (a <= limit)
	end
end

-- isBetween - check if value a is strictly between two further values
local function isBetween (a, min, max, strict)
        return isMoreThen(a,min,strict) and isLessThen(a,max,strict)
end

-- isEqualTo - check is a is exactly equal to b
local function isEqualTo (a,b)
        return (a==b)
end

-- isZero - check is a is 0 value
local function isZero (a)
        return isEqualTo(a,0)
end

-- isPositive - check if a is strictly more then 0
local function isPositive (a)
        return (a>0)
end

-- isNegative - check if a is strictly less then 0
local function isNegative (a)
        return (a<0)
end

-- isFactorOf - 
local function isFactorOf (a,b)
        return ((a - math.floor(a/b)*b) ~= 0)
end

-- isOdd - check if a is an odd number
local function isOdd (a)
        return ((a - math.floor(a/2)*2) ~= 0)
end

-- isEven - check if a is an even number
local function isEven (a)
        return not isOdd(a)
end

-- ifTrue - if condition is satistied then return yes otherwise return no
local function ifTrue (condition, yes, no)
        if condition then return yes else return no end
end

local class = {
	isMoreThen = isMoreThen,
	isLessThen = isLessThen,
	isBetween = isBetween,
	isEqualTo = isEqualTo,
	isZero = isZero,
	isPositive = isPositive,
	isNegative = isNegative,
	isFactorOf = isFactorOf,
	isOdd = isOdd,
	isEven = isEven,
	ifTrue = ifTrue
}

-- finally we return the result
if _t(TLC) then
	_e(TLC, class)
else return class end