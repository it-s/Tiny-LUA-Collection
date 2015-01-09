--------------------------
--Math functions
--------------------------

-- increase - increase a by the amount specified
local function increase (a, by)
        return (a + by)
end

-- increase - increase a by 1
local function increment (a)
        return increase(a,1)
end

-- decreaseBy - decrease a by the amount specified
local function decrease (a,by)
        return increase(a, by*-1)
end

-- increase - decrease a by 1
local function decrement (a)
        return increase(a,-1)
end

-- clamp — constrain a value to lie between two further values
local function clamp (a, min, max)
        if max
                and a > max then
                        a = max
        end
        if min
                and a < min  then
                        a = min
        end
        return a
end

local class = {
	increase = increase,
	increment = increment,
	decrease = decrease,
	decrement = decrement,
	clamp = clamp
}

-- finally we return the result
if _t(TLC) then
	_e(TLC, class)
else return class end