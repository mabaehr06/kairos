local fonts = {}

local file = "assets/fonts/Alexandria.ttf"

-- function that create a font from a file
-- 'light' only hint the font vertically: measured sharper than the default mode, without the
-- hard edges of the 'mono' mode, which drops the antialiasing completely
local function newFont(path, size)
    if love.filesystem.getInfo(path) ~= nil then
        return love.graphics.newFont(path, size, "light")
    end
    return love.graphics.newFont(size)
end

-- function that load every font used by the game
function fonts.load()
    local height = love.graphics.getHeight()

    fonts.title  = newFont(file, math.floor(height * 0.085))
    fonts.button = newFont(file, math.floor(height * 0.032))
    fonts.hud    = newFont(file, math.floor(height * 0.022))
    fonts.small  = newFont(file, math.floor(height * 0.018))
end

return fonts
