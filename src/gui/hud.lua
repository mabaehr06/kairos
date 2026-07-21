local player = require "src.player"
local map = require "src.map"
local items = require "src.items"
local cfg = require "src.config"
local cycle = require "src.cycle"
local power = require "src.power"

local sw, sh = love.graphics.getDimensions()

local hud = {}

function hud.drawOxygen()

    -- variables getters and color getters
    local oxygen = player.oxygen
    local maxOxygen = cfg.player.maxOxygen
    local oxygenPrct = (oxygen / maxOxygen) * 100
    local ratio = oxygen / maxOxygen

    local colOxyDanger    = {255, 0, 0}
    local colOxyAttention = {221, 215, 9}
    local colOxyGood      = {0, 255, 0}
    local colOxyPerfect   = {27, 129, 196}

    -- first tier = danger, second tier = attention, last tier = good, and perfect is just perfect
    local color = (oxygenPrct < 33 and colOxyDanger)
               or (oxygenPrct >= 33 and oxygenPrct < 66 and colOxyAttention)
               or (oxygenPrct >= 66 and oxygenPrct < 99 and colOxyGood)
               or colOxyPerfect

    -- Draw Part
    local barWidth, barHeight = 200, 30
    local x, y = 50, sh - 50

    -- background of the bar
    love.graphics.setColor(0.15, 0.15, 0.15)
    love.graphics.rectangle('fill', x, y, barWidth, barHeight)

    -- fill of the bar
    love.graphics.setColor(love.math.colorFromBytes(color))
    love.graphics.rectangle('fill', x, y, barWidth * ratio, barHeight)

    -- the text
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(string.format("%d/%d", oxygen, maxOxygen), x + 5, y + 5)
end

function hud.drawTime()
    local text = cycle.format()

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(text, sw - 300, 10)
end

function hud.drawPower()
    local pActual = power.current
    local pMax = power.getCapacity()

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(string.format("Électricité: %d/%d", pActual, pMax), 50, sh - 100)
end

function hud.draw()
    -- Oxygen interface
    hud.drawOxygen()

    -- Time interface
    hud.drawTime()

    -- Power
    hud.drawPower()
end

return hud