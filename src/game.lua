local cfg = require "src.config"
local log = require "src.debug.log"

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
    game.stateSelected = game.state.inGame -- firstState 
end

function game.update(dt)
    game.totalTime = game.totalTime + dt
    -- print("state: ", game.stateSelected)
end

function game.changeState(state)
    game.stateSelected = state
end

function game.reset()
    game.totalTime = 0
end

function game.win()
    game.stateSelected = game.state.victory
    log.add(string.format("Victoire en %.02f secondes", game.totalTime))
end

function game.lose(reason)
    game.stateSelected = game.state.defeat
    game.deathReason = reason
    log.add(game.deathReason)
end

return game
