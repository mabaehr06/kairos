local cfg = require "src.config"

function love.conf(t)
    t.window.title = "Kairos"
    t.identity = "kairos"

    t.window.height = cfg.graphics.resolution
    t.window.width = t.window.height * (16 / 9)

    t.window.fullscreen = false -- if enabled, resolution' setting in config file is useless
    t.window.borderless = true
    t.window.vsync = true

    t.window.display = 1

    cfg.graphics.width = 0
    cfg.graphics.height = 0
end
