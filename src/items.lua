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

items.objects = {}

items.rocket =
{
    -- { id = 'coque',        display = "Coque",        cost = { regolithe = 6, fer = 2 } },
    -- { id = 'reservoirs',   display = "Réservoirs",   cost = { fer = 3, titane = 2 } },
    -- { id = 'electronique', display = "Électronique", cost = { silicium = 3, fer = 1 } },
    -- { id = 'moteurs',      display = "Moteurs",      cost = { titane = 3, fer = 2 } },
    -- { id = 'carburant',    display = "Carburant",    cost = { glace = 2, helium = 2 } }

    -- tests
    { id = 'coque',        display = "Coque",        cost = { regolithe = 0 } },
    { id = 'reservoirs',   display = "Réservoirs",   cost = { regolithe = 0 } },
    { id = 'electronique', display = "Électronique", cost = { regolithe = 0 } },
    { id = 'moteurs',      display = "Moteurs",      cost = { regolithe = 0 } },
    { id = 'carburant',    display = "Carburant",    cost = { regolithe = 0 } },
}

return items