--------------------------
--String and Formatting functions
--------------------------
local rep = string.rep
local tostring = tostring
local _n ( obj ) return type(obj) == "number"; end

-- padString - pad a given string to be exactly len characters long
--				using padding character char or ' ' (space)
local function padString (str, len, char)
	if char == nil then char = ' ' end
	return rep(char, len - #str) .. str
end

local function formatNumber (n, decimal) -- credit http://richard.warburton.it
	if _n(n) then n = tostring(n); end
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

local class = {
	padString = padString,
	formatNumber = formatNumber
}

-- finally we return the result
if _t(TLC) then
	_e(TLC, class)
else return class end