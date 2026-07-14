local cfg = require "src.config"
local player = require "src.player"
local map = require "src.map"
local utils = require "src.utils"

local camera = {}    

function camera.load()    
    camera.x = player.x
    camera.y = player.y
end 

function camera.update(dt)

    -- better reading comprehension
    local cgw, cgh = cfg.graphics.width, cfg.graphics.height

    -- meaning of this : (see usage of clamp function in src.utils)
    -- at each time, either one of this 3 values is selected, depending on the position of the player

    -- player.x - cgw/2         = the player is centered on the screen
    -- 0                        = the camera hide the left edge of the screen
    -- map.getPixelWidth - cgw  = the camera hide the right edge of the screen
    camera.x = utils.clamp(player.x - cgw / 2, 0, map.getPixelWidth() - cgw)
    camera.y = utils.clamp(player.y - cgh / 2, 0, map.getPixelHeight() - cgh)
end

return camera


