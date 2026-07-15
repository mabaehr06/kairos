local cfg = require "src.config"
local player = require "src.player"
local map = require "src.map"
local camera = require "src.camera"

local total = 0


function love.load()
    math.randomseed(os.time())
    cfg.graphics.width = love.graphics.getWidth()
    cfg.graphics.height = love.graphics.getHeight()
    player.load()
    map.load()
    camera.load()
end

function love.update(dt)
    player.update(dt)
    camera.update(dt)
    map.update(dt)
end

function love.draw()
    love.graphics.push() -- use is to keep memory of the position before the translation
    love.graphics.translate(-camera.x, -camera.y) -- camera translation thing

    map.draw() -- use to draw the map 
    player.draw() -- use to draw the player (lol)

    love.graphics.pop() -- we go back to before the translation, so we will be able to draw later the gui without any difficulties
end

function love.keypressed(key, scancode, isRepeat)
    if (key == cfg.controls.quit) then
        love.event.quit()
    end

    if (key == cfg.controls.interact) then
        player.interact()
    end
end

-- function love.wheelmoved(x, y)
--     local ts = cfg.map.tileSize
--     if y > 0 then
--         cfg.map.tileSize = ts + 1
--     elseif y < 0 then
--         cfg.map.tileSize = ts - 1
--     end
-- end