local cfg = require "src.config"
local items = require "src.items"
local map = require "src.map"
local camera = require "src.camera"
local game = require "src.game"
local log = require "src.debug.log"
local power = require "src.power"
local lang = require "src.lang"

local crafts = {}

function crafts.load()
    crafts.queue = {}
end


-- a craft is any table holding a craftTime and a cost, plus either an 'id' to drop in the
-- inventory once it is done, or an 'onComplete' callback for a craft that does something else.
-- it returns true if the craft went into the queue, false if the player could not pay for it
function crafts.start(craft)
    local name = craft.name or lang.t("item." .. craft.id)

    if not player.hasRessources(craft.cost) then
        log.add(lang.t("log.craft.missing", name))
        return false
    end

    -- removing the cost to the player inventory before the craft
    for r, q in pairs(craft.cost) do
        player.inventory[r] = player.inventory[r] - q
    end

    table.insert(crafts.queue, {
        id         = craft.id,
        name       = name,
        timeLeft   = craft.craftTime,
        craftTime  = craft.craftTime,
        onComplete = craft.onComplete
    })
    log.add(lang.t("log.craft.started", name, craft.craftTime))
    return true
end

function crafts.update(dt)

    for i = #crafts.queue, 1, -1 do
        local craft = crafts.queue[i]
        craft.timeLeft = craft.timeLeft - dt

        if craft.timeLeft <= 0 then
            log.add(lang.t("log.craft.done", craft.name))

            -- the callback runs after the message above, so its own message reads next and not first
            if craft.onComplete ~= nil then
                craft.onComplete()
            else
                player.inventory[craft.id] = player.inventory[craft.id] + 1
            end
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

    if map.isInBounds(tileX, tileY) and map.isFreeTile(tileX, tileY) and not onPlayerTile and player.isTileVisible(tileX, tileY) then
        local tile = map.tiles[tileY][tileX]
        tile.object = game.selectedObject
        tile.containObject = true
        player.inventory[game.selectedObject.id] = player.inventory[game.selectedObject.id] - 1
        log.add(lang.t("log.craft.placed", lang.t("item." .. game.selectedObject.id)))
        power.onObjectPlaced(game.selectedObject.id)
        game.selectedObject = nil
    else
        log.add(lang.t("log.craft.cantPlace"))
    end
end

return crafts