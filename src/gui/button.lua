local utils = require "src.utils"
local fonts = require "src.fonts"

-- a button is a simple table: { label, x, y, w, h, onClick, enabled }
local button = {}

-- colors taken from the logo: a thin grey outline, and the blue of the earth when the mouse is over
local border = {
    idle     = {0.30, 0.30, 0.31},
    -- hover    = {0.40, 0.64, 0.86},
    hover    = {0.86, 0.86, 0.86},
    disabled = {0.19, 0.19, 0.20}
}

local label = {
    idle     = {0.75, 0.76, 0.79},
    hover    = {1, 1, 1},
    disabled = {0.34, 0.34, 0.36}
}

-- function that pick, in a set of three colors, the one matching the state of the button
local function pickColor(set, enabled, hovered)
    if not enabled  then return set.disabled    end
    if hovered      then return set.hover       end
    return set.idle
end

-- function that return true if the mouse is currently over the given button
function button.isHovered(b)
    local mouseX, mouseY = love.mouse.getPosition()
    return utils.isPointInRect(mouseX, mouseY, b.x, b.y, b.w, b.h)
end

-- function that draw one button: a simple outline and its label, nothing else
function button.draw(b)
    local enabled = b.enabled ~= false
    local hovered = enabled and button.isHovered(b)

    -- the half pixel keep the one pixel outline sharp instead of two pixels looking ugly
    love.graphics.setLineWidth(1)
    love.graphics.setColor(pickColor(border, enabled, hovered))
    love.graphics.rectangle('line', b.x + 0.5, b.y + 0.5, b.w, b.h)

    love.graphics.setFont(fonts.button)
    love.graphics.setColor(pickColor(label, enabled, hovered))
    utils.printCentered(b.label, b.x, b.y + (b.h - fonts.button:getHeight()) / 2, b.w)
end

-- function that draw a whole list of buttons
function button.drawList(list)
    for i = 1, #list do
        button.draw(list[i])
    end
end

-- function that run the action of the button if the click is inside it, and return true if it did
function button.click(b, x, y)
    if (b.enabled == false) or (b.onClick == nil) then return false end
    if not utils.isPointInRect(x, y, b.x, b.y, b.w, b.h) then return false end

    b.onClick()
    return true
end

-- function that give a click to the first button of the list that hold it
function button.clickList(list, x, y)
    for i = 1, #list do
        if button.click(list[i], x, y) then return true end
    end
    return false
end

return button
