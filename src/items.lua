local cfg   = require "src.config"
local items = {}

items.ressources =
{
    { id = 'regolithe', density = 0.45, display = "Régolithe", color = {138,124,123} },
    { id = 'glace',     density = 0.20, display = "Glace"    , color = { 35,172,196} },
    { id = 'fer',       density = 0.15, display = "Fer"      , color = {196,194,190} },
    { id = 'titane',    density = 0.09, display = "Titane"   , color = {196,199,206} },
    { id = 'silicium',  density = 0.09, display = "Silicium" , color = { 82, 89,110} },
    { id = 'helium',    density = 0.02, display = "Hélium-3" , color = {100,230,220} }
}

return items