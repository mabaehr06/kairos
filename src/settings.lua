local cfg = require "src.config"

local settings = {}
local fileName = "settings.txt"

-- the settings the game knows and their default value both live in 'src.config', next to the
-- rest of the configuration. they are copied, never aliased: setting a value must not rewrite
-- the default it came from
local defaults = cfg.settings

-- function that put every setting back to its default value
local function reset()
    for key, value in pairs(defaults) do
        settings[key] = value
    end
end

-- function that read the settings file, one "key=value" per line
function settings.load()
    reset()

    local content = love.filesystem.read(fileName)
    if content == nil then return end

    for line in content:gmatch("[^\r\n]+") do
        local key, value = line:match("^(%w+)=(.+)$")
        if key ~= nil and defaults[key] ~= nil then
            settings[key] = value
        end
    end
end

-- function that write every setting back to its file
function settings.save()
    local lines = {}
    for key in pairs(defaults) do
        table.insert(lines, string.format("%s=%s", key, settings[key]))
    end
    love.filesystem.write(fileName, table.concat(lines, "\n"))
end

-- function that change one setting, and write it down right away
-- there is no other moment where we know the player is done choosing
function settings.set(key, value)
    if defaults[key] == nil then return end

    settings[key] = value
    settings.save()
end

return settings
