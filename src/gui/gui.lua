local hud = require "src.gui.hud"
local inventory = require "src.gui.inventory"
local game = require "src.game"

local gui = {}

function gui.draw()
    hud.draw()

    if game.stateSelected == game.state.inventory then
        inventory.draw()
    end
end


return gui