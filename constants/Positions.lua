local Positions = {
    -- Default Watson Apt
    aptWatson = {
        x = -1381.2,
        y = 1271.1,
        z_min = 121,
        z_max = 126,
        r = 9,
        pois = {
            {
                x = -1377.8,
                y = 1274.0,
                r = 1,
                type = "bed"
            },
            {
                x = -1378.5,
                y = 1267.2,
                r = 1,
                type = "couch"
            },
            {
                x = -1382.7,
                y = 1278.0,
                r = 0.5,
                type = "shower"
            }
        }
    },
    -- NorthSide Apt
    aptNorthSide = {
        x = -1507.2,
        y = 2230.7,
        z_min = 20,
        z_max = 25,
        r = 7,
        pois = {
            {
                x = -1503.4,
                y = 2229.7,
                r = 1,
                type = "bed"
            },
            {
                x = -1508.7,
                y = 2227.2,
                r = 0.5,
                type = "shower"
            }
        }
    },
    -- Japantown Apt
    aptJapanTown = {
        x = -784.9,
        y = 979.1,
        z_min = 26,
        z_max = 31,
        r = 12,
        pois = {
            {
                x = -784.8,
                y = 987.5,
                r = 1,
                type = "bed"
            },
            {
                x = -784.8,
                y = 976.5,
                r = 1,
                type = "couch"
            },
            {
                -- chair
                x = -784.8,
                y = 972.5,
                r = 1,
                type = "couch"
            },
            {
                x = -779.2,
                y = 972.5,
                r = 0.5,
                type = "shower"
            }
        }
    }
}

return Positions
