local tlc = tlc or {}
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

return tlc