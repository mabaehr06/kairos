local game    = require "src.game"
local store   = require "src.settings"
local setting = require "src.gui.setting"
local button  = require "src.gui.button"
local fonts   = require "src.fonts"
local utils   = require "src.utils"

-- the screen is named 'settings' like every scene is named after its file, so the module holding
-- the values themselves is taken as 'store' here
local settings = {}

local flagPath = "assets/languages/%s.png"
local flags = nil -- the images, loaded once the first time we enter the screen

-- the languages the screen offers, in the order they are shown
local languages = { "en", "es", "fr", "it" }

-- every text of the screen is gathered here, to prepare the translation of the game
local labels = {
    title    = "Paramètres",
    language = "Langue",
    back     = "Retour"
}

local colors = {
    background = {24 / 255, 24 / 255, 24 / 255},
    title      = {1, 1, 1}
}

-- the whole screen is placed in fraction of the window, so it follow any resolution
local layout = {
    margin     = 0.05, -- the distance from corner to title / back button
    rowsY      = 0.28,
    rowWidth   = 0.75,
    rowHeight  = 0.12,
    rowGap     = 0.03,
    backWidth  = 0.22,
    backHeight = 0.07
}

settings.buttons = {} -- the options of every row, rebuilt at every draw

-- function that load the flag of every language, once
local function loadFlags()
    if flags ~= nil then return end

    flags = {}
    for i = 1, #languages do
        local code = languages[i]
        flags[code] = love.graphics.newImage(string.format(flagPath, code))
    end
end

-- function that build the settings of the screen: only the language, for now
local function buildSettings()
    local options = {}
    for i = 1, #languages do
        local code = languages[i]
        table.insert(options, { value = code, image = flags[code] })
    end

    return {
        {
            label   = labels.language,
            options = options,
            get     = function() return store.language end,
            set     = function(value) store.set("language", value) end
        }
    }
end

-- function called every time we enter the screen, it loads the flags and places the back button
function settings.enter()
    local screenWidth, screenHeight = love.graphics.getDimensions()

    loadFlags()

    -- the margin is taken on the height for both axes, so the corner looks square
    local margin = utils.round(screenHeight * layout.margin)
    local width  = utils.round(screenWidth * layout.backWidth)
    local height = utils.round(screenHeight * layout.backHeight)

    settings.backButton = {
        label   = labels.back,
        x = screenWidth - margin - width,
        y = screenHeight - margin - height,
        w = width, h = height,
        onClick = function() game.changeState(game.state.menu) end
    }
end

function settings.draw()
    local screenWidth, screenHeight = love.graphics.getDimensions()

    love.graphics.setColor(colors.background)
    love.graphics.rectangle('fill', 0, 0, screenWidth, screenHeight)

    local margin = utils.round(screenHeight * layout.margin)

    love.graphics.setFont(fonts.subtitle)
    love.graphics.setColor(colors.title)
    love.graphics.print(labels.title, margin, margin)

    local width = screenWidth * layout.rowWidth

    settings.buttons = setting.drawList(buildSettings(),
        (screenWidth - width) / 2,
        screenHeight * layout.rowsY,
        width,
        screenHeight * layout.rowHeight,
        screenHeight * layout.rowGap)

    button.draw(settings.backButton)
end

function settings.mousepressed(x, y, pressedButton)
    if pressedButton ~= 1 then return end

    if button.clickList(settings.buttons, x, y) then return end
    button.click(settings.backButton, x, y)
end

return settings
