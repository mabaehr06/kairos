local player = require "src.player"
local map = require "src.map"
local items = require "src.items"
local cfg = require "src.config"
local cycle = require "src.cycle"

local sw, sh = love.graphics.getDimensions()

local hud = {}

function hud.drawOxygen()

    -- placement


    -- variables getters and color getters
    local oxygen = player.oxygen
    local maxOxygen = cfg.player.maxOxygen
    local oxygenPrct = (oxygen / maxOxygen) * 100

    local colOxyDanger    = {255, 0, 0}
    local colOxyAttention = {221, 215, 9}
    local colOxyGood      = {0, 255, 0}
    local colOxyPerfect   = {200, 200, 255}

    -- first tier = danger, second tier = attention, last tier = good, and perfect is just perfect
    local color = (oxygenPrct < 33 and colOxyDanger)
               or (oxygenPrct >= 33 and oxygenPrct < 66 and colOxyAttention)
               or (oxygenPrct >= 66 and oxygenPrct < 99 and colOxyGood)
               or colOxyPerfect

    -- Draw Part
    local font = love.graphics.getFont()
    local finalOxygenText = string.format("Oxygen: %d/%d", oxygen, maxOxygen)

    -- Back Oxygen Rectangle
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle('fill', 50, sh-50, 100, 50)

    -- Oxygen Text
    -- local finalOxygenTextDraw = screen.text(finalOxyge)
    love.graphics.setColor(love.math.colorFromBytes(color))
    love.graphics.print(finalOxygenText, 50, sh - 50)

end

function hud.drawTime()
    local text = cycle.format()

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(text, sw - 200, 10)
end

function hud.draw()
    -- print("screen dimensions", sw, sh)

    -- Oxygen interface
    hud.drawOxygen()

    -- Time interface
    hud.drawTime()
end

return hud