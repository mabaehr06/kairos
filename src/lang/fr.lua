return {
    -- menu
    ["menu.play"]     = "JoueHer",
    ["menu.settings"] = "Paramètres",
    ["menu.quit"]     = "Quitter",
    ["menu.best"]     = "Meilleur temps : %s",
    ["menu.noBest"]   = "Aucun record pour l'instant",

    -- settings
    ["settings.title"]    = "Paramètres",
    ["settings.language"] = "Langue",
    ["settings.back"]     = "Retour",

    -- end screens
    ["ending.victory"]   = "Victoire !",
    ["ending.defeat"]    = "Défaite...",
    ["ending.time"]      = "Votre temps : %s",
    ["ending.record"]    = "Votre record : %s",
    ["ending.newRecord"] = "Nouveau record !",
    ["ending.replay"]    = "Rejouer",
    ["ending.menu"]      = "Menu",

    -- inventory
    ["inventory.ressources"]    = "Ressources",
    ["inventory.crafting"]      = "Fabrication",
    ["inventory.objects"]       = "Objets",
    ["inventory.upgrade"]       = "Amélioration",
    ["inventory.queue"]         = "En cours :",
    ["inventory.queueEmpty"]    = "Aucune fabrication en cours",
    ["inventory.row"]           = "%s : %d",
    ["inventory.cost"]          = "%d %s, ",
    ["inventory.recipe"]        = "%s (%s - %ds)",
    ["inventory.craft"]         = "%s - %ds",
    ["inventory.power"]         = "Électricité : %d/%d",
    ["inventory.radar"]         = "Radar : niv. %d (%d cases)",
    ["inventory.radarUpgrade"]  = "Radar : %d → %d cases (%s - %ds)",
    ["inventory.radarMax"]      = "Radar niv. %d : %d cases (maximum)",
    ["inventory.objective"]     = "Objectif : %s",
    ["inventory.objectiveCost"] = "%s : %d/%d",
    ["inventory.place"]         = "Cliquez sur une case pour poser : %s",
    ["inventory.placeNone"]     = "Aucun %s à poser : fabriquez-le d'abord (clic gauche)",

    -- hud
    ["hud.power"] = "Électricité: %d/%d",
    ["hud.radar"] = "Radar: niv. %d (%d cases)",

    -- items, named by their id
    ["item.regolithe"]     = "Régolithe",
    ["item.glace"]         = "Glace",
    ["item.fer"]           = "Fer",
    ["item.titane"]        = "Titane",
    ["item.silicium"]      = "Silicium",
    ["item.helium"]        = "Hélium-3",
    ["item.oxygene"]       = "Oxygène pur",
    ["item.panel"]         = "Panneau solaire",
    ["item.battery"]       = "Batterie",
    ["item.electrolyseur"] = "Électrolyseur",

    -- the repair steps of the rocket, named by their id
    ["rocket.coque"]        = "Coque",
    ["rocket.reservoirs"]   = "Réservoirs",
    ["rocket.electronique"] = "Électronique",
    ["rocket.moteurs"]      = "Moteurs",
    ["rocket.carburant"]    = "Carburant",

    -- the radar upgrade, as it reads in the craft queue
    ["radar.craft"] = "Radar niv. %d",

    -- time
    ["time.day"]   = "Jour",
    ["time.night"] = "Nuit",
    ["time.cycle"] = "%s %d - %02dh%02d",
    ["time.spent"] = "%d min %d s",

    -- log
    ["log.craft.started"]   = "Fabrication lancée : %s (%ds)",
    ["log.craft.done"]      = "Fabrication terminée : %s",
    ["log.craft.missing"]   = "Ressources insuffisantes (%s)",
    ["log.craft.placed"]    = "%s posé",
    ["log.craft.cantPlace"] = "Impossible de poser ici",
    ["log.harvest"]         = "%s trouvé (total : %d)",
    ["log.harvest.nothing"] = "Il n 'y a rien autour de toi.",
    ["log.oxygen"]          = "Oxygène : %d/%d",
    ["log.oxygen.cant"]     = "Vous ne pouvez pas consommer ceci actuellement.",
    ["log.death.oxygen"]    = "Vous êtes mort d'asphyxie. Fin de la partie.",
    ["log.rocket.upgraded"] = "Amélioration %s effectué (%d/%d)",
    ["log.rocket.cant"]     = "Vous ne pouvez pas améliorer la fusée",
    ["log.radar.level"]     = "Radar niveau %d : vision de %d cases",
    ["log.radar.max"]       = "Le radar est déjà au niveau maximum",
    ["log.radar.running"]   = "Une amélioration du radar est déjà en cours",
    ["log.power.noIce"]     = "Pas assez de glace",
    ["log.power.noPower"]   = "Pas assez d'électricité (%d/%d)",
    ["log.power.done"]      = "Électrolyse : +1 Oxygène pur",
    ["log.victory"]         = "Victoire en %.02f secondes",
}
