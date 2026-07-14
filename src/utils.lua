local utils = {}

-- this function restrict the num value between the lower and the upper
-- 5 and (10, 20) => 10
-- 35 and (12, 18) => 18
-- 17 and (10, 20) => 17
function utils.clamp(num, lower, upper)
    return math.max(lower, math.min(num, upper))
end

return utils