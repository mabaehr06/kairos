return {
    -- menu
    ["menu.play"]     = "Gioca",
    ["menu.settings"] = "Impostazioni",
    ["menu.quit"]     = "Esci",
    ["menu.best"]     = "Miglior tempo: %s",
    ["menu.noBest"]   = "Nessun record per ora",

    -- settings
    ["settings.title"]    = "Impostazioni",
    ["settings.language"] = "Lingua",
    ["settings.back"]     = "Indietro",

    -- end screens
    ["ending.victory"]   = "Vittoria!",
    ["ending.defeat"]    = "Sconfitta...",
    ["ending.time"]      = "Il tuo tempo: %s",
    ["ending.record"]    = "Il tuo record: %s",
    ["ending.newRecord"] = "Nuovo record!",
    ["ending.replay"]    = "Gioca di nuovo",
    ["ending.menu"]      = "Menu",

    -- inventory
    ["inventory.ressources"]    = "Risorse",
    ["inventory.crafting"]      = "Fabbricazione",
    ["inventory.objects"]       = "Strutture",
    ["inventory.upgrade"]       = "Potenziamento",
    ["inventory.queue"]         = "In corso:",
    ["inventory.queueEmpty"]    = "Nessuna fabbricazione in corso",
    ["inventory.row"]           = "%s: %d",
    ["inventory.cost"]          = "%d %s, ",
    ["inventory.recipe"]        = "%s (%s - %ds)",
    ["inventory.craft"]         = "%s - %ds",
    ["inventory.power"]         = "Elettricità: %d/%d",
    ["inventory.radar"]         = "Radar: liv. %d (%d caselle)",
    ["inventory.radarUpgrade"]  = "Radar: %d → %d caselle (%s - %ds)",
    ["inventory.radarMax"]      = "Radar liv. %d: %d caselle (massimo)",
    ["inventory.objective"]     = "Obiettivo: %s",
    ["inventory.objectiveCost"] = "%s: %d/%d",
    ["inventory.place"]         = "Clicca su una casella per posizionare: %s",
    ["inventory.placeNone"]     = "Nessuna unità di %s da posizionare: fabbricane una prima (clic sinistro)",

    -- hud
    ["hud.power"] = "Elettricità: %d/%d",
    ["hud.radar"] = "Radar: liv. %d (%d caselle)",

    -- items, named by their id
    ["item.regolithe"]     = "Regolite",
    ["item.glace"]         = "Ghiaccio",
    ["item.fer"]           = "Ferro",
    ["item.titane"]        = "Titanio",
    ["item.silicium"]      = "Silicio",
    ["item.helium"]        = "Elio-3",
    ["item.oxygene"]       = "Ossigeno puro",
    ["item.panel"]         = "Pannello solare",
    ["item.battery"]       = "Batteria",
    ["item.electrolyseur"] = "Elettrolizzatore",

    -- the repair steps of the rocket, named by their id
    ["rocket.coque"]        = "Scafo",
    ["rocket.reservoirs"]   = "Serbatoi",
    ["rocket.electronique"] = "Elettronica",
    ["rocket.moteurs"]      = "Motori",
    ["rocket.carburant"]    = "Carburante",

    -- the radar upgrade, as it reads in the craft queue
    ["radar.craft"] = "Radar liv. %d",

    -- time
    ["time.day"]   = "Giorno",
    ["time.night"] = "Notte",
    ["time.cycle"] = "%s %d - %02d:%02d",
    ["time.spent"] = "%d min %d s",

    -- log
    ["log.craft.started"]   = "Fabbricazione avviata: %s (%ds)",
    ["log.craft.done"]      = "Fabbricazione completata: %s",
    ["log.craft.missing"]   = "Risorse insufficienti (%s)",
    ["log.craft.placed"]    = "Posizionato: %s",
    ["log.craft.cantPlace"] = "Impossibile posizionare qui",
    ["log.harvest"]         = "Trovato: %s (totale: %d)",
    ["log.harvest.nothing"] = "Non c'è nulla intorno a te.",
    ["log.oxygen"]          = "Ossigeno: %d/%d",
    ["log.oxygen.cant"]     = "Non puoi consumare questo al momento.",
    ["log.death.oxygen"]    = "Sei morto per asfissia. Fine della partita.",
    ["log.rocket.upgraded"] = "Riparazione: %s (%d/%d)",
    ["log.rocket.cant"]     = "Non puoi riparare il razzo",
    ["log.radar.level"]     = "Radar livello %d: %d caselle di visione",
    ["log.radar.max"]       = "Il radar è già al livello massimo",
    ["log.radar.running"]   = "È già in corso un potenziamento del radar",
    ["log.power.noIce"]     = "Ghiaccio insufficiente",
    ["log.power.noPower"]   = "Elettricità insufficiente (%d/%d)",
    ["log.power.done"]      = "Elettrolisi: +1 Ossigeno puro",
    ["log.victory"]         = "Vittoria in %.02f secondi",
}
