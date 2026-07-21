local utils = {}

-- this function restrict the num value between the lower and the upper
-- 5 and (10, 20) => 10
-- 35 and (12, 18) => 18
-- 17 and (10, 20) => 17
function utils.clamp(num, lower, upper)
    return math.max(lower, math.min(num, upper))
end

-- this function return the len for the number of entries in a table
-- for example :
-- {a = 12, b = 27, c = 42 } => return 3
function utils.countLen(object)
    local count = 0
    for _ in pairs(object) do
        count = count + 1
    end
    return count
end

-- return true if the point (px, py) is inside the given rectangle
function utils.isPointInRect(px, py, rx, ry, rw, rh)
    return px >= rx and px <= rx + rw and py >= ry and py <= ry + rh
end


-- help to format the time (from seconds to X min Y s)
function utils.formatTime(seconds)
    local min = math.floor(seconds / 60)
    local sec = seconds % 60

    return string.format("%d min %d s", min, sec)
end

-- SOUND
-- function utils.playsound(filePath, volume, pitch)
--     local sound = love.audio.newSource(filePath, "stream")

--     if volume ~= nil then
--         sound:setVolume(volume)
--     end

--     if pitch ~= nil then
--         sound:setPitch(pitch)
--     end

--     sound:play()
-- end


return utils