local cfg = require "src.config"
local map = require "src.map"
local items = require "src.items"
local log = require "src.debug.log"
local rocket = require "src.rocket"
local game = require "src.game"
local power = require "src.power"
local utils = require "src.utils"

player = {}

local oxygenTime = 0


-- - INVENTORY & INTERACTION
-- function used at the load, it can be used if special items need to be in the inventory of the player at the start
function player.loadInventory()
    player.inventory = {}
    for i = 1, #items.ressources do
        local rID = items.ressources[i].id
        player.inventory[rID] = 0
    end
    for i = 1, #items.objects do
        local oID = items.objects[i].id
        player.inventory[oID] = 0
    end
    for i = 1, #items.specials do
        local sID = items.specials[i].id
        player.inventory[sID] = 0
    end
end

-- function that add the ressource given in parameter to the inventory of the player
function player.addToInventory(ressource)
    if ressource == nil then return end
    player.inventory[ressource.id] = player.inventory[ressource.id] + 1
end

-- function that remove the ressource given in parameter to the inventory of the player
function player.removeFromInventory()
    -- nothing to be removed for the moment
end

-- function that return true if the player have the viewing distance to see the tile given in parameter
function player.isTileVisible(tileX, tileY)
    local px, py = map.getTilesPlayerOn()
    local dx, dy = tileX - px, tileY - py
    local radius = cfg.player.visibility
    return dx * dx + dy * dy <= radius * radius
end

-- function that scan the 8 tiles around the player, and give 1 of the ressources found to the player
function player.recoltRessource()
    local x, y = map.getTilesPlayerOn()
    
    for i = x - 1, x + 1 do
        for j = y - 1, y + 1 do
            -- only tiles holding a ressource can be harvested (not the rocket or a placed object)
            if map.isInBounds(i, j) and map.tiles[j][i].ressource ~= nil then
                local ressource = map.tiles[j][i].ressource
                player.addToInventory(ressource)
                map.removeObject(i, j)
                log.add(string.format("%s trouvé (total : %d)", ressource.display, player.inventory[ressource.id]))
                return
            end
        end
    end
    log.add(string.format("Il n 'y a rien autour de toi."))
end

function player.hasRessources(cost)
    for ressourceID, quantity in pairs(cost) do
        if player.inventory[ressourceID] < quantity then 
            return false
        end
    end
    return true
end

-- function that is used to manage all functions linked to interact (recolt a ressource, open a object window, repair the rocket, ...)
function player.interact()
    if rocket.isPlayerAround() then
        rocket.interact()
        return
    end

    local tileX, tileY = map.getTilesPlayerOn()
    if map.findObjectAround(tileX, tileY, 'electrolyseur') then
        power.electrolyze()
        return
    end

    player.recoltRessource()
end

-- - MOVEMENT
-- function that manage the movement of the player
function player.handleMovement(dt)

    if game.stateSelected ~= game.state.inGame then
        return player.x, player.y
    end

    local dx, dy = 0, 0

    -- up/down
    if love.keyboard.isDown(cfg.controls.movement.up) then      dy = dy - 1 end
    if love.keyboard.isDown(cfg.controls.movement.down) then    dy = dy + 1 end
    
    -- left/right
    if love.keyboard.isDown(cfg.controls.movement.left) then    dx = dx - 1 end
    if love.keyboard.isDown(cfg.controls.movement.right) then   dx = dx + 1 end

    -- speed normalization
    local length = math.sqrt(dx^2+dy^2)
    if length > 0 then
        dx, dy = dx/length, dy/length
    end

    -- application of the measured speed to the player
    player.x = player.x + dx * cfg.player.speed * dt
    player.y = player.y + dy * cfg.player.speed * dt
    return player.x, player.y
end

-- function that handle the hitBox of the ressource to the player, it prevent from the player to get inside a ressource
function player.handleHitBox(px, py, fx, fy)
    local tx, ty = map.getTilesPlayerOn()
    local tile = map.tiles[ty][tx]
    if tile.containObject == true then
        player.x, player.y = px, py
    end
end

-- function that prevent the player from going outside of the grid
function player.handleBorder()
    -- getting x Min/Max and y Min/Max for better comprehension
    xMin = player.size/2
    xMax = map.getPixelWidth() - player.size/2
    yMin = player.size/2
    yMax = map.getPixelHeight() - player.size/2
    
    -- handling border with the size of the player
    if      player.x < xMin then player.x = xMin
    elseif  player.x > xMax then player.x = xMax end
    if      player.y < yMin then player.y = yMin
    elseif  player.y > yMax then player.y = yMax end
end

-- - OXYGEN
function player.handleOxygen()
    if player.oxygen <= 0 then return end

    if oxygenTime >= cfg.player.oxygenTime then
        player.consumeOxygen()
        oxygenTime = 0
    end
end

function player.consumeOxygen()
    player.oxygen = player.oxygen - 1
    log.add(string.format("Oxygène : %d/%d", player.oxygen, cfg.player.maxOxygen))
    if player.oxygen <= 0 then
        game.lose(string.format("Vous êtes mort d'asphyxie. Fin de la partie."))
        -- lose condition here
    end
end

function player.consumeForOxygen(itemId, restore)
    local maxOxy = cfg.player.maxOxygen
    if player.inventory[itemId] > 0 and player.oxygen < maxOxy then
        player.inventory[itemId] = player.inventory[itemId] - 1
        player.oxygen = utils.clamp(player.oxygen + restore, 0, maxOxy)
        log.add(string.format("Oxygène : %d/%d", player.oxygen, maxOxy))
        return
    end
    log.add("Vous ne pouvez pas consommer ceci actuellement.")
end

-- - LOVE BASIC FUNCTIONS
-- function that load all things needed at the launch of the program
function player.load()

    -- set a random spawn for the player if the parameter "random" is set to true in the config file ('src.config')
    if cfg.player.spawn.random then
        local tileX, tileY = map.getRandomFreeTile()
        player.x = map.tiles[tileY][tileX].pos.xc
        player.y = map.tiles[tileY][tileX].pos.yc
    else
        player.x = cfg.player.start_x
        player.y = cfg.player.start_y
    end

    player.size = cfg.map.tileSize * cfg.player.scale -- set the size of the player, based on the size of a tile, and on the scale
    player.loadInventory() -- load the inventory of the player
    player.oxygen = cfg.player.maxOxygen -- set the oxygen to the max
    oxygenTime = 0
end

-- function that update all things related to the player
function player.update(dt)

    -- handling movement
    local px, py = player.x, player.y
    local fx, fy = player.handleMovement(dt)

    -- handling hitbox (only ressources for now)
    player.handleHitBox(px, py, fx, fy)

    -- handling borders of the screen
    player.handleBorder()

    -- oxygen handler
    oxygenTime = oxygenTime + dt
    player.handleOxygen()
end

-- function that draw the player
function player.draw(dt)
    -- drawing the player
    local playerSize = player.size;
    love.graphics.setColor(love.math.colorFromBytes(221,215,9))
    love.graphics.rectangle("fill", player.x - playerSize / 2, player.y - playerSize / 2, playerSize, playerSize, 10, 10) -- in a way to center the square to the real position of the player

    -- drawing the black eye of the player
    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("fill", player.x, player.y, playerSize / 4)
end

return player