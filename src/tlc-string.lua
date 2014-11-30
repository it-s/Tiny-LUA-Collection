local tlc = tlc or {}
--------------------------
--String and Formatting functions
--------------------------

-- padString - pad a given string to be exactly len characters long
--				using padding character char or ' ' (space)
tlc.padString = function(str, len, char)
	if char == nil then char = ' ' end
	return string.rep(char, len - #str) .. str
end

return tlc