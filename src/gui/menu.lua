local cfg = require "src.config"
local game = require "src.game"
local player = require "src.player"
local items = require "src.items"
local rocket = require "src.rocket"
local crafts = require "src.crafts"
local utils = require "src.utils"
local log = require "src.debug.log"
local power = require "src.power"
local save = require "src.save"

local menu = {}


function menu.draw()

    local best = save.getBest()
    if best ~= nil then
        love.graphics.print("Meilleur score : " .. utils.formatTime(best), 400, 400)
    else
        love.graphics.print("Aucun record pour l'instant", 400, 400)
    end

    menu.playButton = { x = 400, y = 500, w = 300, h = 80 }
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle('fill', menu.playButton.x, menu.playButton.y, menu.playButton.w, menu.playButton.h)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Jouer", menu.playButton.x + 100, menu.playButton.y + 25)
end

function menu.mousepressed(x, y, button)
    local b = menu.playButton
    if utils.isPointInRect(x, y, b.x, b.y, b.w, b.h) then
        game.reset()
    end
end

return menu