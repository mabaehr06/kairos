return {
    -- menu
    ["menu.play"]     = "Jugar",
    ["menu.settings"] = "Ajustes",
    ["menu.quit"]     = "Salir",
    ["menu.best"]     = "Mejor tiempo: %s",
    ["menu.noBest"]   = "Aún no hay récord",

    -- settings
    ["settings.title"]    = "Ajustes",
    ["settings.language"] = "Idioma",
    ["settings.back"]     = "Volver",

    -- end screens
    ["ending.victory"]   = "¡Victoria!",
    ["ending.defeat"]    = "Derrota...",
    ["ending.time"]      = "Tu tiempo: %s",
    ["ending.record"]    = "Tu récord: %s",
    ["ending.newRecord"] = "¡Nuevo récord!",
    ["ending.replay"]    = "Jugar de nuevo",
    ["ending.menu"]      = "Menú",

    -- inventory
    ["inventory.ressources"]    = "Recursos",
    ["inventory.crafting"]      = "Fabricación",
    ["inventory.objects"]       = "Estructuras",
    ["inventory.upgrade"]       = "Mejora",
    ["inventory.queue"]         = "En curso:",
    ["inventory.queueEmpty"]    = "Ninguna fabricación en curso",
    ["inventory.row"]           = "%s: %d",
    ["inventory.cost"]          = "%d %s, ",
    ["inventory.recipe"]        = "%s (%s - %ds)",
    ["inventory.craft"]         = "%s - %ds",
    ["inventory.power"]         = "Electricidad: %d/%d",
    ["inventory.radar"]         = "Radar: niv. %d (%d casillas)",
    ["inventory.radarUpgrade"]  = "Radar: %d → %d casillas (%s - %ds)",
    ["inventory.radarMax"]      = "Radar niv. %d: %d casillas (máximo)",
    ["inventory.objective"]     = "Objetivo: %s",
    ["inventory.objectiveCost"] = "%s: %d/%d",
    ["inventory.place"]         = "Haz clic en una casilla para colocar: %s",
    ["inventory.placeNone"]     = "No hay ninguna unidad de %s que colocar: fabrica una primero (clic izquierdo)",

    -- hud
    ["hud.power"] = "Electricidad: %d/%d",
    ["hud.radar"] = "Radar: niv. %d (%d casillas)",

    -- items, named by their id
    ["item.regolithe"]     = "Regolito",
    ["item.glace"]         = "Hielo",
    ["item.fer"]           = "Hierro",
    ["item.titane"]        = "Titanio",
    ["item.silicium"]      = "Silicio",
    ["item.helium"]        = "Helio-3",
    ["item.oxygene"]       = "Oxígeno puro",
    ["item.panel"]         = "Panel solar",
    ["item.battery"]       = "Batería",
    ["item.electrolyseur"] = "Electrolizador",

    -- the repair steps of the rocket, named by their id
    ["rocket.coque"]        = "Casco",
    ["rocket.reservoirs"]   = "Depósitos",
    ["rocket.electronique"] = "Electrónica",
    ["rocket.moteurs"]      = "Motores",
    ["rocket.carburant"]    = "Combustible",

    -- the radar upgrade, as it reads in the craft queue
    ["radar.craft"] = "Radar niv. %d",

    -- time
    ["time.day"]   = "Día",
    ["time.night"] = "Noche",
    ["time.cycle"] = "%s %d - %02d:%02d",
    ["time.spent"] = "%d min %d s",

    -- log
    ["log.craft.started"]   = "Fabricación iniciada: %s (%ds)",
    ["log.craft.done"]      = "Fabricación completada: %s",
    ["log.craft.missing"]   = "Recursos insuficientes (%s)",
    ["log.craft.placed"]    = "Colocado: %s",
    ["log.craft.cantPlace"] = "No se puede colocar aquí",
    ["log.harvest"]         = "Encontrado: %s (total: %d)",
    ["log.harvest.nothing"] = "No hay nada a tu alrededor.",
    ["log.oxygen"]          = "Oxígeno: %d/%d",
    ["log.oxygen.cant"]     = "No puedes consumir esto ahora mismo.",
    ["log.death.oxygen"]    = "Has muerto por asfixia. Fin de la partida.",
    ["log.rocket.upgraded"] = "Reparación: %s (%d/%d)",
    ["log.rocket.cant"]     = "No puedes reparar el cohete",
    ["log.radar.level"]     = "Radar nivel %d: %d casillas de visión",
    ["log.radar.max"]       = "El radar ya está al nivel máximo",
    ["log.radar.running"]   = "Ya hay una mejora de radar en curso",
    ["log.power.noIce"]     = "No hay suficiente hielo",
    ["log.power.noPower"]   = "No hay suficiente electricidad (%d/%d)",
    ["log.power.done"]      = "Electrólisis: +1 Oxígeno puro",
    ["log.victory"]         = "Victoria en %.02f segundos",
}
