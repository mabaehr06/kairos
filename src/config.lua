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
        useGlace = 'c'
    },
    player = {
        scale = 0.7,
        speed = 300,
        spawn = {
            random = true, -- if true, 'x' and 'y' below are ignored
            x = 0,
            y = 0
        },
        visibility = 6,
        maxOxygen = 25,
        oxygenTime = 30 -- in seconds
    },
    map = {
        tileSize = 48,
        width = 25,
        height = 15,
        ressources = {
            spawningDelay = 0, -- in seconds
            spawnRessources = 2,
            maxRessources = 30
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
    }
}