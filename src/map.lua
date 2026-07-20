local cfg = require "src.config"
local items = require "src.items"

local map = {}
local firstGenerate = false
local ressourcesTime = 0
local ressourcesCount = 0

map.tiles = {}

-- function that create the map.
-- it creates every tiles based on the width and height given in src.config
-- it generate a random tint for the tile
function map.create()
    for y = 1, cfg.map.height do
        map.tiles[y] = {}
        for x = 1, cfg.map.width do

            local commonTint = 0.3 + math.random() * 0.025
            local rareTint = 0.2 + math.random() * 0.05
            local colorTint = 0

            if math.random() < 0.02 then colorTint = rareTint else colorTint = commonTint end

            colorTint = colorTint * 255

            -- recuperation of the coordinates in pixel of the tile, for easier access later
            local xPos = (x-1) * cfg.map.tileSize
            local xPosC = xPos + 1 / 2 * cfg.map.tileSize
            local yPos = (y-1) * cfg.map.tileSize
            local yPosC = yPos + 1 / 2 * cfg.map.tileSize
            
            map.tiles[y][x] = {
                tint = {colorTint, colorTint, colorTint},
                pos = {x = xPos, xc = xPosC, y = yPos, yc = yPosC},
                containObject = false,
                ressource = nil
            }
        end
    end
end

-- function that return if a tile contain an object
function map.containObject(tileX, tileY)
    return map.tiles[tileY][tileX].containObject
end

-- function that remove the object placed at a given coordinates from the grid
function map.removeObject(tileX, tileY)
    local tile = map.tiles[tileY][tileX]
    if tile.containObject == true then
        tile.containObject = false

        if tile.ressource ~= nil then
            tile.ressource = nil
            ressourcesCount = ressourcesCount - 1
        end
    end
end

-- function that generate a new ressource, based on the density of each one in 'src.items'
function map.getRandomRessources()
    
    local random = math.random()
    local cumul = 0
    for i = 1, #items.ressources do
        cumul = cumul + items.ressources[i].density
        if random < cumul then
            return items.ressources[i]
        end
    end
    return items.ressources[#items.ressources]
end

-- function that return coordinates that do not contain object (thanks to the function below)
function map.getRandomFreeTile()
    local tileX = math.random(1, cfg.map.width)
    local tileY = math.random(1, cfg.map.height)
    while map.isFreeTile(tileX, tileY) == false do
        tileX = math.random(1, cfg.map.width)
        tileY = math.random(1, cfg.map.height)
    end        
    return tileX, tileY
end

-- return false if the tile is already occupied by an object (it can be either a ressource or an object placed by the player, or even the rocket)
function map.isFreeTile(tileX, tileY)
    if map.tiles[tileY][tileX].containObject == true then
        return false
    else
        return true
    end
end

-- function that generate one new fresh ressource on the grid
function map.generateOneRessources()
   local tileX, tileY = map.getRandomFreeTile()
   map.tiles[tileY][tileX].ressource = map.getRandomRessources()
   map.tiles[tileY][tileX].containObject = true
end

-- function that generate either all the ressources from the start of the game, or the ressource every cooldown set
function map.generateRessources()
    if firstGenerate == false then
        firstGenerate = true
        for index = 1, cfg.map.ressources.spawnRessources do
            map.generateOneRessources()
        end
        ressourcesCount = cfg.map.ressources.spawnRessources
    else
        map.generateOneRessources()
        ressourcesCount = ressourcesCount + 1
    end
end

-- map load
function map.load()
    map.create()
    map.generateRessources()
end

-- map update
function map.update(dt)
    ressourcesTime = ressourcesTime + dt
    if ressourcesTime > cfg.map.ressources.spawningDelay and ressourcesCount < cfg.map.ressources.maxRessources then
        map.generateRessources()
        ressourcesTime = 0
    end
end

-- function that draw the map, with the opacity for the player to see or not the tile
function map.drawTile(x, y, opacity)
    local tile = map.tiles[y][x]

    for x = 1, 3 do
        if tile.tint[x] > 1 then
            tile.tint[x] = tile.tint[x] / 255
        end
    end
    love.graphics.setColor(tile.tint[1], tile.tint[2], tile.tint[3], opacity)

    
    love.graphics.rectangle('fill',
        tile.pos.x,
        tile.pos.y,
        cfg.map.tileSize,
        cfg.map.tileSize
    )
end

-- function that draw a ressource
function map.drawRessources(x, y)
    local tile = map.tiles[y][x]
    local ressource = tile.ressource
    local tsize = cfg.map.tileSize

    if ressource ~= nil then

        love.graphics.setColor(love.math.colorFromBytes(ressource.color))

        -- sphere high left
        local tSizeUpperLeft = 0.3 * tsize
        local tCoordsUpperLeft = 0.12 * tsize
        love.graphics.circle('fill', tile.pos.xc - tCoordsUpperLeft, tile.pos.yc - tCoordsUpperLeft, tSizeUpperLeft)

        -- sphere middle right
        local tSizeMiddleRight = 0.33 * tsize
        local tCoordsMiddleRight = 0.07 * tsize
        love.graphics.circle('fill', tile.pos.xc + tCoordsMiddleRight, tile.pos.yc, tSizeMiddleRight)

        -- sphere low left
        local tSizeLowLeft = 0.22 * tsize
        local tCoordsLowLeft = 0.12 * tsize
        love.graphics.circle('fill', tile.pos.xc - tCoordsLowLeft, tile.pos.yc + tCoordsLowLeft, tSizeLowLeft)
    end
end

-- function that draw an object placed by the player
function map.drawObjects(x, y)
    local tile = map.tiles[y][x]
    local object = tile.object
    local tsize = cfg.map.tileSize

    if object ~= nil then
        love.graphics.setColor(love.math.colorFromBytes(object.color))

        local objectSize = 0.7 * tsize
        local objectMargin = (tsize - objectSize) / 2
        love.graphics.rectangle('fill', tile.pos.x + objectMargin, tile.pos.y + objectMargin, objectSize, objectSize)
    end
end

-- function that draw all object related to the map (principaly tiles and object atm)
-- tiles are drawn with a lower opacity if the player doesn't have the viewing distance to see the tiles
function map.draw()
    for y = 1, cfg.map.height do
        for x = 1, cfg.map.width do
            if player.isTileVisible(x, y) == true then
                -- visible zone
                map.drawTile(x, y, 1)
                map.drawRessources(x, y)
                map.drawObjects(x, y)
            else
                -- fog zone
                map.drawTile(x, y, 0.75)
            end
        end
    end
end

-- function that return the width of the entire map in pixel
function map.getPixelWidth()
    return cfg.map.tileSize * cfg.map.width
end

-- function that return the height of the entire map in pixel
function map.getPixelHeight()
    return cfg.map.tileSize * cfg.map.height
end

-- function that return the width of the map in raw
function map.getWidth()
    return cfg.map.width
end

-- function that return the height of the map in raw
function map.getHeight()
    return cfg.map.height
end

-- function that returns the coordinates of the tile the player is standing on
function map.getTilesPlayerOn()
    local tileX = math.ceil(player.x / cfg.map.tileSize)
    local tileY = math.ceil(player.y / cfg.map.tileSize)
    return tileX, tileY
end

-- function that returns a boolean if the given coordinates are valid or not
function map.isInBounds(x, y)
    if x < 1 then return false end
    if y < 1 then return false end
    if x > cfg.map.width then return false end
    if y > cfg.map.height then return false end
    return true
end

-- return true if a placed object with the given id is on or around the given tile
function map.findObjectAround(tileX, tileY, objectId)
    for i = tileX - 1, tileX + 1 do
        for j = tileY - 1, tileY + 1 do
            if map.isInBounds(i, j) and map.tiles[j][i].object ~= nil
               and map.tiles[j][i].object.id == objectId then
                return true
            end
        end
    end
    return false
end

return map