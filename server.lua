require "requires"

function clear(f)
    -- Empties the given file

    local h = fs.open(f, "w")
    h.write("")
    h.close()
end

function read(params)
    -- Gets the command from the input file and empties it out
    -- Get Parameters

    local params = params or {
        doClear = true
    }
    local doClear = params["doClear"]

    local h = fs.open(IN, "r")
    local line = h.readLine()
    h.close()

    if doClear then
        clear(IN)
    end

    return line
end

function out(d)
    -- Write the output into the __out.json file
    -- It will first check if its empty before doing any writing
    -- `d` must be a table since it will be serialized into a json format

    local h = fs.open(OUT, "r")
    local content = h.readAll()
    h.close()

    if trim(content) ~= "" then
        return
    end

    local serialized = textutils.serialiseJSON(d)
    h = fs.open(OUT, "w")
    h.write(serialized)
    h.close()
end

-- Clear in and out on startup
clear(IN)
clear(OUT)

-- Start Message
shell.run("clear")
print("== Computercraft Receiver Server ==")
print(string.format("-- Running: %s", os.version()))
print(string.format("-- ID: %s | Label: %s", os.getComputerID(), os.getComputerLabel()))

local commandsRan = 0

while true do
    local cmd = read()
    local parsed = parseCommand(cmd)

    if parsed.status == "commandEmpty" then
        parsed.status = "clear"
        parsed.msg = "clear"

        out(parsed)
    else
        if parsed.status ~= "ok" then
            out(parsed)
        else
            -- Run the command since parsing and validating actually ran properly
            parsed = processCommand(parsed)
            out(parsed)
            print(string.format("%s. %s/%s --- %s", commandsRan, parsed["command"]["module"], parsed["command"]["function"], parsed["out"][1]))

            commandsRan = commandsRan + 1
        end
    end

    -- Prevent too long without yielding
    os.queueEvent("api")
    os.pullEvent()
    os.sleep(0.001)
end
