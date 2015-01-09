--------------------------
--String and Formatting functions
--------------------------
local rep = string.rep

-- padString - pad a given string to be exactly len characters long
--				using padding character char or ' ' (space)
local function padString(str, len, char)
	if char == nil then char = ' ' end
	return rep(char, len - #str) .. str
end

local class = {
	padString = padString
}

-- finally we return the result
if _t(TLC) then
	_e(TLC, class)
else return class end