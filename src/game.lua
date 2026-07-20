local cfg = require "src.config"
local log = require "src.debug.log"
local save = require "src.save"

local game = {}

game.state = {
    menu = "menu",
    inGame = "inGame",
    pause = "pause",
    defeat = "defeat",
    victory = "victory",
    inventory = "inventory"
}

function game.load()
    game.totalTime = 0
    game.stateSelected = game.state.menu -- firstState 
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

    game.totalTime = 0
    game.selectedObject = nil
    map.load()
    rocket.load()
    map.generateRessources()
    player.load()
    power.load()
    crafts.load()

    game.changeState(game.state.inGame)
    log.clear()
end

function game.win()
    game.stateSelected = game.state.victory
    game.isNewRecord = save.submit(game.totalTime)
    log.add(string.format("Victoire en %.02f secondes", game.totalTime))
end

function game.lose(reason)
    game.stateSelected = game.state.defeat
    game.deathReason = reason
    log.add(game.deathReason)
end

return game
