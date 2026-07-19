local cfg   = require "src.config"
local items = {}

items.ressources =
{
    { id = 'regolithe', density = 0.45, display = "Régolithe", color = {138,124,123}, hitBox = true },
    { id = 'glace',     density = 0.20, display = "Glace"    , color = { 35,172,196}, hitBox = true },
    { id = 'fer',       density = 0.15, display = "Fer"      , color = {196,194,190}, hitBox = true },
    { id = 'titane',    density = 0.09, display = "Titane"   , color = {196,199,206}, hitBox = true },
    { id = 'silicium',  density = 0.09, display = "Silicium" , color = { 82, 89,110}, hitBox = true },
    { id = 'helium',    density = 0.02, display = "Hélium-3" , color = {100,230,220}, hitBox = true }
}

items.objects =
{
    { id = 'panneau',       display = "Panneau solaire", cost = { silicium = 2, fer = 1 }, craftTime = 5,  color = { 30,  60, 120} },
    { id = 'batterie',      display = "Batterie",        cost = { fer = 1, titane = 1 },   craftTime = 10, color = { 60, 180,  90} },
    { id = 'electrolyseur', display = "Électrolyseur",   cost = { fer = 2, titane = 1 },   craftTime = 10, color = {200, 120,  40} },
}

items.rocket =
{
    { id = 'coque',        display = "Coque",        cost = { regolithe = 6, fer = 2 } },
    { id = 'reservoirs',   display = "Réservoirs",   cost = { fer = 3, titane = 2 } },
    { id = 'electronique', display = "Électronique", cost = { silicium = 3, fer = 1 } },
    { id = 'moteurs',      display = "Moteurs",      cost = { titane = 3, fer = 2 } },
    { id = 'carburant',    display = "Carburant",    cost = { glace = 2, helium = 2 } }

    -- tests
    -- { id = 'coque',        display = "Coque",        cost = { regolithe = 0 } },
    -- { id = 'reservoirs',   display = "Réservoirs",   cost = { regolithe = 0 } },
    -- { id = 'electronique', display = "Électronique", cost = { regolithe = 0 } },
    -- { id = 'moteurs',      display = "Moteurs",      cost = { regolithe = 0 } },
    -- { id = 'carburant',    display = "Carburant",    cost = { regolithe = 0 } },
}

function items.getRessourceById(id)
    for i = 1, #items.ressources do
        if items.ressources[i].id == id then
            return items.ressources[i]
        end
    end
    return nil
end

return items