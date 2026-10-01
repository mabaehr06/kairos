local cfg   = require "src.config"
local items = {}

items.ressources =
{
    { id = 'regolithe', density = 0.34, color = {138,124,123}, hitBox = true },
    { id = 'glace',     density = 0.18, color = { 35,172,196}, hitBox = true },
    { id = 'fer',       density = 0.19, color = {196,194,190}, hitBox = true },
    { id = 'titane',    density = 0.14, color = {196,199,206}, hitBox = true },
    { id = 'silicium',  density = 0.11, color = { 82, 89,110}, hitBox = true },
    { id = 'helium',    density = 0.04, color = {100,230,220}, hitBox = true }
}

items.specials =
{
    { id = 'oxygene', color = {128, 16, 16} }
}

items.objects =
{
    { id = 'panel',         cost = { fer = 1, silicium = 2 }, craftTime = 5,  color = { 30,  60, 120} },
    { id = 'battery',       cost = { fer = 1, titane = 1 },   craftTime = 10, color = { 60, 180,  90} },
    { id = 'electrolyseur', cost = { fer = 2, titane = 1 },   craftTime = 10, color = {200, 120,  40} },

    -- tests
    -- { id = 'panel',         display = "Panneau solaire", cost = { regolithe = 1 }, craftTime = 2,  color = { 30,  60, 120} },
    -- { id = 'battery',       display = "Batterie",        cost = { regolithe = 1 },   craftTime = 2, color = { 60, 180,  90} },
    -- { id = 'electrolyseur', display = "Électrolyseur",   cost = { regolithe = 1 },   craftTime = 2, color = {200, 120,  40} },
}

items.rocket =
{
    { id = 'coque',        cost = { regolithe = 6, fer = 2 } },
    { id = 'reservoirs',   cost = { fer = 3, titane = 2 } },
    { id = 'electronique', cost = { silicium = 3, fer = 1 } },
    { id = 'moteurs',      cost = { titane = 3, fer = 2 } },
    { id = 'carburant',    cost = { glace = 2, helium = 2 } }

    -- tests
    -- { id = 'coque',        display = "Coque",        cost = { regolithe = 0 } },
    -- { id = 'reservoirs',   display = "Réservoirs",   cost = { regolithe = 0 } },
    -- { id = 'electronique', display = "Électronique", cost = { regolithe = 0 } },
    -- { id = 'moteurs',      display = "Moteurs",      cost = { regolithe = 0 } },
    -- { id = 'carburant',    display = "Carburant",    cost = { regolithe = 0 } },
}

-- the radar is not a placed object: it is an upgrade of the field of view of the player, one entry per level.
items.radar =
{
    { visibility = 7,  cost = { titane = 1, silicium = 1 }, craftTime = 5  },
    { visibility = 9, cost = { titane = 2, silicium = 1 }, craftTime = 10 },
    { visibility = 11, cost = { titane = 3, silicium = 2 }, craftTime = 15 },
    { visibility = 13, cost = { titane = 4, silicium = 3 }, craftTime = 20 },
    { visibility = 15, cost = { titane = 5, silicium = 4 }, craftTime = 25 }
}

-- items.radar =
-- {
--     { visibility = 7,  cost = { regolithe = 1 }, craftTime = 5  },
--     { visibility = 10, cost = { regolithe = 1 }, craftTime = 10 },
--     { visibility = 13, cost = { regolithe = 1 }, craftTime = 15 },
--     { visibility = 16, cost = { regolithe = 1 }, craftTime = 20 },
--     { visibility = 20, cost = { regolithe = 1 }, craftTime = 25 }
-- }

-- function that load the sprite of every ressource, from 'assets/ressources'
function items.loadImages()
    for i = 1, #items.ressources do
        local r = items.ressources[i]
        r.image = love.graphics.newImage("assets/ressources/" .. r.id .. ".png")
    end
end

function items.getRessourceById(id)
    for i = 1, #items.ressources do
        if items.ressources[i].id == id then
            return items.ressources[i]
        end
    end
    return nil
end

return items