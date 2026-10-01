return {
    -- menu
    ["menu.play"]     = "Play",
    ["menu.settings"] = "Settings",
    ["menu.quit"]     = "Exit",
    ["menu.best"]     = "Best time: %s",
    ["menu.noBest"]   = "No record yet",

    -- settings
    ["settings.title"]    = "Settings",
    ["settings.language"] = "Language",
    ["settings.back"]     = "Back",

    -- end screens
    ["ending.victory"]   = "Victory!",
    ["ending.defeat"]    = "Defeat...",
    ["ending.time"]      = "Your time: %s",
    ["ending.record"]    = "Your best: %s",
    ["ending.newRecord"] = "New best!",
    ["ending.replay"]    = "Play again",
    ["ending.menu"]      = "Menu",

    -- inventory
    ["inventory.ressources"]    = "Resources",
    ["inventory.crafting"]      = "Crafting",
    ["inventory.objects"]       = "Structures",
    ["inventory.upgrade"]       = "Upgrade",
    ["inventory.queue"]         = "In progress:",
    ["inventory.queueEmpty"]    = "No crafting in progress",
    ["inventory.row"]           = "%s: %d",
    ["inventory.cost"]          = "%d %s, ",
    ["inventory.recipe"]        = "%s (%s - %ds)",
    ["inventory.craft"]         = "%s - %ds",
    ["inventory.power"]         = "Power: %d/%d",
    ["inventory.radar"]         = "Radar: Lv. %d (%d tiles)",
    ["inventory.radarUpgrade"]  = "Radar: %d → %d tiles (%s - %ds)",
    ["inventory.radarMax"]      = "Radar Lv. %d: %d tiles (maximum)",
    ["inventory.objective"]     = "Objective: %s",
    ["inventory.objectiveCost"] = "%s: %d/%d",
    ["inventory.place"]         = "Click a tile to place: %s",
    ["inventory.placeNone"]     = "No %s available to place: craft one first (left click)",

    -- hud
    ["hud.power"] = "Power: %d/%d",
    ["hud.radar"] = "Radar: Lv. %d (%d tiles)",

    -- items, named by their id
    ["item.regolithe"]     = "Regolith",
    ["item.glace"]         = "Ice",
    ["item.fer"]           = "Iron",
    ["item.titane"]        = "Titanium",
    ["item.silicium"]      = "Silicon",
    ["item.helium"]        = "Helium-3",
    ["item.oxygene"]       = "Pure Oxygen",
    ["item.panel"]         = "Solar Panel",
    ["item.battery"]       = "Battery",
    ["item.electrolyseur"] = "Electrolyzer",

    -- the repair steps of the rocket, named by their id
    ["rocket.coque"]        = "Hull",
    ["rocket.reservoirs"]   = "Tanks",
    ["rocket.electronique"] = "Electronics",
    ["rocket.moteurs"]      = "Engines",
    ["rocket.carburant"]    = "Fuel",

    -- the radar upgrade, as it reads in the craft queue
    ["radar.craft"] = "Radar Lv. %d",

    -- time
    ["time.day"]   = "Day",
    ["time.night"] = "Night",
    ["time.cycle"] = "%s %d - %02d:%02d",
    ["time.spent"] = "%d min %d s",

    -- log
    ["log.craft.started"]   = "Crafting started: %s (%ds)",
    ["log.craft.done"]      = "Crafting completed: %s",
    ["log.craft.missing"]   = "Not enough resources (%s)",
    ["log.craft.placed"]    = "%s placed",
    ["log.craft.cantPlace"] = "Cannot place here",
    ["log.harvest"]         = "%s found (total: %d)",
    ["log.harvest.nothing"] = "There is nothing around you.",
    ["log.oxygen"]          = "Oxygen: %d/%d",
    ["log.oxygen.cant"]     = "You cannot consume this right now.",
    ["log.death.oxygen"]    = "You died from asphyxiation. Game over.",
    ["log.rocket.upgraded"] = "Repaired: %s (%d/%d)",
    ["log.rocket.cant"]     = "You cannot upgrade the rocket",
    ["log.radar.level"]     = "Radar level %d: %d tiles of vision",
    ["log.radar.max"]       = "The radar is already at the maximum level",
    ["log.radar.running"]   = "A radar upgrade is already in progress",
    ["log.power.noIce"]     = "Not enough ice",
    ["log.power.noPower"]   = "Not enough power (%d/%d)",
    ["log.power.done"]      = "Electrolysis: +1 Pure Oxygen",
    ["log.victory"]         = "Victory in %.02f seconds",
}