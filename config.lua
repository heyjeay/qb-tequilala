Config = {}

Config.Teleports = {
    [1] = {
        [1] = {x = -563.28, y = 287.47, z = 85.38, h = 81.38, r = 1.0},
        [2] = {x = -565.22, y = 284.57, z = 85.38, h = 171.51, r = 1.0},
    }
   
}
JustTeleported = false

Config.Locations = {
     ["carspawn"] = {
        label = "Car Spawn",
        coords = {x =-574.33, y =268.94, z =82.45, h =85.29},
    },
    ["stash"] = {
        label = "Tequilala Stash",
        coords = {x =-561.79, y =289.86, z =82.18, h =355.14},
    },
    ["shop"] = {
        label = "Tequilala Shop",
        coords = {x =-562.50, y =285.63, z =82.18, h =86.26},
    },
}

-- Tequilala Settings:
Config.tequilalaLocation = {
	{ ["x"] = -562.50, ["y"] = 285.63, ["z"] = 82.18, ["h"] = 0 },
}

Config.Vehicles = {
    ["patriot2"] = "Patriot Limo",
}

Config.job = "tequilala"
Config.stashname = "tequilalatash"

Config.tequilalaBlipNameOnMap = "Tequi-la-la"
Config.tequilalaBlipSprite = 93						
Config.tequilalaBlipDisplay = 4						
Config.tequilalaBlipScale = 0.8						
Config.tequilalaBlipColour = 5	

Config.Items = {
    label = "Tequi-la-la Shop",
    slots = 5,
    items = {
        [1] = {
            name = "beer",
            price = 3,
            amount = 50,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "whiskey",
            price = 3,
            amount = 50,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "vodka",
            price = 3,
            amount = 50,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "sandwich",
            price = 3,
            amount = 50,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "tosti",
            price = 3,
            amount = 50,
            info = {},
            type = "item",
            slot = 5,
        },
    }
}