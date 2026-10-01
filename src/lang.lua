local settings = require "src.settings"

local lang = {}

-- the languages the game can be played in, in the order the settings screen shows them
lang.codes = { "en", "es", "fr", "it" }

-- the language every other one falls back to: it is the one always kept complete
local fallback = "fr"

local translations = {}
for i = 1, #lang.codes do
    translations[lang.codes[i]] = require("src.lang." .. lang.codes[i])
end

-- function that give the text behind a key, in the language currently chosen.
function lang.t(key, ...)
    local chosen = translations[settings.language] or translations[fallback]
    local text = chosen[key] or translations[fallback][key] or key

    if select("#", ...) == 0 then return text end
    return string.format(text, ...)
end

return lang
