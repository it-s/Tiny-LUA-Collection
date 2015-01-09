local tlc = tlc or {}
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
tlc.isZero = function( obj )
        return tlc.isNumber(obj) and obj == 0
end
tlc.isString = function( obj )
        return type(obj) == "string"
end
tlc.isEmptyString = function( obj )
        return tlc.isString(obj) and obj == ""
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

return tlc