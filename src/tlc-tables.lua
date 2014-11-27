--------------------------
--Table related functions
--------------------------

-- tableHasKey - checks if table has a specific key and retrurn TRUE if it does
tlc.tableHasKey = function (tbl, key)
	return tlc.isDefined(tbl[key])
end

-- tableKeys - get a table of keys from the source table
tlc.tableKeys = function (tbl)
	if not tlc.isTable( tbl ) then return error("Could not extract keys. Object is not a table.") end
	local keys = {}
	local n = 0
	
	for key, value in pairs(tbl) do
	  n = n + 1
	  keys[n] = key
	end
	return keys
end

-- Iterator - create an iterator object from source table
tlc.Iterator = function(tbl)
	if not tlc.isTable( tbl ) then return error("Could not create an Iterator. Object is not a table.") end
	local obj = tbl
	local keys = tlc.tableKeys(tbl)
	local cursor = 1
	local iterator = {}
	iterator.total = function()
		return #obj
	end
	iterator.hasNext = function()
		return tlc.switch (
				tlc.isMoreThen(tlc.increment(cursor), #obj),
				false,
				true
			)
	end
	iterator.key = function()
		return keys[cursor]
	end
	iterator.value = function()
		return obj[keys[cursor]]
	end
	iterator.next = function()
		cursor = tlc.increase(cursor)
		return obj[keys[cursor]]
	end
	iterator.getCursor = function()
		return cursor
	end
	iterator.setCursor = function(i)
		cursor = tlc.clamp( i, 0, #obj)
	end
	iterator.toBeginning = function()
		cursor = 1
	end
	iterator.toEnd = function()
		cursor = #obj
	end
	return iterator
end

-- tableCopy - create a shallow copy of the source table
tlc.tableCopy = function( tbl )
	if not tlc.isTable( tbl ) then return error("Could not create a copy. Object is not a table.") end
	local iterator = tlc.Iterator (tbl)
	local res = {}
	while( iterator.hasNext() ) do
		res[iterator.key()] = iterator.value()
		iterator.next()
	end
	return res
end

-- tableExtend - copy keys from source table to the destination table
tlc.tableExtend = function( dest, src )
	if not tlc.isTable( dest ) then return error("Destination is not a table.") end
	if not tlc.isTable( src ) then return dest end
	local iterator = tlc.Iterator (src)
	while( iterator.hasNext() ) do
		dest[iterator.key()] = iterator.value()
		iterator.next()
	end
	return dest
end

-- tableHasRequiredKeys -- check if the required keys are present in the table and their values is not a nil
tlc.tableHasRequiredKeys = function( tbl, rec )
	if not tlc.isTable( dest ) then return error("Destination is not a table.") end
	if not tlc.isTable( rec ) then return error("Requirement is not a table.") end
	local iterator = tlc.Iterator (rec)
	while( iterator.hasNext() ) do
		local test = iterator.next()
		if not tlc.tableHasKey( tbl, test ) or not tlc.isDefined( tbl[test] ) then
			return false
		end
	end
	return true
end
