local cfg = require "src.config"
local log = require "src.debug.log"
local save = require "src.save"
local utils = require "src.utils"
local lang = require "src.lang"

local game = {}

game.state = {
    menu = "menu",
    settings = "settings",
    inGame = "inGame",
    pause = "pause",
    defeat = "defeat",
    victory = "victory",
    inventory = "inventory"
}

function game.load()
    game.totalTime = 0
    game.stateSelected = game.state.menu -- firstState 
    -- utils.playsound("assets/audio/music/background.mp3", 1, 1)
end

function game.update(dt)
    game.totalTime = game.totalTime + dt
end

function game.changeState(state)
    game.stateSelected = state
end

function game.reset()
    local map = require "src.map"
    local rocket = require "src.rocket"
    local player = require "src.player"
    local power = require "src.power"
    local crafts = require "src.crafts"
    local radar = require "src.radar"

    game.totalTime = 0
    game.selectedObject = nil
    map.load()
    rocket.load()
    player.load()
    power.load()
    crafts.load()
    radar.load()

    game.changeState(game.state.inGame)
    log.clear()
end

function game.win()
    game.stateSelected = game.state.victory
    game.isNewRecord = save.submit(game.totalTime)
    log.add(lang.t("log.victory", game.totalTime))
end

-- the reason is a lang key, not a text: the end screen resolve it when it draw it
function game.lose(reason)
    game.stateSelected = game.state.defeat
    game.deathReason = reason
    log.add(lang.t(game.deathReason))
end

return game
