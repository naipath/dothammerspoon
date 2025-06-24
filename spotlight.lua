--
--
-- Alternative for Apple Spotlight
--

local fu = require("fileutils")
local util = require("utils")
local reloadApplication = { text = "Reload applications", uuid = "reload" }
local finderApplication = {
    text = "Finder",
    uuid = "Finder",
    image = hs.image.imageFromAppBundle("com.apple.finder")
}
local intellijLibraryVersion = "IntelliJIdea2025.1"
local intellijAppLocation = "//Applications/IntelliJ IDEA.app"

local chooseApplication

function buildApplicationChoices(directory)
    local applications = util:split(hs.execute("ls " .. directory), "\n")

    local result = {}
    for _, application in pairs(applications) do
        table.insert(result, {
            text = string.gsub(application, ".app", ""),
            uuid = application,
            image = hs.image.imageFromMediaFile(directory .. "/" .. application)
        })
    end
    return result
end

function initializeApplicationChoices()
    local applicationChoices = { finderApplication }

    util:addToTable(applicationChoices, buildApplicationChoices("/Applications"))
    util:addToTable(applicationChoices, buildApplicationChoices("/System/Applications"))
    util:addToTable(applicationChoices, buildApplicationChoices("/System/Applications/Utilities"))
    util:addToTable(applicationChoices, buildApplicationChoices("~/Applications"))
    util:addToTable(applicationChoices, findIntellijProjects())
    util:addToTable(applicationChoices, findShortcuts())
    table.insert(applicationChoices, reloadApplication)

    return applicationChoices
end

function findShortcuts()
    local shortcuts = {}
    for _, shortcut in pairs(hs.shortcuts.list()) do
         table.insert(shortcuts, {
            text = "sc: " .. shortcut.name,
            uuid = shortcut.name,
            image = hs.image.imageFromAppBundle("com.apple.shortcuts")
        })
    end
    return shortcuts
end

function findIntellijProjects()
    local projects = {}
    local path = hs.fs.pathToAbsolute("~/Library/Application Support/JetBrains/" .. intellijLibraryVersion .. "/options/recentProjects.xml")
    if not path then
        return {}
    end
    local recentProjectsFile = fu:read_file(path)
    for match in recentProjectsFile:gmatch "entry key=\".-\"" do
        local projectLocation = string.gsub(string.gsub(match, "entry key=\"$USER_HOME%$", ""), "\"", "")
        local projectName = string.gsub(projectLocation, projectLocation:match(".*/"), "")
        table.insert(projects, {
            text = "idea " .. projectName,
            uuid = "idea " .. "~" .. projectLocation,
            image = hs.image.imageFromMediaFile(intellijAppLocation)
        })
    end
    util:reverse(projects)
    return projects
end

function onCompletionHandler(result)
    if not result then
        return
    end
    if result.uuid == reloadApplication.uuid then
        chooseApplication:choices(initializeApplicationChoices())
    elseif result.uuid:find("idea ") == 1 then
        fu:execute_command(result.uuid .. " > /dev/null 2>&1 &")
    elseif result.text:find("sc: ") == 1 then
        hs.timer.doAfter(0, function ()
            hs.shortcuts.run(result.uuid)
        end)
    end
    hs.application.launchOrFocus(result.uuid)
end

chooseApplication = hs.chooser.new(onCompletionHandler)
                      :placeholderText("Search apps")
                      :choices(initializeApplicationChoices())
                      :rows(4)

hs.hotkey.bind(cah, "space", util:bind(chooseApplication, "show"))
hs.hotkey.bind({ "cmd" }, "space", util:bind(chooseApplication, "show"))

