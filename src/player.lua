local cfg = require "src.config"
local map = require "src.map"
local items = require "src.items"

player = {}

-- function player.printInventory()
--     print("-- inv --")
--     for i = 1, #items.ressources do
--         local rID = items.ressources[i].id
--         print(rID, player.inventory[rID])
--     end
--     print("-- --- --")
-- end

function player.loadInventory()
    player.inventory = {}
    for i = 1, #items.ressources do
        local rID = items.ressources[i].id
        player.inventory[rID] = 0
    end
    -- player.printInventory()
end

function player.addToInventory(ressource)
    player.inventory[ressource.id] = player.inventory[ressource.id] + 1
    -- player.printInventory()
end

function player.removeFromInventory()

end

function player.load()

    if cfg.player.spawn.random then
        player.x = math.random(0, map.getWidth()) * cfg.map.tileSize + math.random() * cfg.map.tileSize
        player.y = math.random(0, map.getHeight()) * cfg.map.tileSize + math.random() * cfg.map.tileSize
    else
        player.x = cfg.player.start_x
        player.y = cfg.player.start_y
    end
    player.size = cfg.map.tileSize * cfg.player.scale

    player.loadInventory()
end

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

function player.lookAround()
    local x, y = map.getTilesPlayerOn()
    local nearItems = 0
    
    for i = x - 1, x + 1 do
        for j = y - 1, y + 1 do
            if map.isInBounds(i, j) and map.tiles[j][i].containObject == true then
                nearItems = nearItems + 1
                player.addToInventory(map.tiles[j][i].ressource)
                map.removeObject(i, j)
                return
            end
        end
    end
    -- print("nearItems", x, y, nearItems)
end


function player.interact()
    player.lookAround()
end

function player.update(dt)
    local dx = 0
    local dy = 0

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

    -- handling borders of the screen
    player.handleBorder()
end

function player.draw(dt)
    -- drawing the player
    local playerSize = player.size;
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255))
    love.graphics.rectangle("fill", player.x - playerSize / 2, player.y - playerSize / 2, playerSize, playerSize, 10, 10) -- in a way to center the square to the real position of the player

    -- drawing the black eye of the player
    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("fill", player.x, player.y, playerSize / 4)
end

return player