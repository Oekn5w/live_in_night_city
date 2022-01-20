local Easy = {
    thirst = {
        visualStep = 3,
        visualEffects = "BaseStatusEffect.NetwatcherGeneral",
        stats = {
            {
                name = "Stamina",
                type = "Multiplier",
                step = {1.5, 0.75, 0.5, 0.25},
            },
            {
                name = "Memory",
                type = "Additive",
                step = {0, 0, -1, -2},
            },
        },
        range = {
            {min = 99, max = 100},
            {min = 25, max = 50},
            {min = 0, max = 25},
            {min = -1, max = 0},
        },
    },
    hunger = {
        visualStep = 3,
        visualEffects = "BaseStatusEffect.NetwatcherGeneral",
        stats = {
            {
                name = "Health",
                type = "Multiplier",
                step = {1.5, 0.75, 0.5, 0.25},
            }
        },
        range = {
            {min = 99, max = 100},
            {min = 20, max = 40},
            {min = 0, max = 20},
            {min = -1, max = 0},
        },
    },
    fatigue = {
        visualStep = 3,
        visualEffects = "BaseStatusEffect.NetwatcherGeneral",
        stats = {
            {
                name = "CritChance",
                type = "Multiplier",
                step = {1.5, 0.75, 0.5, 0.25},
            },
            {
                name = "StaminaRegenRate",
                type = "Multiplier",
                step = {1.5, 0.75, 0.5, 0.25},
            },
        },
        range = {
            {min = 99, max = 100},
            {min = 20, max = 40},
            {min = 0, max = 20},
            {min = -1, max = 0},
        }
    }
}

return Easy