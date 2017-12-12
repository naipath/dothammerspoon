-- see if the file exists
function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function lines_from(file)
  lines = ""
  for line in io.lines(file) do 
    lines = lines .. line
  end
  return lines
end

function execute_command(command)
	_, _, _, resultCode = hs.execute(command, true)

	if resultCode ~= 0 then
		hs.alert.show("Could not set environment")
	end
end
