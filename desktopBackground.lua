local picturesDirectory = "/Users/tvs/Pictures/background/"

local function ends_with(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end

hs.hotkey.bind(cah, "d", function()
    local files = {}
    local totalFiles = 0
    local iterFn, dirObj = hs.fs.dir(picturesDirectory)

    if iterFn then
        for file in iterFn, dirObj do
            if ends_with(file, ".jpg") then
                totalFiles = totalFiles + 1
                files[totalFiles] = file
            end
        end
    end

    local background = "file://" .. picturesDirectory .. files[hs.math.randomFromRange(1, totalFiles)]
    print(background)
    hs.screen.mainScreen():desktopImageURL(background)
end)