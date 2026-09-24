local game    = require "src.game"
local save    = require "src.save"
local utils   = require "src.utils"
local fonts   = require "src.fonts"
local button  = require "src.gui.button"
local version = require "src.version"

local menu = {}

local bannerPath = "assets/banner_1680_640.png"

-- every text of the screen is gathered here, to prepare the translation of the game
local labels = {
    title  = "skdjqskd",
    play   = "Jouer",
    settings = "Paramètres",
    quit   = "Quitter",
    best   = "Meilleur temps : %s",
    noBest = "Aucun record pour l'instant"
}

-- colors picked in the logo: the dark sky, the white horizon and the blue of the earth
local colors = {
    sky     = {24 / 255, 24 / 255, 24 / 255},
    horizon = {1, 1, 1},
    text    = {0.66, 0.67, 0.71}
}

-- the whole screen is placed in fraction of the window, so it follow any resolution
local layout = {
    bannerY      = 0.05,
    bannerWidth  = 0.46,
    buttonsY     = 0.46,
    buttonWidth  = 0.26,
    buttonHeight = 0.075,
    buttonGap    = 0.022,
    bestY        = 0.76,
    groundY      = 0.82,
    tileSize     = 0.075
}

local banner = nil

-- function that build the lunar ground, with the same random tint as the tiles of the game map
-- it is built once when we enter the menu, otherwise the tiles would flicker at every frame
function menu.buildGround(screenWidth, screenHeight)
    local tile = utils.round(screenHeight * layout.tileSize)
    local ground = { tile = tile, y = utils.round(screenHeight * layout.groundY), tints = {} }

    for row = 1, math.ceil((screenHeight - ground.y) / tile) do
        ground.tints[row] = {}
        for column = 1, math.ceil(screenWidth / tile) do
            ground.tints[row][column] = 0.3 + math.random() * 0.025
        end
    end

    menu.ground = ground
end

-- function called every time we enter the menu, it loads the banner and places everything
function menu.enter()
    local screenWidth, screenHeight = love.graphics.getDimensions()

    if banner == nil and love.filesystem.getInfo(bannerPath) ~= nil then
        banner = love.graphics.newImage(bannerPath)
    end

    local width  = utils.round(screenWidth * layout.buttonWidth)
    local height = utils.round(screenHeight * layout.buttonHeight)
    local gap    = utils.round(screenHeight * layout.buttonGap)
    local x      = utils.round((screenWidth - width) / 2)
    local y      = utils.round(screenHeight * layout.buttonsY)

    menu.buttons = {
        { label = labels.play,     x = x, y = y,                      w = width, h = height, onClick = function() game.reset() end },
        { label = labels.settings, x = x, y = y + (height + gap),      w = width, h = height, enabled = false },
        { label = labels.quit,     x = x, y = y + (height + gap) * 2,  w = width, h = height, onClick = function() love.event.quit() end }
    }

    menu.buildGround(screenWidth, screenHeight)
end

-- function that draw the lunar ground and its horizon line
function menu.drawGround(screenWidth)
    local ground = menu.ground
    local tile = ground.tile

    for row = 1, #ground.tints do
        for column = 1, #ground.tints[row] do
            local tint = ground.tints[row][column]
            love.graphics.setColor(tint, tint, tint)
            love.graphics.rectangle('fill', (column - 1) * tile, ground.y + (row - 1) * tile, tile, tile)
        end
    end

    love.graphics.setColor(colors.horizon)
    love.graphics.rectangle('fill', 0, ground.y, screenWidth, 2)
end

-- function that draw the banner of the game, or its name if the image is missing
function menu.drawBanner(screenWidth, screenHeight)
    love.graphics.setColor(1, 1, 1)

    if banner == nil then
        love.graphics.setFont(fonts.title)
        utils.printCentered(labels.title, 0, screenHeight * 0.15, screenWidth)
        return
    end

    -- the banner is never enlarged, it would only get blurry on a big screen
    local scale = math.min(screenWidth * layout.bannerWidth / banner:getWidth(), 1)
    local x = utils.round((screenWidth - banner:getWidth() * scale) / 2)
    love.graphics.draw(banner, x, utils.round(screenHeight * layout.bannerY), 0, scale, scale)
end

-- function that draw the best time of the player, above the horizon
function menu.drawBest(screenWidth, screenHeight)
    local best = save.getBest()
    local text = labels.noBest
    if best ~= nil then
        text = string.format(labels.best, utils.formatTime(best))
    end

    love.graphics.setFont(fonts.small)
    love.graphics.setColor(colors.text)
    utils.printCentered(text, 0, screenHeight * layout.bestY, screenWidth)
end

-- function that draw the version of the game, in the bottom right corner
function menu.drawVersion(screenWidth, screenHeight)
    local margin = screenHeight * 0.025

    love.graphics.setFont(fonts.small)
    love.graphics.setColor(colors.text)
    local x = screenWidth - margin - fonts.small:getWidth(version)
    love.graphics.print(version, utils.round(x), utils.round(screenHeight - fonts.small:getHeight() - margin))
end

function menu.draw()
    local screenWidth, screenHeight = love.graphics.getDimensions()

    love.graphics.setColor(colors.sky)
    love.graphics.rectangle('fill', 0, 0, screenWidth, screenHeight)

    menu.drawGround(screenWidth)
    menu.drawBanner(screenWidth, screenHeight)
    button.drawList(menu.buttons)
    menu.drawBest(screenWidth, screenHeight)
    menu.drawVersion(screenWidth, screenHeight)
end

function menu.mousepressed(x, y, pressedButton)
    if pressedButton ~= 1 then return end
    button.clickList(menu.buttons, x, y)
end

return menu
