local cfg       = require "src.config"
local game      = require "src.game"
local map       = require "src.map"
local player    = require "src.player"
local camera    = require "src.camera"
local crafts    = require "src.crafts"
local power     = require "src.power"
local rocket    = require "src.rocket"
local log       = require "src.debug.log"
local hud       = require "src.gui.hud"

local play = {}

-- this scene hold the two states of a running game: the map, and the inventory opened over it

-- the game keep running while the inventory is opened, the oxygen does not wait for the player
function play.update(dt)
    game.update(dt)
    player.update(dt)
    camera.update(dt)
    map.update(dt)
    crafts.update(dt)
    power.update(dt)
end

function play.draw()
    love.graphics.push() -- use is to keep memory of the position before the translation
    love.graphics.translate(-camera.x, -camera.y) -- camera translation thing

    map.draw()
    rocket.draw()
    player.draw()

    love.graphics.pop() -- we go back to before the translation, to draw the interface without any difficulties

    log.draw()
    hud.draw()
end

function play.keypressed(key)
    local ctrl = cfg.controls

    if key == ctrl.inventory then
        game.changeState(game.state.inventory)
    end

    if key == ctrl.interact then
        player.interact()
    end
    if key == ctrl.useGlace then
        player.consumeForOxygen('glace', cfg.player.oxygenRestore.glace)
    end
    if key == ctrl.useOxygen then
        player.consumeForOxygen('oxygene', cfg.player.oxygenRestore.oxygene)
    end

    if key == ctrl.reset then
        game.reset()
    end
end

function play.mousepressed(x, y, pressedButton)
    crafts.place(x, y, pressedButton)
end
return play
