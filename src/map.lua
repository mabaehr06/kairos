local cfg = require "src.config"
local items = require "src.items"

local map = {}
local firstGenerate = false
local ressourcesTime = 0
local ressourcesCount = 0

map.tiles = {}

-- function that create the map
function map.create()
    for y = 1, cfg.map.height do
        map.tiles[y] = {}
        for x = 1, cfg.map.width do

            local commonTint = 0.3 + math.random() * 0.025
            local rareTint = 0.2 + math.random() * 0.05
            local tint = 0

            if math.random() < 0.02 then tint = rareTint else tint = commonTint end

            -- recuperation of the coordinates in pixel of the tile, for easier access later
            local xPos = (x-1) * cfg.map.tileSize
            local xPosC = xPos + 1 / 2 * cfg.map.tileSize
            local yPos = (y-1) * cfg.map.tileSize
            local yPosC = yPos + 1 / 2 * cfg.map.tileSize
            
            map.tiles[y][x] = {
                tint = tint,
                pos = {x = xPos, xc = xPosC, y = yPos, yc = yPosC},
                explored = false,
                containObject = false,
                ressource = nil
            }
        end
    end
end

function map.containObject(tileX, tileY)
    if map.tiles[tileY][tileX].containObject == true then
        return true
    else
        return false
    end
end

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

function map.getRandomRessources()
    
    local r = math.random()
    local cumul = 0
    for i = 1, #items.ressources do
        cumul = cumul + items.ressources[i].density
        if r < cumul then
            return items.ressources[i]
        end
    end
    return items.ressources[#items.ressources]
end

function map.getRandomFreeTile()
    local tileX = math.random(1, cfg.map.width)
    local tileY = math.random(1, cfg.map.height)
    while map.isFreeTile(tileX, tileY) == false do
        local tileX = math.random(1, cfg.map.width)
        local tileY = math.random(1, cfg.map.height)
    end        
    return tileX, tileY
end

function map.isFreeTile(tileX, tileY)
    if map.tiles[tileY][tileX].containObject == true then
        return false
    else
        return true
    end
end

function map.generateOneRessources()
   local tileX, tileY = map.getRandomFreeTile()
   map.tiles[tileY][tileX].ressource = map.getRandomRessources()
   map.tiles[tileY][tileX].containObject = true
end

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
        -- print("generated on ", tileY, tileX, map.tiles[tileY][tileX].ressource)
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

-- function that draw the map
function map.drawTile(x, y)
    local tile = map.tiles[y][x]
    love.graphics.setColor(
        map.tiles[y][x].tint,
        map.tiles[y][x].tint,
        map.tiles[y][x].tint
    )
    love.graphics.rectangle('fill',
        tile.pos.x,
        tile.pos.y,
        cfg.map.tileSize,
        cfg.map.tileSize
    )
end

function map.drawRessources(x, y)
    local tile = map.tiles[y][x]
    local ressource = tile.ressource
    local tsize = cfg.map.tileSize
    if ressource ~= nil then

        -- fill
        -- love.graphics.circle('fill', tile.pos.xc, tile.pos.yc, tsize * 0.30)

        -- high left
        local tSizeUpperLeft = 0.3 * tsize
        local tCoordsUpperLeft = 0.12 * tsize
        -- love.graphics.setColor(0,0,0)
        love.graphics.setColor(love.math.colorFromBytes(ressource.color))
        love.graphics.ellipse('fill', tile.pos.xc - tCoordsUpperLeft, tile.pos.yc - tCoordsUpperLeft, tSizeUpperLeft ,tSizeUpperLeft)

        -- middle right
        local tSizeMiddleRight = 0.33 * tsize
        local tCoordsMiddleRight = 0.07 * tsize
        -- love.graphics.setColor(1,1,1)
        -- love.graphics.setColor(love.math.colorFromBytes(ressource.color))
        love.graphics.ellipse('fill', tile.pos.xc + tCoordsMiddleRight, tile.pos.yc, tSizeMiddleRight, tSizeMiddleRight)

        -- low left
        local tSizeLowLeft = 0.22 * tsize
        local tCoordsLowLeft = 0.12 * tsize
        love.graphics.setColor(love.math.colorFromBytes(ressource.color))
        love.graphics.ellipse('fill', tile.pos.xc - tCoordsLowLeft, tile.pos.yc + tCoordsLowLeft, tSizeLowLeft, tSizeLowLeft)
        -- outline
        -- love.graphics.setColor(0, 0, 0)
        -- love.graphics.circle('line', tile.pos.xc, tile.pos.yc, tsize / 2)
    end
end

function map.draw()
    for y = 1, cfg.map.height do
        for x = 1, cfg.map.width do
            map.drawTile(x, y)
            map.drawRessources(x, y)        
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
    tileX = math.ceil(player.x / cfg.map.tileSize)
    tileY = math.ceil(player.y / cfg.map.tileSize)
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

return map