require "globals"

function trim(s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function tableDump(o)
    -- Prints out a table, doesn't matter if its nested or not

    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. '[' .. k .. '] = ' .. tableDump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function tableLength(tab)
    local c = 0
    for _ in pairs(tab) do c = c + 1 end
    return c
end

function tableHasValue(tab, val)
    -- Check if the given table `tab` has the value `val`

    for k, v in pairs(tab) do
        if v == val then
            return true
        end
    end
    return false
end

function tableHasKey(tab, key)
    -- Check if the given table `tab` has the key `val`

    for k, v in pairs(tab) do
        if k == key then
            return true
        end
    end
    return false
end

function splitString(i, sep)
    -- Splits a string by a separator. Equivalent to python's .split method

    if i == nil then
        return {}
    end

    if sep == nil then
        sep = "%s"
    end

    local t = {}
    for s in string.gmatch(i, "([^" .. sep .. "]+)") do
        table.insert(t, s)
    end

    return t
end

function parseCommand(i)
    -- Parses the given command into a easy to access dictionary/table

    local parsed = {
        status = "ok",
        msg = "success",
        out = "",
        command = {}
    }
    
    -- Raise a module
    if i == nil or i == "" then
        parsed.status = "commandEmpty"
        parsed.msg = "commandEmpty"
        return parsed
    end

    -- Perform splitting
    local splitted = splitString(i)
    local module = splitted[1]
    parsed.command.module = module

    -- Raise a moduleNotFound
    if not tableHasKey(MODULES, module) then
        parsed.status = "moduleNotFound"
        parsed.msg = module

        return parsed
    end

    local moduleContainer = MODULES[module]

    local func = splitted[2]
    parsed.command["function"] = func

    -- Raise a functionNotFound
    if not tableHasKey(moduleContainer, func) then
        parsed.status = "functionNotFound"
        parsed.msg = func

        return parsed
    end

    -- Remove the module and function from the splitted so that we only have the arguments left
    splitted[1] = nil
    splitted[2] = nil

    local args = {}
    
    -- Loop through the arugments and put them in the args table/array
    for k, v in pairs(splitted) do

        -- If it's a int, convert it to an int
        local number = tonumber(v)
        if number ~= nil then
            v = number
        end

        -- If it's a boolean, convert it to a boolean
        if v == "true" then
            v = true
        elseif v == "false" then
            v = false
        end

        -- If it's a "nil", convert it to a nil.
        if v == "nil" then
            v = nil
        end

        table.insert(args, v)
    end

    -- Add the arguments into the parsed
    parsed.command.args = args
    return parsed
end

function processCommand(parsed)
    -- Process the command and run it
    local func = MODULES[parsed.command.module][parsed.command["function"]]
    local out = {func(table.unpack(parsed.command.args))}
    parsed.out = out
    return parsed
end
