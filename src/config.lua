return {
    graphics = {
        resolution = 1080
    },
    controls = {
        quit = 'escape',
        movement = {
            up = 'z',
            left = 'q',
            down = 's',
            right = 'd'
        },
        interact = 'f',
        useGlace = 'c',
        inventory = 'e',
        useOxygen = 'v',
        reset = 'r'
    },
    player = {
        scale = 0.7,
        speed = 400,
        spawn = {
            random = true, -- if true, 'x' and 'y' below are ignored
            x = 0,
            y = 0
        },
        visibility = 6,
        maxOxygen = 25,
        oxygenTime = 30, -- in seconds
        oxygenRestore = { glace = 1, oxygene = 5 }
    },
    map = {
        tileSize = 64,
        width = 50,
        height = 50,
        ressources = {
            spawningDelay = 30, -- in seconds
            spawnRessources = 20,
            maxRessources = 50
        }
    },
    cycle = { -- time in second for a day/night length
        day        = 180, -- in seconds
        night      = 120,  -- in seconds
        
        dayStart   = 7, -- in hour, the hour the day start and the night end
        nightStart = 19 -- in hour, the hour the night start and the day end
    },
    rocket = {
        sizeX = 2,
        sizeY = 3
    },
    power = {
        panel        = { production = 1, productionDelay = 5, capacity = 10 },
        battery      = { capacity = 50 },
        electrolyzer = { glaceCost = 1, electricityCost = 6 }
    },
}