local cfg = require "src.config"
local items = require "src.items"
local map = require "src.map"
local camera = require "src.camera"
local game = require "src.game"
local log = require "src.debug.log"

local crafts = {}

crafts.queue = {}


function crafts.start(object)
    if not player.hasRessources(object.cost) then
        log.add(string.format("Ressources insuffisantes (%s)", object.display))
        return
    end

    -- removing the cost to the player inventory before the craft
    for r, q in pairs(object.cost) do
        player.inventory[r] = player.inventory[r] - q
    end

    table.insert(crafts.queue, {id = object.id, display = object.display, timeLeft = object.craftTime })
    log.add(string.format("Fabrication lancée : %s (%ds)", object.display, object.craftTime))
end

function crafts.update(dt)

    for i = #crafts.queue, 1, -1 do
        local craft = crafts.queue[i]
        craft.timeLeft = craft.timeLeft - dt

        if craft.timeLeft <= 0 then
            player.inventory[craft.id] = player.inventory[craft.id] + 1
            log.add(string.format("Fabrication terminée : %s", craft.display))
            table.remove(crafts.queue, i)
        end
    end
end

-- place the selected object on the clicked tile (screen -> world -> tile)
function crafts.place(x, y, button)
    if game.selectedObject == nil then return end

    local worldX, worldY = camera.toWorld(x, y)
    local tileX = math.ceil(worldX / cfg.map.tileSize)
    local tileY = math.ceil(worldY / cfg.map.tileSize)

    -- the player tile is forbidden: placing an object under our own feet would lock us in place forever
    local playerTileX, playerTileY = map.getTilesPlayerOn()
    local onPlayerTile = (tileX == playerTileX and tileY == playerTileY)

    if map.isInBounds(tileX, tileY) and map.isFreeTile(tileX, tileY) and not onPlayerTile then
        local tile = map.tiles[tileY][tileX]
        tile.object = game.selectedObject
        tile.containObject = true
        player.inventory[game.selectedObject.id] = player.inventory[game.selectedObject.id] - 1
        log.add(string.format("%s posé", game.selectedObject.display))
        game.selectedObject = nil
    else
        log.add("Impossible de poser ici")
    end
end

return crafts