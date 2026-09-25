local cfg    = require "src.config"
local game   = require "src.game"
local fonts  = require "src.fonts"
local items  = require "src.items"
local map    = require "src.map"
local rocket = require "src.rocket"
local player = require "src.player"
local camera = require "src.camera"
local cycle  = require "src.cycle"
local power  = require "src.power"
local crafts = require "src.crafts"

local scenes = {
    [game.state.menu]      = require "src.scenes.menu",
    [game.state.inGame]    = require "src.scenes.play",
    [game.state.inventory] = require "src.scenes.play",
    [game.state.victory]   = require "src.scenes.ending",
    [game.state.defeat]    = require "src.scenes.ending"
}

local currentScene = nil

-- function that return the scene of the current state, and call its enter() the first time we get in it
local function getScene()
    local scene = scenes[game.stateSelected]
    if scene ~= currentScene then
        currentScene = scene
        if scene ~= nil and scene.enter ~= nil then scene.enter() end
    end
    return scene
end

-- function that load everything the program need at the launch of the program
function love.load()
    game.load()
    math.randomseed(os.time())
    cfg.graphics.width = love.graphics.getWidth()
    cfg.graphics.height = love.graphics.getHeight()
    items.loadImages()
    map.create()
    rocket.load()
    map.generateRessources()
    player.load()
    camera.load()
    fonts.load()
    cycle.load()
    power.load()
    crafts.load()
end

-- from here, every callback only give the hand to the scene of the current state
function love.update(dt)
    local scene = getScene()
    if scene ~= nil and scene.update ~= nil then scene.update(dt) end
end

function love.draw()
    -- setFont is a global state: every frame start back from the game font,
    love.graphics.setFont(fonts.hud)

    local scene = getScene()
    if scene ~= nil then scene.draw() end
end

function love.keypressed(key, scancode, isRepeat)
    -- quitting the game works from every screen
    if key == cfg.controls.quit then love.event.quit() end

    local scene = getScene()
    if scene ~= nil and scene.keypressed ~= nil then scene.keypressed(key) end
end

function love.mousepressed(x, y, button)
    local scene = getScene()
    if scene ~= nil and scene.mousepressed ~= nil then scene.mousepressed(x, y, button) end
end
