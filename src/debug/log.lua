local cfg = require "src.config"

local log = {}
log.entries = {}

function log.add(text)
    table.insert(log.entries, string.format("%s", text))
    if #log.entries > 10 then
        table.remove(log.entries, 1)
    end
end

function log.clear()
    log.entries = {}
end

-- draw the log entries (top right of the screen)
function log.draw()
    local text = ""
    for i = 1, #log.entries do
        text = text .. '\n' .. log.entries[i]
    end
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(text, cfg.graphics.width - 500, 50)
end

return log