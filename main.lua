local cfg = require "src.config"
local player = require "src.player"
local map = require "src.map"
local camera = require "src.camera"
local log = require "src.debug.log"
local gui = require "src.gui.gui"
local cycle = require "src.cycle"
local rocket = require "src.rocket"
local game = require "src.game"
local crafts = require "src.crafts"
local inventory = require "src.gui.inventory"
local power = require "src.power"
local utils = require "src.utils"
local menu = require "src.gui.menu"
local endscreen = require "src.gui.endscreen"

-- function that load everything the program need at the launch of the program
function love.load()
    game.load()
    math.randomseed(os.time())
    cfg.graphics.width = love.graphics.getWidth()
    cfg.graphics.height = love.graphics.getHeight()
    map.create()
    rocket.load()
    map.generateRessources()
    player.load()
    camera.load()
    love.graphics.setFont(love.graphics.newFont(24))
    cycle.load()
    power.load()
    crafts.load()
end

-- function that update every module
function love.update(dt)
    local state = game.stateSelected

    if state == game.state.inGame or state == game.state.inventory then
        game.update(dt)
        player.update(dt)
        camera.update(dt)
        map.update(dt)
        crafts.update(dt)
        power.update(dt)
    end
end

-- function that draw eve-ry-thing
function love.draw()
    if game.stateSelected == game.state.inGame then
        love.graphics.push() -- use is to keep memory of the position before the translation
        love.graphics.translate(-camera.x, -camera.y) -- camera translation thing

        map.draw() -- used to draw the map 
        rocket.draw() -- used to draw the rocket (lol)
        player.draw() -- used to draw the player (lol, again)

        love.graphics.pop() -- we go back to before the translation, so we will be able to draw later the gui without any difficulties
        
        log.draw()
    end
    
    gui.draw()

end

-- function that handle key inputs
function love.keypressed(key, scancode, isRepeat)
    local ctrl = cfg.controls
    local state = game.stateSelected
    local gs = game.state

    -- quit the game
    if key == ctrl.quit then love.event.quit() end

    -- inventory handler
    if key == ctrl.inventory then
        if state == gs.inGame then game.changeState(gs.inventory)
        elseif state == gs.inventory then game.changeState(gs.inGame) end
    end

    -- interaction handler
    if state == gs.inGame then
        if key == ctrl.interact then
            player.interact()
        end
        if key == ctrl.useGlace then
            player.consumeForOxygen('glace', cfg.player.oxygenRestore.glace)
        end
        if key == ctrl.useOxygen then
            player.consumeForOxygen('oxygene', cfg.player.oxygenRestore.oxygene)
        end
    end


    if key == ctrl.reset then
        game.reset()
    end
end

function love.mousepressed(x, y, button)
    local state = game.stateSelected

    if state == game.state.menu then
        menu.mousepressed(x, y, button)
    elseif state == game.state.victory or state == game.state.defeat then
        endscreen.mousepressed(x, y, button)
    elseif state == game.state.inventory then
        inventory.mousepressed(x, y, button)
    elseif state == game.state.inGame then
        crafts.place(x, y, button)
    end
end