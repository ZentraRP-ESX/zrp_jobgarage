Config = {}

-- NPC locations where police NPCs appear.
Config.PedLocations = {
    -- Police NPCs
    { coords = vector4(459.6, -986.6, 24.7, 90.88), model = 's_m_y_cop_01', job = "police", department = "MRPD" },
    { coords = vector4(381.59, -1617.05, 28.29, 233.39), model = 's_m_y_cop_01', job = "police", department = "DAVIS" },
    { coords = vector4(376.57, 800.3, 186.62, 91.13), model = 's_m_y_cop_01', job = "police", department = "RANGER" },

    -- Ambulance NPCs
    { coords = vector4(328.0998, -578.3383, 27.7969, 156.6363), model = 's_m_m_paramedic_01', job = "ambulance", department = "PILLBOX" },

    -- Mechanic NPCs
    { coords = vector4(200.1, -1400.3, 30.5, 90.0), model = 's_m_m_garbage', job = "mechanic", department = "main" },
}


-- Job names allowed to access job garages.
Config.AllowedJobs = {
    "police",
    "ambulance",
    "mechanic",
    -- Add any other jobs that should have access to the garage
}

-- Fuel system used by police vehicles.
Config.FuelSystem = 'LegacyFuel'

-- Controls if players can only use vehicles based on their job rank.
Config.RestrictVehiclesRank = true

-- Controls if players can only use vehicles based on their job.
Config.RestrictVehiclesJob = true

-- Locations where police vehicles spawn for each department.
Config.VehSpawnLocations = {
    police = {
        MRPD = {
            { coords = vector4(450.07, -975.77, 25.37, 90.07) },
            { coords = vector4(435.0, -975.85, 25.37, 90.34) },
        },
        DAVIS = {
            { coords = vector4(386.9, -1615.3, 28.98, 230.55) },
        }
    },
    ambulance = {
        PILLBOX = {
            { coords = vector4(332.6630, -590.9364, 28.7969, 344.3825) },
            { coords = vector4( 318.3257, -573.9751, 28.7969, 250.1038) },
        }
    },
    mechanic = {
        main = {
            { coords = vector4(200.1, -1400.3, 30.5, 90.0) },
        }
    }
}

-- Enable max performance upgrades on police vehicles.
Config.Maxmods = true

-- Enable turbo upgrade on police vehicles.
Config.Turbo = true

-- Vehicles available per police department.
Config.DepartmentVehicles = {
    police = {
        Streiter = {
            model = "polstreiter",
            label = "Streiter - Markeret",
            primarycolor = 0,
            secondarycolor = 0,
            livery = 0,
            rank = 0,
            job = "police",
            mods = {
                { id = 0, modenabled = -1 },
            },
            extras = {
                { id = 1, enabled = 1  },
                { id = 2, enabled = 0 },
                { id = 3, enabled = 0 },
            },
            trunkItems = {
                { name = "armor", amount = 5, info = {} },
                { name = "firstaid", amount = 3, info = {} },
                { name = "weapon_stungun", amount = 1, info = {} },
                { name = "handcuffs", amount = 2, info = {} }
            }
        },
        Raiden = {
            model = "polraiden",
            label = "Raiden - Markeret",
            primarycolor = 0,
            secondarycolor = 0,
            livery = 0,
            rank = 0,
            job = "police",
            mods = {
                { id = 0, modenabled = -1 },
            },
            extras = {
                { id = 1, enabled = 1   },
                { id = 2, enabled = 1   },
                { id = 3, enabled = 1  },
                { id = 4, enabled = 1  },
                { id = 5, enabled = 1  },
                { id = 6, enabled = 1  },
                { id = 7, enabled = 1  },
                { id = 8, enabled = 1  },
                { id = 9, enabled = 1  },
                { id = 10, enabled = 1  },
                { id = 11, enabled = 1  },
                { id = 12, enabled = 1  },
            },
            trunkItems = {
                { name = "armor", amount = 5, info = {} },
                { name = "firstaid", amount = 3, info = {} },
                { name = "weapon_stungun", amount = 1, info = {} },
                { name = "handcuffs", amount = 2, info = {} }
            }
        },
        Jugular = {
            model = "poljugular",
            label = "Jugular - Markeret",
            primarycolor = 0,
            secondarycolor = 0,
            livery = 0,
            rank = 0,
            job = "police",
            mods = {
                { id = 0, modenabled = -1 },
            },
            extras = {
                { id = 1, enabled = 1   },
                { id = 2, enabled = 1   },
                { id = 3, enabled = 1  },
                { id = 4, enabled = 1  },
                { id = 5, enabled = 1  },
                { id = 6, enabled = 1  },
                { id = 7, enabled = 1  },
                { id = 8, enabled = 1  },
                { id = 9, enabled = 1  },
                { id = 10, enabled = 1  },
                { id = 11, enabled = 1  },
                { id = 12, enabled = 1  },
            },
            trunkItems = {
                { name = "armor", amount = 5, info = {} },
                { name = "firstaid", amount = 3, info = {} },
                { name = "weapon_stungun", amount = 1, info = {} },
                { name = "handcuffs", amount = 2, info = {} }
            }
        },
        XLSC = {
            model = "polcxls",
            label = "XLS - Civil",
            primarycolor = 0,
            secondarycolor = 0,
            livery = 0,
            rank = 0,
            job = "police",
            mods = {
                { id = 0, modenabled = -1 },
            },
            extras = {
                { id = 1, enabled = 1   },
                { id = 2, enabled = 1   },
                { id = 3, enabled = 1  },
                { id = 4, enabled = 1  },
                { id = 5, enabled = 1  },
                { id = 6, enabled = 1  },
                { id = 7, enabled = 1  },
                { id = 8, enabled = 1  },
                { id = 9, enabled = 1  },
                { id = 10, enabled = 1  },
                { id = 11, enabled = 1  },
                { id = 12, enabled = 1  },
            },
            trunkItems = {
                { name = "armor", amount = 5, info = {} },
                { name = "firstaid", amount = 3, info = {} },
                { name = "weapon_stungun", amount = 1, info = {} },
                { name = "handcuffs", amount = 2, info = {} }
            }
        },
        TailgaterC = {
            model = "polctailgater2",
            label = "Tailgater S - Civil",
            primarycolor = 0,
            secondarycolor = 0,
            livery = 0,
            rank = 0,
            job = "police",
            mods = {
                { id = 0, modenabled = -1 },
            },
            extras = {
                { id = 1, enabled = 1   },
                { id = 2, enabled = 1   },
                { id = 3, enabled = 1  },
                { id = 4, enabled = 1  },
                { id = 5, enabled = 1  },
                { id = 6, enabled = 1  },
                { id = 7, enabled = 1  },
                { id = 8, enabled = 1  },
                { id = 9, enabled = 1  },
                { id = 10, enabled = 1  },
                { id = 11, enabled = 1  },
                { id = 12, enabled = 1  },
            },
            trunkItems = {
                { name = "armor", amount = 5, info = {} },
                { name = "firstaid", amount = 3, info = {} },
                { name = "weapon_stungun", amount = 1, info = {} },
                { name = "handcuffs", amount = 2, info = {} }
            }
        },
        SchafterC = {
            model = "polcschafter3",
            label = "Schafter - Civil",
            primarycolor = 0,
            secondarycolor = 0,
            livery = 0,
            rank = 0,
            job = "police",
            mods = {
                { id = 0, modenabled = -1 },
            },
            extras = {
                { id = 1, enabled = 1   },
                { id = 2, enabled = 1   },
                { id = 3, enabled = 1  },
                { id = 4, enabled = 1  },
                { id = 5, enabled = 1  },
                { id = 6, enabled = 1  },
                { id = 7, enabled = 1  },
                { id = 8, enabled = 1  },
                { id = 9, enabled = 1  },
                { id = 10, enabled = 1  },
                { id = 11, enabled = 1  },
                { id = 12, enabled = 1  },
            },
            trunkItems = {
                { name = "armor", amount = 5, info = {} },
                { name = "firstaid", amount = 3, info = {} },
                { name = "weapon_stungun", amount = 1, info = {} },
                { name = "handcuffs", amount = 2, info = {} }
            }
        },
        GresleyhC = {
            model = "polcgresleyh",
            label = "Gresleyh - Civil",
            primarycolor = 0,
            secondarycolor = 0,
            livery = 0,
            rank = 0,
            job = "police",
            mods = {
                { id = 0, modenabled = -1 },
            },
            extras = {
                { id = 1, enabled = 1   },
                { id = 2, enabled = 1   },
                { id = 3, enabled = 1  },
                { id = 4, enabled = 1  },
                { id = 5, enabled = 1  },
                { id = 6, enabled = 1  },
                { id = 7, enabled = 1  },
                { id = 8, enabled = 1  },
                { id = 9, enabled = 1  },
                { id = 10, enabled = 1  },
                { id = 11, enabled = 1  },
                { id = 12, enabled = 1  },
            },
            trunkItems = {
                { name = "armor", amount = 5, info = {} },
                { name = "firstaid", amount = 3, info = {} },
                { name = "weapon_stungun", amount = 1, info = {} },
                { name = "handcuffs", amount = 2, info = {} }
            }
        },
        BuffaloC = {
            model = "polcbuffalo4",
            label = "Buffalo - Civil",
            primarycolor = 0,
            secondarycolor = 0,
            livery = 0,
            rank = 0,
            job = "police",
            mods = {
                { id = 0, modenabled = -1 },
            },
            extras = {
                { id = 1, enabled = 1   },
                { id = 2, enabled = 1   },
                { id = 3, enabled = 1  },
                { id = 4, enabled = 1  },
                { id = 5, enabled = 1  },
                { id = 6, enabled = 1  },
                { id = 7, enabled = 1  },
                { id = 8, enabled = 1  },
                { id = 9, enabled = 1  },
                { id = 10, enabled = 1  },
                { id = 11, enabled = 1  },
                { id = 12, enabled = 1  },
            },
            trunkItems = {
                { name = "armor", amount = 5, info = {} },
                { name = "firstaid", amount = 3, info = {} },
                { name = "weapon_stungun", amount = 1, info = {} },
                { name = "handcuffs", amount = 2, info = {} }
            }
        },
        -- flere police køretøjer
    },

    ambulance = {
        AmbulanceVan = {
            model = "ambulance",
            label = "Ambulance Van",
            primarycolor = 1,
            secondarycolor = 1,
            livery = 0,
            rank = 0,
            job = "ambulance",
            mods = {},
            extras = {},
            trunkItems = {
                { name = "medkit", amount = 5, info = {} }
            }
        }
        -- flere ambulance køretøjer
    },

    mechanic = {
        Flatbed = {
            model = "flatbed",
            label = "Flatbed Truck",
            primarycolor = 0,
            secondarycolor = 0,
            livery = 0,
            rank = 0,
            job = "mechanic",
            mods = {},
            extras = {},
            trunkItems = {}
        }
        -- flere mekaniker køretøjer
    }
}