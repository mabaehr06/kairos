local cfg = require "src.config"
local game = require "src.game"
local player = require "src.player"
local items = require "src.items"
local rocket = require "src.rocket"

local inventory = {}

function inventory.drawRessources()
    local sw, sh = love.graphics.getDimensions()
    local x, y = 300, 200
    
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle('fill', 0, 0, sw, sh)

    love.graphics.setColor(1, 1, 1)
    for i = 1, #items.ressources do 
        local r = items.ressources[i]
        local q = player.inventory[r.id]
        love.graphics.print(string.format("%s : %d", r.display, q), x, y + i * 30)
    end
    return
end

function inventory.returnCostMissing(step)
    cost = items.rocket[step].cost
    local costMissing = {}

    for r, q in pairs(cost) do
        local pQ = player.inventory[r]
        costMissing[r] = {inventory = pQ, cost = q}
    end

    return costMissing
end

function inventory.drawObjective()
    local x, y = 300, 600

    -- Rocket Current Mission
    local obj = items.rocket[rocket.currentStep].display
    local objText = string.format("Objectif: %s", obj)
    love.graphics.print(objText, x, y)

    -- Items Missing
    local missingCost = inventory.returnCostMissing(rocket.currentStep)

    local count = 0
    for ressource, cost in pairs(missingCost) do
        local text = string.format("%s: %d/%d", items.getRessourceById(ressource).display, cost.inventory, cost.cost)
        love.graphics.print(text, x, y + 30 + count * 30)
        count = count + 1
    end
end

function inventory.drawRecipes()
end

function inventory.draw()
    inventory.drawRessources()
    inventory.drawObjective()
    inventory.drawRecipes()
end

return inventory