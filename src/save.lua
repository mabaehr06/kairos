
local save = {}
local fileName = "best.txt"

function save.getBest()
    local content = love.filesystem.read(fileName)
    if content == nil then return nil end
    return tonumber(content)
end

function save.submit(score)
    local best = save.getBest()
    if best == nil or score < best then
        love.filesystem.write(fileName, tostring(score))
        return true
    end
    return false
end

return save