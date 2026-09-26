local cfg = require "src.config"

function love.conf(t)
    t.window.title = "Kairos"
    t.identity = "kairos"

    t.window.height = cfg.graphics.resolution
    t.window.width = t.window.height * (16 / 9)

    -- a window opened directly in fullscreen lands where WSLg decides, whatever 'display' says
    t.window.fullscreen = false
    t.window.borderless = false
    t.window.vsync = true

    t.window.display = cfg.graphics.display

    cfg.graphics.width = 0
    cfg.graphics.height = 0
end
