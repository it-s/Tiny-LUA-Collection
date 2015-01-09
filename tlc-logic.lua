local tlc = tlc or {}
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

-- ifTrue - if condition is satistied then return yes otherwise return no
tlc.ifTrue = function(condition, yes, no)
        if condition then return yes else return no end
end


return tlc