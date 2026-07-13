local cfg = require "src.config"
player = require "src.player"

function love.load()
    cfg.graphics.width = love.graphics.getWidth()
    cfg.graphics.height = love.graphics.getHeight()
    player.load()
end

function love.update(dt)
    player.update(dt)
end

function love.draw()
    player.draw()
end

function love.keypressed(key, scancode, isRepeat)
    if (key == cfg.controls.quit) then
        love.event.quit()
    end
end