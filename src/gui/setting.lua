local button = require "src.gui.button"
local fonts  = require "src.fonts"

-- a setting is a table: { label, options = {{ label / image, value }}, get, set }
-- it is drawn as one row: the name of the setting on the left, its options as buttons on the right
local setting = {}

local colors = {
    label  = {0.75, 0.76, 0.79},
    border = {0.20, 0.20, 0.21}
}

local layout = {
    labelWidth = 0.45, -- part of the row taken by the name of the setting
    optionGap  = 12,   -- space between two options, in pixels
    padding    = 24    -- padding in pixels
}

-- function that pick the biggest font the name of a setting fits in, in the room it has.
-- nothing in the game wraps or cuts a text: a label too long simply runs over its options
local function labelFont(text, width)
    if fonts.button:getWidth(text) <= width then return fonts.button end
    return fonts.hud
end

-- function that build the buttons of one setting, and return them
function setting.build(s, x, y, w, h)
    local innerX, innerY = x + layout.padding, y + layout.padding
    local innerW, innerH = w - layout.padding * 2, h - layout.padding * 2

    local optionsX     = innerX + innerW * layout.labelWidth
    local optionsWidth = innerW - innerW * layout.labelWidth
    local optionWidth  = (optionsWidth - layout.optionGap * (#s.options - 1)) / #s.options

    local buttons = {}
    for i = 1, #s.options do
        local option = s.options[i]

        table.insert(buttons, {
            label   = option.label,
            image   = option.image,
            x = optionsX + (i - 1) * (optionWidth + layout.optionGap),
            y = innerY, w = optionWidth, h = innerH,
            active  = s.get() == option.value,
            onClick = function() s.set(option.value) end
        })
    end
    return buttons
end

-- function that draw one setting, and return its buttons so the screen can click them
function setting.draw(s, x, y, w, h)
    -- the frame of the setting. the half pixel keeps the one pixel outline sharp, as for a button
    love.graphics.setLineWidth(1)
    love.graphics.setColor(colors.border)
    love.graphics.rectangle('line', x + 0.5, y + 0.5, w, h)

    -- the name keeps a gutter before the first option, so a long one never touches it
    local labelWidth = (w - layout.padding * 2) * layout.labelWidth - layout.optionGap
    local font = labelFont(s.label, labelWidth)

    love.graphics.setFont(font)
    love.graphics.setColor(colors.label)
    love.graphics.print(s.label, x + layout.padding, y + (h - font:getHeight()) / 2)

    local buttons = setting.build(s, x, y, w, h)
    button.drawList(buttons)
    return buttons
end

-- function that draw a whole list of settings, one row each, and return every button of every row
function setting.drawList(list, x, y, w, h, gap)
    local buttons = {}

    for i = 1, #list do
        local rowButtons = setting.draw(list[i], x, y + (i - 1) * (h + gap), w, h)
        for j = 1, #rowButtons do
            table.insert(buttons, rowButtons[j])
        end
    end
    return buttons
end

return setting
