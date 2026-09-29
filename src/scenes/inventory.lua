local cfg = require "src.config"
local game = require "src.game"
local player = require "src.player"
local items = require "src.items"
local rocket = require "src.rocket"
local crafts = require "src.crafts"
local utils = require "src.utils"
local log = require "src.debug.log"
local power = require "src.power"
local hud  = require "src.gui.hud"
local play = require "src.scenes.play"
local fonts = require "src.fonts"
local button = require "src.gui.button"

local inventory = {}

local colors = {
    overlay     = {0, 0, 0, 0.55},
    panelFill   = {0.10, 0.10, 0.11},
    panelBorder = {0.30, 0.30, 0.31},
    title       = {1, 1, 1},
    text        = {0.75, 0.76, 0.79}
}

-- the two panels are placed in fraction of the window, so they follow any resolution
local layout = {
    marginX      = 0.06,
    marginY      = 0.08,
    marginBottom = 0.12,
    panelGap     = 0.04,
    panelWidth   = 0.42,
    padding      = 40, -- inner padding of a panel, in pixels
    titleHeight  = 60  -- room taken by the title of a panel, in pixels
}

-- function that return the rectangle of one of the two panels
function inventory.getPanelRect(index)
    local sw, sh = love.graphics.getDimensions()
    local w = sw * layout.panelWidth
    local x = sw * layout.marginX

    if index == 2 then
        x = x + w + sw * layout.panelGap
    end

    return x, sh * layout.marginY, w, sh * (1 - layout.marginY - layout.marginBottom)
end

-- function that draw a titled panel: a filled rectangle with a thin border
function inventory.drawPanel(x, y, w, h, title)
    love.graphics.setColor(colors.panelFill)
    love.graphics.rectangle('fill', x, y, w, h)

    love.graphics.setLineWidth(1)
    love.graphics.setColor(colors.panelBorder)
    love.graphics.rectangle('line', x + 0.5, y + 0.5, w, h)

    love.graphics.setFont(fonts.button)
    love.graphics.setColor(colors.title)
    love.graphics.print(title, x + layout.padding, y + 16)
end

-- function that draw one line of the inventory: its sprite if it has one, its color otherwise, then the name and the quantity
function inventory.drawRow(x, y, size, item)
    if item.image ~= nil then
        local scale = size / item.image:getWidth()
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(item.image, x, y, 0, scale, scale)
    elseif item.color ~= nil then
        love.graphics.setColor(love.math.colorFromBytes(item.color))
        love.graphics.rectangle('fill', x, y, size, size)
    end

    love.graphics.setFont(fonts.hud)
    love.graphics.setColor(colors.text)
    love.graphics.print(string.format("%s : %d", item.display, player.inventory[item.id]),
        x + size + 12, y + (size - fonts.hud:getHeight()) / 2)
end

function inventory.drawRessources(x, y)
    local lineHeight = 40
    local iconSize = 30

    local yActual = y

    for i = 1, #items.ressources do
        inventory.drawRow(x, yActual, iconSize, items.ressources[i])
        yActual = yActual + lineHeight
    end

    for i = 1, #items.specials do
        inventory.drawRow(x, yActual, iconSize, items.specials[i])
        yActual = yActual + lineHeight
    end

    yActual = yActual + lineHeight
    for i = 1, #items.objects do
        inventory.drawRow(x, yActual, iconSize, items.objects[i])
        yActual = yActual + lineHeight
    end

    yActual = yActual + lineHeight
    love.graphics.setFont(fonts.hud)
    love.graphics.setColor(colors.text)
    love.graphics.print(string.format("Électricité : %d/%d", power.current, power.getCapacity()), x, yActual)

    return yActual + lineHeight * 2
end

function inventory.returnCostMissing(step)
    local cost = items.rocket[step].cost
    local costMissing = {}

    for r, q in pairs(cost) do
        local pQ = player.inventory[r]
        costMissing[r] = {inventory = pQ, cost = q}
    end

    return costMissing
end

function inventory.drawObjective(x, y)
    love.graphics.setFont(fonts.button)
    love.graphics.setColor(colors.title)
    love.graphics.print(string.format("Objectif : %s", items.rocket[rocket.currentStep].display), x, y)

    love.graphics.setFont(fonts.hud)
    love.graphics.setColor(colors.text)

    local missingCost = inventory.returnCostMissing(rocket.currentStep)

    local count = 0
    for ressource, cost in pairs(missingCost) do
        local text = string.format("%s : %d/%d", items.getRessourceById(ressource).display, cost.inventory, cost.cost)
        love.graphics.print(text, x, y + 40 + count * 30)
        count = count + 1
    end
end

inventory.recipeButtons = {} -- clickable zones, rebuilt at every draw



function inventory.drawRecipes(x, y, w)
    local buttonHeight = 60
    local gap = 12

    inventory.recipeButtons = {} -- reset: the label and the state change while the game runs

    for i = 1, #items.objects do
        local object = items.objects[i]

        -- building the cost text: "2 Silicium, 1 Fer"
        local costText = ""
        for ressourceId, quantity in pairs(object.cost) do
            local r = items.getRessourceById(ressourceId)
            costText = costText .. string.format("%d %s, ", quantity, r.display)
        end
        costText = costText:sub(1, -3) -- drop the trailing ", "

        table.insert(inventory.recipeButtons, {
            object  = object,
            label   = string.format("%s (%s - %ds) - possédé : %d", object.display, costText, object.craftTime, player.inventory[object.id]),
            font    = fonts.hud,
            x = x, y = y + (i - 1) * (buttonHeight + gap),
            w = w, h = buttonHeight,
            enabled = player.hasRessources(object.cost),
            onClick = function() crafts.start(object) end
        })
    end

    button.drawList(inventory.recipeButtons)

    -- crafts in progress, below
    local queueY = y + #items.objects * (buttonHeight + gap) + gap * 2

    love.graphics.setFont(fonts.button)
    love.graphics.setColor(colors.title)
    love.graphics.print("En cours :", x, queueY)

    love.graphics.setFont(fonts.hud)
    love.graphics.setColor(colors.text)
    for i = 1, #crafts.queue do
        local craft = crafts.queue[i]
        love.graphics.print(string.format("%s - %ds", craft.display, math.ceil(craft.timeLeft)), x, queueY + i * 40)
    end
end

-- the game keep running while the inventory is opened, the oxygen does not wait for the player
function inventory.update(dt)
    play.update(dt)
end

function inventory.draw()
    local sw, sh = love.graphics.getDimensions()

    love.graphics.setColor(colors.overlay)
    love.graphics.rectangle('fill', 0, 0, sw, sh)

    local x, y, w, h = inventory.getPanelRect(1)
    inventory.drawPanel(x, y, w, h, "Ressources")
    local objectiveY = inventory.drawRessources(x + layout.padding, y + layout.titleHeight)
    inventory.drawObjective(x + layout.padding, objectiveY)

    x, y, w, h = inventory.getPanelRect(2)
    inventory.drawPanel(x, y, w, h, "Fabrication")
    inventory.drawRecipes(x + layout.padding, y + layout.titleHeight, w - layout.padding * 2)
end

function inventory.keypressed(key)
    if key == cfg.controls.inventory then
        game.changeState(game.state.inGame)
    end

    if key == cfg.controls.reset then
        game.reset()
    end
end

-- handle a click inside the inventory screen (left click: launch a craft, right click: pick an owned object to place it)
function inventory.mousepressed(x, y, pressedButton)
    if pressedButton == 1 then
        button.clickList(inventory.recipeButtons, x, y)
        return
    end

    if pressedButton == 2 then
        for i = 1, #inventory.recipeButtons do
            local b = inventory.recipeButtons[i]
            if utils.isPointInRect(x, y, b.x, b.y, b.w, b.h) then
                if player.inventory[b.object.id] > 0 then
                    game.selectedObject = b.object
                    game.changeState(game.state.inGame)
                    log.add(string.format("Cliquez sur une case pour poser : %s", b.object.display))
                else
                    log.add(string.format("Aucun %s à poser : fabriquez-le d'abord (clic gauche)", b.object.display))
                end
                return
            end
        end
    end
end
return inventory