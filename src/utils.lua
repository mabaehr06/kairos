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

return utils