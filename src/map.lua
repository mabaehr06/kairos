local cfg = require "src.config"

local map = {}

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

            map.tiles[y][x] = {
                tint = tint,
                explored = false

            }
        end
    end
end

function map.load()
    map.create()
end

-- function that draw the map
function map.draw()
    for y = 1, cfg.map.height do
        for x = 1, cfg.map.width do
            love.graphics.setColor(
                map.tiles[y][x].tint,
                map.tiles[y][x].tint,
                map.tiles[y][x].tint
            )
            love.graphics.rectangle('fill',
            (x - 1) * cfg.map.tileSize,
            (y - 1) * cfg.map.tileSize,
            cfg.map.tileSize,
            cfg.map.tileSize)
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

return map