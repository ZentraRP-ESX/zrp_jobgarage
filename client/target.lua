local ESX = exports['es_extended']:getSharedObject()

local function addTargetZone(name, coords, heading)
    local jobNames = {}

    if type(Config.AllowedJobs) == "table" then
        jobNames = Config.AllowedJobs
    elseif type(Config.AllowedJobs) == "string" then
        jobNames = { Config.AllowedJobs }
    end

    exports.ox_target:addBoxZone({
        name = name,
        coords = coords,
        size = vec3(0.65, 0.75, 4.0),
        rotation = heading,
        debug = false,
        options = {
            {
                name = "jobgarage_menu",
                icon = "fa-solid fa-warehouse",
                label = "Job Garage",
                onSelect = function()
                    TriggerEvent('garage:jobmenu')
                end,
                canInteract = function(entity, distance, coords, name)
                    local job = ESX.GetPlayerData().job
                    for _, j in pairs(jobNames) do
                        if job and job.name == j then return true end
                    end
                    return false
                end
            }
        }
    })
end

-- Initialiser zoner
if Config and Config.PedLocations then
    for i, loc in ipairs(Config.PedLocations) do
        local zoneName = "JobGarage_" .. i
        local zoneCoords = vec3(loc.coords.x, loc.coords.y, loc.coords.z)
        local zoneHeading = loc.coords.w or 0.0
        addTargetZone(zoneName, zoneCoords, zoneHeading)
    end
else
    print("^1[JobGarage]^7 Config.PedLocations is not defined or nil.")
end
