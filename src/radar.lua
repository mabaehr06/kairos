local cfg   = require "src.config"
local items = require "src.items"
local log   = require "src.debug.log"
local lang = require "src.lang"

local radar = {}

-- the radar raise the field of view of the player, from the visibility of 'src.config' at level 0,
-- up to the visibility of the last level of 'items.radar'.
radar.maximalLevel = #items.radar

function radar.load()
    radar.level = 0
    radar.visibility = cfg.player.visibility
    radar.upgrading = false
end

-- function that return the next level of the radar, nil if the radar is already at its maximum
function radar.getNextLevel()
    if radar.level >= radar.maximalLevel then return nil end
    return items.radar[radar.level + 1]
end

-- function that send an upgrade of the radar to the craft queue, if there is a level left.
function radar.upgrade()
    local crafts = require "src.crafts"
    local nextLevel = radar.getNextLevel()

    if nextLevel == nil then
        log.add(lang.t("log.radar.max"))
        return
    end

    if radar.upgrading then
        log.add(lang.t("log.radar.running"))
        return
    end

    radar.upgrading = crafts.start({
        name       = lang.t("radar.craft", radar.level + 1),
        craftTime  = nextLevel.craftTime,
        cost       = nextLevel.cost,
        onComplete = radar.applyUpgrade
    })
end

-- function called by the craft queue once the upgrade is built: the radar takes its level and its vision
function radar.applyUpgrade()
    radar.level = radar.level + 1
    radar.visibility = items.radar[radar.level].visibility
    radar.upgrading = false
    log.add(lang.t("log.radar.level", radar.level, radar.visibility))
end

return radar
