local game   = require "src.game"
local save   = require "src.save"
local utils  = require "src.utils"
local fonts  = require "src.fonts"
local button = require "src.gui.button"

local ending = {}

-- this scene hold the two ends of a game: the victory and the defeat
local labels = {
    victory   = "Victoire !",
    defeat    = "Défaite...",
    time      = "Votre temps : %s",
    record    = "Votre record : %s",
    newRecord = "Nouveau record !",
    replay    = "Rejouer",
    menu      = "Menu"
}

local colors = {
    background = {24 / 255, 24 / 255, 24 / 255},
    victory    = {0.40, 0.64, 0.86},
    defeat     = {0.85, 0.35, 0.35},
    text       = {0.66, 0.67, 0.71},
    record     = {1, 1, 1}
}

local layout = {
    titleY       = 0.20,
    textY        = 0.40,
    lineHeight   = 0.045,
    buttonsY     = 0.58,
    buttonWidth  = 0.26,
    buttonHeight = 0.075,
    buttonGap    = 0.022
}

-- function called every time we reach an end screen, it places the buttons for the current resolution
function ending.enter()
    local screenWidth, screenHeight = love.graphics.getDimensions()

    local width  = utils.round(screenWidth * layout.buttonWidth)
    local height = utils.round(screenHeight * layout.buttonHeight)
    local gap    = utils.round(screenHeight * layout.buttonGap)
    local x      = utils.round((screenWidth - width) / 2)
    local y      = utils.round(screenHeight * layout.buttonsY)

    ending.buttons = {
        { label = labels.replay, x = x, y = y,                  w = width, h = height, onClick = function() game.reset() end },
        { label = labels.menu,   x = x, y = y + height + gap,    w = width, h = height, onClick = function() game.changeState(game.state.menu) end }
    }
end

-- function that draw the time of the run, and the record of the player below it
function ending.drawVictory(screenWidth, y, lineHeight)
    love.graphics.setColor(colors.text)
    utils.printCentered(string.format(labels.time, utils.formatTime(game.totalTime)), 0, y, screenWidth)

    if game.isNewRecord then
        love.graphics.setColor(colors.record)
        utils.printCentered(labels.newRecord, 0, y + lineHeight, screenWidth)
        return
    end

    local best = save.getBest()
    if best ~= nil then
        utils.printCentered(string.format(labels.record, utils.formatTime(best)), 0, y + lineHeight, screenWidth)
    end
end

-- function that draw why the player died, and how long he survived
function ending.drawDefeat(screenWidth, y, lineHeight)
    love.graphics.setColor(colors.text)
    utils.printCentered(game.deathReason or "", 0, y, screenWidth)
    utils.printCentered(string.format(labels.time, utils.formatTime(game.totalTime)), 0, y + lineHeight, screenWidth)
end

function ending.draw()
    local screenWidth, screenHeight = love.graphics.getDimensions()
    local isVictory = game.stateSelected == game.state.victory

    love.graphics.setColor(colors.background)
    love.graphics.rectangle('fill', 0, 0, screenWidth, screenHeight)

    love.graphics.setFont(fonts.title)
    love.graphics.setColor(isVictory and colors.victory or colors.defeat)
    utils.printCentered(isVictory and labels.victory or labels.defeat, 0, screenHeight * layout.titleY, screenWidth)

    love.graphics.setFont(fonts.button)
    local y = screenHeight * layout.textY
    local lineHeight = screenHeight * layout.lineHeight

    if isVictory then
        ending.drawVictory(screenWidth, y, lineHeight)
    else
        ending.drawDefeat(screenWidth, y, lineHeight)
    end

    button.drawList(ending.buttons)
end

function ending.mousepressed(x, y, pressedButton)
    if pressedButton ~= 1 then return end
    button.clickList(ending.buttons, x, y)
end

return ending
