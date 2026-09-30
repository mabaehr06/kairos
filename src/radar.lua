local cfg   = require "src.config"
local items = require "src.items"

local radar = {}

-- the radar raise the field of view of the player, from the visibility of 'src.config' at level 0,
-- up to the visibility of the last level of 'items.radar'.
radar.maximalLevel = #items.radar

function radar.load()
    radar.level = 0
    radar.visibility = cfg.player.visibility
end

-- function that return the next level of the radar, nil if the radar is already at its maximum
function radar.getNextLevel()
    if radar.level >= radar.maximalLevel then return nil end
    return items.radar[radar.level + 1]
end

return radar
