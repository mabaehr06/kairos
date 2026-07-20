local endscreen = {}


function endscreen.draw()
    local game = require "src.game"
    local save = require "src.save"

    if game.stateSelected == game.state.victory then
        love.graphics.print(string.format("Victoire !"), 250, 100)

        local score = game.totalTime
        local best = save.getBest()

        if game.isNewRecord then
            love.graphics.print(string.format("Votre score: %0.5f (NOUVEAU RECORD !)", score), 250, 200)
        else 
            love.graphics.print(string.format("Votre score: %0.5f", score), 250, 200)
        end
        love.graphics.print(string.format("Votre record: %0.5f", best), 250, 300)
    end
    if game.stateSelected == game.state.defeat then
        love.graphics.print(string.format("Défaite..."), 250, 100)

        local score = game.totalTime
        local reason = game.deathReason

        love.graphics.print(string.format("%s", reason), 250, 200)
        love.graphics.print(score, 250, 300)
    end

    -- replay button
    endscreen.replayButton = { x = 400, y = 500, w = 300, h = 80 }
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle('fill', endscreen.replayButton.x, endscreen.replayButton.y, endscreen.replayButton.w, endscreen.replayButton.h)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Rejouer", endscreen.replayButton.x + 100, endscreen.replayButton.y + 25)

    -- menu
    endscreen.menuButton = { x = 400, y = 600, w = 300, h = 80 }
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle('fill', endscreen.menuButton.x, endscreen.menuButton.y, endscreen.menuButton.w, endscreen.menuButton.h)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Menu", endscreen.menuButton.x + 100, endscreen.menuButton.y + 25)
end

function endscreen.mousepressed(x, y, button)
    local utils = require "src.utils"
    local game = require "src.game"

    local r = endscreen.replayButton
    local m = endscreen.menuButton

    if utils.isPointInRect(x, y, r.x, r.y, r.w, r.h) then
        game.reset()
    end
    if utils.isPointInRect(x, y, m.x, m.y, m.w, m.h) then
        game.stateSelected = game.state.menu
    end
end


return endscreen