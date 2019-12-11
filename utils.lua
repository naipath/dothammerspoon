--
-- Various util functions
--


-- Sugar for binding functions
function bind(reference, functionName)
    return function()
        reference[functionName](reference)
    end
end

-- Sugar for adding to tables
function addToTable(target, inputTable)
    for _,value in pairs(inputTable) do
        table.insert(target, value)
    end
end

-- Sugar for splitting a string into a table
function split(s, delimiter)
    local result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        if (match ~= "") then
            table.insert(result, match)
        end
    end
    return result;
end

