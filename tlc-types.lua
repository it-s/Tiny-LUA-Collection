--------------------------
--Object type tests
--------------------------
local type = type

-- isTable, isNumber, isString, isFunction, isBoolean, isNil - object type testers
local function isTable ( obj )
        return type(obj) == "table"
end
local function isNumber ( obj )
        return type(obj) == "number"
end
local function isZero ( obj )
        return isNumber(obj) and obj == 0
end
local function isString ( obj )
        return type(obj) == "string"
end
local function isEmptyString ( obj )
        return isString(obj) and obj == ""
end
local function isFunction ( obj )
        return type(obj) == "function"
end
local function isBoolean ( obj )
        return type(obj) == "boolean"
end
local function isNil ( obj )
        return type(obj) == "nil"
end
-- isDefined - checks if object exists
local function isDefined  (object)
        return not isNil(object)
end

local class = {
	isTable = isTable,
	isNumber = isNumber,
	isZero = isZero,
	isString = isString,
	isEmptyString = isEmptyString,
	isFunction = isFunction,
	isBoolean = isBoolean,
	isNil = isNil,
	isDefined = isDefined
}

-- finally we return the result
if _t(TLC) then
	_e(TLC, class)
else return class end