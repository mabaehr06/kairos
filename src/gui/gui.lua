local hud = require "src.gui.hud"
local inventory = require "src.gui.inventory"
local game = require "src.game"
local menu = require "src.gui.menu"
local endscreen = require "src.gui.endscreen"

local gui = {}

function gui.draw()
    
    if game.stateSelected == game.state.inGame or game.stateSelected == game.state.inventory then
        hud.draw()
        if game.stateSelected == game.state.inventory then
            inventory.draw()
        end
    end
    if game.stateSelected == game.state.menu then
        menu.draw()
    end
    if game.stateSelected == game.state.victory or game.stateSelected == game.state.defeat then
        endscreen.draw()
    end
end


return gui