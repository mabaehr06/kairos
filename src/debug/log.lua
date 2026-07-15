

local log = {}
log.entries = {}

function log.add(text)
    table.insert(log.entries, string.format("%d: %s", os.time(), text))
    if #log.entries > 10 then
        table.remove(log.entries, 1)
    end
end

function log.clear()
    log.entries = {}
end

return log