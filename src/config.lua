return {
    graphics = {
        resolution = 720
    },
    controls = {
        quit = 'escape',
        movement = {
            up = 'z',
            left = 'q',
            down = 's',
            right = 'd'
        },
        interact = 'f'
    },
    player = {
        scale = 0.7,
        speed = 400,
        spawn = {
            random = true, -- if true, 'x' and 'y' below are ignored
            x = 0,
            y = 0
        }
    },
    map = {
        tileSize = 48,
        width = 50,
        height = 50,
        ressources = {
            spawningDelay = 30, -- in seconds
            spawnRessources = 30,
            maxRessources = 50
        }
    }
}