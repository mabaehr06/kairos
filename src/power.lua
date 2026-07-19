local cfg = require "src.config"
local items = require "src.items"
local cycle = require "src.cycle"
local utils = require "src.utils"
local log = require "src.debug.log"

local power = {}

local productionTime = 0

function power.load()
    power.current = 0
    power.count = { panel = 0, battery = 0, electrolyseur = 0}
end

function power.getCapacity()
    local panelCapacity = cfg.power.panel.capacity
    local batteryCapacity = cfg.power.battery.capacity

    return power.count.panel * panelCapacity + power.count.battery * batteryCapacity    
end

function power.onObjectPlaced(objectId)
    power.count[objectId] = power.count[objectId] + 1
end

function power.update(dt)
    if not cycle.computeIsDay() then return end

    productionTime = productionTime + dt
    if productionTime >= cfg.power.panel.productionDelay then
        productionTime = 0

        local production = power.count.panel * cfg.power.panel.production
        power.current = utils.clamp(power.current + production, 0, power.getCapacity())
    end
end

function power.electrolyze()
    local cost = cfg.power.electrolyzer

    if player.inventory['glace'] < cost.glaceCost then
        log.add("Pas assez de glace")
        return
    end
    if power.current < cost.electricityCost then
        log.add(string.format("Pas assez d'électricité (%d/%d)", power.current, cost.electricityCost))
        return
    end

    player.inventory['glace'] = player.inventory['glace'] - cost.glaceCost
    power.current = power.current - cost.electricityCost
    player.inventory['oxygene'] = player.inventory['oxygene'] + 1
    log.add("Électrolyse : +1 Oxygène pur")
end

return power