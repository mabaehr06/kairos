local cfg = require "src.config"
local game = require "src.game"
local player = require "src.player"
local items = require "src.items"
local rocket = require "src.rocket"
local crafts = require "src.crafts"
local utils = require "src.utils"
local log = require "src.debug.log"

local inventory = {}

function inventory.drawRessources()
    local sw, sh = love.graphics.getDimensions()
    local x, y = 300, 200
    
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle('fill', 0, 0, sw, sh)

    love.graphics.setColor(1, 1, 1)


    local yActual = y

    for i = 1, #items.ressources do 
        yActual = yActual + 30
        local r = items.ressources[i]
        local q = player.inventory[r.id]
        love.graphics.print(string.format("%s : %d", r.display, q), x, yActual)
    end

    yActual = yActual + 30
    for i = 1, #items.objects do
        yActual = yActual + 30
        local r = items.objects[i]
        local q = player.inventory[r.id]
        love.graphics.print(string.format("%s : %d", r.display, q), x, yActual)
    end

    yActual = yActual + 30
    for i = 1, #items.specials do
        yActual = yActual + 30
        local r = items.specials[i]
        local q = player.inventory[r.id]
        love.graphics.print(string.format("%s : %d", r.display, q), x, yActual)
    end
    return
end

function inventory.returnCostMissing(step)
    local cost = items.rocket[step].cost
    local costMissing = {}

    for r, q in pairs(cost) do
        local pQ = player.inventory[r]
        costMissing[r] = {inventory = pQ, cost = q}
    end

    return costMissing
end

function inventory.drawObjective()
    local x, y = 300, cfg.graphics.height - 300

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

inventory.recipeRects = {} -- clickable zones, rebuilt at every draw



function inventory.drawRecipes()
    local x, y = 1200, 200
    local lineHeight = 40

    inventory.recipeRects = {} -- reset: positions are recomputed each frame

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Fabrication :", x, y)

    for i = 1, #items.objects do
        local object = items.objects[i]
        local lineY = y + i * lineHeight

        -- green if affordable, red otherwise (the specs indicator)
        if player.hasRessources(object.cost) then
            love.graphics.setColor(0, 1, 0)
        else
            love.graphics.setColor(1, 0, 0)
        end

        -- building the cost text: "2 Silicium, 1 Fer"
        local costText = ""
        for ressourceId, quantity in pairs(object.cost) do
            local r = items.getRessourceById(ressourceId)
            costText = costText .. string.format("%d %s, ", quantity, r.display)
        end

        local text = string.format("%s (%s%ds) - possédé: %d", object.display, costText, object.craftTime, player.inventory[object.id])
        love.graphics.print(text, x, lineY)

        -- remember the clickable zone of this line for mousepressed
        local font = love.graphics.getFont()
        table.insert(inventory.recipeRects, {
            object = object,
            x = x, y = lineY,
            w = font:getWidth(text), h = font:getHeight()
        })
    end

    -- crafts in progress, below
    love.graphics.setColor(1, 1, 1)
    local queueY = y + (#items.objects + 2) * lineHeight
    love.graphics.print("En cours :", x, queueY)
    for i = 1, #crafts.queue do
        local craft = crafts.queue[i]
        love.graphics.print(string.format("%s - %ds", craft.display, math.ceil(craft.timeLeft)), x, queueY + i * lineHeight)
    end
end

function inventory.draw()
    inventory.drawRessources()
    inventory.drawObjective()
    inventory.drawRecipes()
end

-- handle a click inside the inventory screen (left click: launch a craft, right click: pick an owned object to place it)
function inventory.mousepressed(x, y, button)
    for i = 1, #inventory.recipeRects do
        local rect = inventory.recipeRects[i]
        if utils.isPointInRect(x, y, rect.x, rect.y, rect.w, rect.h) then

            if button == 1 then
                crafts.start(rect.object)

            elseif button == 2 then
                if player.inventory[rect.object.id] > 0 then
                    game.selectedObject = rect.object
                    game.changeState(game.state.inGame)
                    log.add(string.format("Cliquez sur une case pour poser : %s", rect.object.display))
                else
                    log.add(string.format("Aucun %s à poser : fabriquez-le d'abord (clic gauche)", rect.object.display))
                end
            end
        end
    end
end

return inventory