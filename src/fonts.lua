local fonts = {}

local files = {
    title = "assets/fonts/Orbitron-Bold.ttf",
    body  = "assets/fonts/Exo2.ttf"
}

-- function that create a font from a file
local function newFont(path, size)
    if love.filesystem.getInfo(path) ~= nil then
        return love.graphics.newFont(path, size)
    end
    return love.graphics.newFont(size)
end

-- function that load every font used by the game
function fonts.load()
    local height = love.graphics.getHeight()

    fonts.title  = newFont(files.title, math.floor(height * 0.10))
    fonts.button = newFont(files.body,  math.floor(height * 0.032))
    fonts.hud    = newFont(files.body,  math.floor(height * 0.022))
    fonts.small  = newFont(files.body,  math.floor(height * 0.018))
end

return fonts
