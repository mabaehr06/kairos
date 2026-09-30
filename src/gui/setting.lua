local button = require "src.gui.button"
local fonts  = require "src.fonts"

-- a setting is a table: { label, options = {{ label, value }}, get, set }
-- it is drawn as one row: the name of the setting on the left, its options as buttons on the
-- right, the one holding the current value being the active one
local setting = {}

local colors = {
    label = {0.75, 0.76, 0.79}
}

local layout = {
    labelWidth = 0.35, -- part of the row taken by the name of the setting
    optionGap  = 12    -- space between two options, in pixels
}

-- function that build the buttons of one setting, and return them
function setting.build(s, x, y, w, h)
    local optionsX     = x + w * layout.labelWidth
    local optionsWidth = w - w * layout.labelWidth
    local optionWidth  = (optionsWidth - layout.optionGap * (#s.options - 1)) / #s.options

    local buttons = {}
    for i = 1, #s.options do
        local option = s.options[i]

        table.insert(buttons, {
            label   = option.label,
            x = optionsX + (i - 1) * (optionWidth + layout.optionGap),
            y = y, w = optionWidth, h = h,
            active  = s.get() == option.value,
            onClick = function() s.set(option.value) end
        })
    end
    return buttons
end

-- function that draw one setting, and return its buttons so the screen can click them
function setting.draw(s, x, y, w, h)
    love.graphics.setFont(fonts.button)
    love.graphics.setColor(colors.label)
    love.graphics.print(s.label, x, y + (h - fonts.button:getHeight()) / 2)

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
