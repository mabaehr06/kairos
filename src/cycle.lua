local cfg = require "src.config"

local cycle = {}

local dayTime = 0
local nightTime = 0
local dayStart = 0
local nightStart = 0

-- dtTotal (float) (in seconds)
local dtTotal = 0

function cycle.load()
    dayTime = cfg.cycle.day
    nightTime = cfg.cycle.night
    dayStart = cfg.cycle.dayStart
    nightStart = cfg.cycle.nightStart
    
    cycle.isDay = false
end

-- function to format from the provided ressources
function cycle.format()

    -- formula to get the number of second in an entire day
    local dayTotalTime = dayTime + nightTime

    -- formula to get the number of second elapsed on the current day
    local currentDayTime = dtTotal % dayTotalTime

    -- formula to get the cyrcle format
    local isDay = (currentDayTime < dayTime)
    cycle.isDay = isDay
    local cycle = isDay and "Jour" or "Nuit"

    -- formula to get the number of day (we start Day 1, so + 1 at the end)
    local day = (dtTotal / (dayTime + nightTime)) + 1

    -- number of hours a day/night last
    local fictivDayLength = nightStart - dayStart
    local fictivNightLength = (24 + dayStart) - nightStart

    -- number of fictiv min / real sec
    local minPerSec = nil
    if isDay == true then
        minPerSec = (fictivDayLength * 60) / dayTime
    else
        minPerSec = (fictivNightLength * 60) / nightTime
    end

    -- number of fictiv min have passed since the start of the day
    local minSinceDayStart = nil

    if isDay == true then
        minSinceDayStart = currentDayTime * minPerSec + dayStart * 60
    else
        minSinceDayStart = (currentDayTime - dayTime) * minPerSec + nightStart * 60
    end

    -- formula to get the number of hour
    local hour = math.floor(minSinceDayStart / 60) % 24
    local min = minSinceDayStart % 60

    return string.format("%s %d - %02dh%02d", cycle, day, hour, min)
end

function cycle.update(dt)
    dtTotal = dtTotal + dt
end

return cycle




