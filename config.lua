Config = {
    Debug = true,
    EnableBlips = true,
    TravelCost = 500,
    DefaultCutsceneDuration = 8000,
    
    Locations = {
        los_santos = {
            name = "Los Santos International",
            coords = vector3(-1037.46, -2737.55, 20.17),
            planeSpawn = vector4(-976.12, -2998.74, 12.95, 57.34),
            playerSpawn = vector4(-1037.46, -2737.55, 20.17, 327.63),
            cutscene = {
                name = "hs4_lsa_land_nimb",
                flags = 8
            },
            landingConfig = {
                position = vector3(-1594.17, -2994.31, 12.84),
                rotation = vector3(0.0, 0.0, 150.0),
                duration = 2500,
                playerFlags = 64
            }
        },
        sandy_shores = {
            name = "Sandy Shores Airfield",
            coords = vector3(1731.8, 3309.04, 41.22),
            planeSpawn = vector4(1731.8, 3309.04, 40.22, 188.56),
            playerSpawn = vector4(1724.5, 3285.33, 41.09, 180.88),
            cutscene = {
                name = "hs4_lsa_land_nimb",
                flags = 8
            },
            landingConfig = {
                position = vector3(1177.22, 3108.84, 40.41),
                rotation = vector3(0.0, 0.0, 283.77),
                duration = 2500,
                playerFlags = 64
            }
        },
        grapeseed = {
            name = "Grapeseed Airfield",
            coords = vector3(2152.83, 4797.03, 41.15),
            planeSpawn = vector4(2132.65, 4784.65, 40.97, 24.73),
            playerSpawn = vector4(2140.44, 4812.45, 41.15, 115.0),
            cutscene = {
                name = "hs4_lsa_land_nimb",
                flags = 8
            },
            landingConfig = {
                position = vector3(2622.54, 5076.99, 387.03),
                rotation = vector3(0.0, 0.0, 115.0),
                duration = 2500,
                playerFlags = 64
            }
        },
        zancudo = {
            name = "Fort Zancudo Airbase",
            coords = vector3(-2238.0, 3188.64, 32.81),
            planeSpawn = vector4(-2137.84, 3256.85, 32.81, 148.6),
            playerSpawn = vector4(-2229.2, 3177.54, 32.81, 330.0),
            cutscene = {
                name = "hs4_lsa_land_nimb",
                flags = 8
            },
            landingConfig = {
                position = vector3(-2643.49, 3225.62, 32.81),
                rotation = vector3(0.0, 0.0, 330.0),
                duration = 2500,
                playerFlags = 64
            }
        },
        deep_artic = {
            name = "Deep Artic Runway",
            coords = vector3(5544.04, 13730.02, 8.5),
            planeSpawn = vector4(5544.04, 13730.02, 7.5, 214.56),
            playerSpawn = vector4(5550.16, 13705.12, 8.5, 225.41),
            cutscene = {
                name = "hs4_lsa_land_nimb",
                flags = 8
            },
            landingConfig = {
                position = vector3(5485.52, 13579.29, 8.5),
                rotation = vector3(0.0, 0.0, 100.94),
                duration = 2500,
                playerFlags = 64
            }
        }
    }
}