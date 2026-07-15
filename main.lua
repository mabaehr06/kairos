local cfg = require "src.config"
local player = require "src.player"
local map = require "src.map"
local camera = require "src.camera"
local log = require "src.debug.log"

local total = 0

-- function only used to log 
function love.log()
    local txa = ""
    for i = 1, #log.entries do
        txa = txa .. '\n' .. log.entries[i]
    end
    love.graphics.print(txa, 100, 100)
end

-- function that load everything the program need at the launch of the program
function love.load()
    math.randomseed(os.time())
    cfg.graphics.width = love.graphics.getWidth()
    cfg.graphics.height = love.graphics.getHeight()
    player.load()
    map.load()
    camera.load()
    love.graphics.setFont(love.graphics.newFont(24))
end

-- function that update every module
function love.update(dt)
    player.update(dt)
    camera.update(dt)
    map.update(dt)
end

-- function that draw eve-ry-thing
function love.draw()
    love.graphics.push() -- use is to keep memory of the position before the translation
    love.graphics.translate(-camera.x, -camera.y) -- camera translation thing

    map.draw() -- use to draw the map 
    player.draw() -- use to draw the player (lol)

    love.graphics.pop() -- we go back to before the translation, so we will be able to draw later the gui without any difficulties

    love.log()
end

-- function that handle key inputs
function love.keypressed(key, scancode, isRepeat)
    if (key == cfg.controls.quit) then
        love.event.quit()
    end

    if (key == cfg.controls.interact) then
        player.interact()
    end
end
