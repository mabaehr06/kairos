local cfg = require "src.config"
local map = require "src.map"
local items = require "src.items"
local utils = require "src.utils"
local log = require "src.debug.log"
local game = require "src.game"

local rocket = {}

rocket.pos = {}
rocket.pos.x = 0
rocket.pos.y = 0
rocket.size = {}
rocket.size.x = cfg.rocket.sizeX
rocket.size.y = cfg.rocket.sizeY

rocket.maximalStep = #items.rocket

function rocket.load()
    local mapWidth, mapHeight = map.getWidth(), map.getHeight()

    rocket.pos.x, rocket.pos.y = math.random(1, mapWidth - (rocket.size.x - 1)), math.random(1, mapHeight - (rocket.size.y - 1))
    local rocketColor = {4, 86, 217}

    for x = rocket.pos.x, rocket.pos.x + rocket.size.x - 1 do
        for y = rocket.pos.y, rocket.pos.y + rocket.size.y - 1 do
            map.tiles[y][x].containObject = true
            map.tiles[y][x].tint = rocketColor
        end
    end

    rocket.currentStep = 1
    rocket.repaired = false
end

function rocket.draw()
    local ts = cfg.map.tileSize
    love.graphics.setColor(love.math.colorFromBytes(4, 86, 217))
    love.graphics.rectangle("fill",
        (rocket.pos.x - 1) * ts,
        (rocket.pos.y - 1) * ts,
        cfg.rocket.sizeX * ts,
        cfg.rocket.sizeY * ts)
end

function rocket.isPlayerAround()
    local x, y = map.getTilesPlayerOn()
    
    for i = x - 1, x + 1 do
        for j = y - 1, y + 1 do
            if not map.isInBounds(i, j) then goto continue end
            
            if i >= rocket.pos.x and i <= rocket.pos.x + rocket.size.x - 1 then
                if j >= rocket.pos.y and j <= rocket.pos.y + rocket.size.y - 1 then
                    return true
                end
            end

            ::continue::
        end
    end
    return false
end

function rocket.deposit()
    local step      = items.rocket[rocket.currentStep]

    -- finding if the player have enough quantity of each required item before processing to the upgrade
    -- case: the player doesn't have enough ressources to buy the step
    if not player.hasRessources(step.cost) then
        log.add("Vous ne pouvez pas améliorer la fusée")
        return
    end

    -- case: the player have enough item to buy the step and advance to the next one
    for ressourceId, quantity in pairs(step.cost) do
        player.inventory[ressourceId] = player.inventory[ressourceId] - quantity
    end
    log.add(string.format("Amélioration %s effectué (%d/%d)", step.display, rocket.currentStep, rocket.maximalStep))
    rocket.currentStep = rocket.currentStep + 1

    -- case rocket is repaired
    if rocket.currentStep > rocket.maximalStep then
        rocket.repaired = true
    end
end

-- victory function
function rocket.launch()
    game.win()
end

-- interact function, to repair the rocket if not, and then win
function rocket.interact()
    if not rocket.repaired then
        rocket.deposit()
        return
    end

    rocket.launch()
end

return rocket



