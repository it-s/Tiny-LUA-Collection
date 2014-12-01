tlc = tlc or {}
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
        local length = #keys
        local cursor = 0
        local iterator = {}
        
        local function _cursor()
          return tlc.clamp( cursor, 1, length)
        end
        local function _hasNext()
                return tlc.isLessThen(tlc.increment(cursor), tlc.increment(length))
        end
        local function _key()
                return keys[_cursor()]
        end
        local function _val()
                return obj[keys[_cursor()]]
        end
        
        iterator.total = function()
                return length
        end
        iterator.hasNext = _hasNext
        iterator.key = _key
        iterator.value = _val
        iterator.next = function()
                if not _hasNext() then return nil end
                cursor = tlc.clamp( tlc.increment(cursor) , 1, length)
                local key, val = _key(), _val()
                return key, val
        end
        iterator.getCursor = function()
                return _cursor()
        end
        iterator.setCursor = function(i)
                cursor = tlc.clamp( i, 1, length)
        end
        iterator.toBeginning = function()
                cursor = 0
        end
        iterator.toEnd = function()
                cursor = length
        end
        return iterator
end

-- tableCopy - create a shallow copy of the source table
tlc.tableCopy = function( tbl )
        if not tlc.isTable( tbl ) then return error("Could not create a copy. Object is not a table.") end
        local iterator = tlc.Iterator (tbl)
        local res = {}
        for k,v in iterator.next do
          res[k] = v
        end
        return res
end

-- tableExtend - copy keys from source table to the destination table
tlc.tableExtend = function( dest, src )
        if not tlc.isTable( dest ) then return error("Destination is not a table.") end
        if not tlc.isTable( src ) then return dest end
        local iterator = tlc.Iterator (src)
        for k,v in iterator.next do
          dest[k] = v
        end
        return dest
end

-- tableHasRequiredKeys -- check if the required keys are present in the table and their values is not a nil
tlc.tableHasKeys = function( tbl, rec )
        if not tlc.isTable( tbl ) then return error("Destination is not a table.") end
        if not tlc.isTable( rec ) then return error("Requirement is not a table.") end
        local iterator = tlc.Iterator (rec)
        while iterator.next() do
                if not tlc.tableHasKey( tbl, iterator.value() ) or tlc.isNil( tbl[iterator.value()] ) then
                        return false
                end
        end
        return true
end
