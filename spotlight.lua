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
local intellijLibraryVersion = "JetBrains/IntelliJIdea2021.3"
local intellijAppLocation = "/Applications/IntelliJ IDEA.app"

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
    util:addToTable(applicationChoices, findIntellijProjects())
    table.insert(applicationChoices, reloadApplication)

    return applicationChoices
end

function findIntellijProjects()
    local projects = {}
    local path = hs.fs.pathToAbsolute("~/Library/Application Support/" .. intellijLibraryVersion .. "/options/recentProjects.xml")
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
        fu:execute_command("/usr/local/bin/" .. result.uuid)
    end
    hs.application.launchOrFocus(result.uuid)
end

chooseApplication = hs.chooser.new(onCompletionHandler)
                      :placeholderText("Search apps")
                      :choices(initializeApplicationChoices())
                      :rows(4)

hs.hotkey.bind({ "cmd" }, "space", util:bind(chooseApplication, "show"))

