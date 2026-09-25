local cfg = require "src.config"
local player = require "src.player"
local map = require "src.map"
local utils = require "src.utils"

local camera = {}    

function camera.load()    
    camera.x = player.x
    camera.y = player.y
end 

-- function that return the camera position on one axis, following the player
local function followAxis(playerPos, screenSize, mapSize)
    if mapSize <= screenSize then
        return (mapSize - screenSize) / 2
    end
    return utils.clamp(playerPos - screenSize / 2, 0, mapSize - screenSize)
end

function camera.update(dt)

    -- better reading comprehension
    local cgw, cgh = cfg.graphics.width, cfg.graphics.height

    -- meaning of this : (see usage of clamp function in src.utils)
    -- at each time, either one of this 3 values is selected, depending on the position of the player

    -- player.x - cgw/2         = the player is centered on the screen
    -- 0                        = the camera hide the left edge of the screen
    -- map.getPixelWidth - cgw  = the camera hide the right edge of the screen
    camera.x = followAxis(player.x, cgw, map.getPixelWidth())
    camera.y = followAxis(player.y, cgh, map.getPixelHeight())
end

-- convert screen coordinates to world coordinates (reverse of the draw translate)
function camera.toWorld(screenX, screenY)
    return screenX + camera.x, screenY + camera.y
end

return camera


