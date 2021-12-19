--
-- Used to interact with the filesystem
--

local This = {}

-- see if the file exists
function This:file_exists(file)
    local f = io.open(file, "rb")
    if f then
        f:close()
    end
    return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
function This:lines_from(file)
    lines = ""
    for line in io.lines(file) do
        lines = lines .. line
    end
    return lines
end

function This:execute_command(command)
    _, _, _, resultCode = hs.execute(command, true)

    if resultCode ~= 0 then
        hs.alert.show("Could not set environment")
    end
end

function This:read_file(path)
    local file = io.open(path, "rb")
    if not file then
        return nil
    end
    local content = file:read "*a"
    file:close()
    return content
end

return This