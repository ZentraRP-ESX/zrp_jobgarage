local ESX = exports['es_extended']:getSharedObject()

local garageLoopActive = false
local PlayerData = {}
local myPeds = {}

local function UpdatePlayerData()
    ESX.TriggerServerCallback('esx:getPlayerData', function(data)
        PlayerData = data
        CheckAndStartGarageLoop()
    end)
end

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    CheckAndStartGarageLoop()
end)

RegisterNetEvent('esx:setJob', function(job)
    PlayerData.job = job
    CheckAndStartGarageLoop()
end)

RegisterNetEvent('esx:onPlayerLogout', function()
    PlayerData = {}
    StopGarageLoop()
end)

Citizen.CreateThread(function()
    while not ESX.IsPlayerLoaded() do
        Citizen.Wait(1000)
    end
    UpdatePlayerData()
end)

local function GenerateRandomPlate()
    local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local plate = ""

    for i = 1, 8 do
        local rand = math.random(1, #charset)
        plate = plate .. charset:sub(rand, rand)
    end

    return plate:upper()
end

local function IsAllowedJob(jobName)
    if type(Config.AllowedJobs) == "table" then
        for _, allowedJob in ipairs(Config.AllowedJobs) do
            if jobName == allowedJob then return true end
        end
    elseif type(Config.AllowedJobs) == "string" then
        return jobName == Config.AllowedJobs
    end
    return false
end


function CheckAndStartGarageLoop()
    local jobName = PlayerData.job and PlayerData.job.name
    if jobName and IsAllowedJob(jobName) then
        StartGarageLoop()
    else
        StopGarageLoop()
    end
end

local function fadeEntityAlpha(entity, startAlpha, endAlpha, step, delay)
    for alpha = startAlpha, endAlpha, step do
        SetEntityAlpha(entity, alpha, false)
        Citizen.Wait(delay)
    end
end

function StartGarageLoop()
    if garageLoopActive then return end
    garageLoopActive = true

    Citizen.CreateThread(function()
        while garageLoopActive do
            local playerPed = PlayerPedId()
            local pos = GetEntityCoords(playerPed)

            for i, loc in ipairs(Config.PedLocations) do
                local npcLocation = loc.coords.xyz
                local dist = #(pos - npcLocation)

                if dist < 30 and not myPeds[i] then
                    myPeds[i] = CreateMyPed(loc.model, loc.coords, loc.coords.w)
                    if myPeds[i] then
                        fadeEntityAlpha(myPeds[i], 0, 255, 51, 50)
                    end
                elseif dist >= 30 and myPeds[i] then
                    fadeEntityAlpha(myPeds[i], 255, 0, -51, 50)
                    DeleteEntity(myPeds[i])
                    myPeds[i] = nil
                end
            end

            Citizen.Wait(1500)
        end
    end)
end

function StopGarageLoop()
    if not garageLoopActive then return end
    for _, ped in pairs(myPeds) do
        if DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
    end
    myPeds = {}
    garageLoopActive = false
end

function CreateMyPed(model, coords, heading)
    local modelHash = GetHashKey(model)
    RequestModel(modelHash)
    for attempts = 1, 20 do
        if HasModelLoaded(modelHash) then break end
        Citizen.Wait(10)
        if attempts == 20 then
            print("Kunne ikke loade model: " .. model)
            return nil
        end
    end

    local ped = CreatePed(4, modelHash, coords.x, coords.y, coords.z, heading, false, true)
    if not ped then
        print("Kunne ikke oprette ped for model: " .. model)
        return nil
    end

    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityAlpha(ped, 0, false)

    return ped
end

RegisterNetEvent('jobgarage:spawnVehicle')
AddEventHandler('jobgarage:spawnVehicle', function(data)
    if not data or not data.vehicle then
        return ESX.ShowNotification("Køretøjsdata mangler!")
    end

    local playerData = PlayerData
    local jobName = playerData.job and playerData.job.name

    if not jobName then
        return ESX.ShowNotification("Du har ikke et job registreret.")
    end

    -- Tjek rangrestriktion
    if Config.RestrictVehiclesRank and data.vehicle.rank and data.vehicle.rank > (playerData.job.grade or 0) then
        return ESX.ShowNotification("Dette køretøj er for en højere rang end din")
    end

    -- Tjek jobrestriktion
    if Config.RestrictVehiclesJob and data.vehicle.job and data.vehicle.job ~= jobName then
        return ESX.ShowNotification("Dette køretøj er for en anden afdeling")
    end

    local playerPed = PlayerPedId()
    local pedCoords = GetEntityCoords(playerPed)

    -- Find nærmeste NPC med samme job
    local closestLocation, minDistance = nil, math.huge
    for _, pedLocation in ipairs(Config.PedLocations) do
        if pedLocation.job == jobName then
            local npcCoords = vector3(pedLocation.coords.x, pedLocation.coords.y, pedLocation.coords.z)
            local dist = #(pedCoords - npcCoords)
            if dist < minDistance then
                minDistance = dist
                closestLocation = pedLocation.department
            end
        end
    end

    if not closestLocation then
        return ESX.ShowNotification("Ingen lokationer er tilgængelige for dit job.")
    end

    -- Find spawnpunkter for jobbet og afdelingen
    local spawnPointsForJob = Config.VehSpawnLocations[jobName]
    if not spawnPointsForJob then
        return ESX.ShowNotification("Der findes ingen spawn-punkter for dit job.")
    end

    local spawnPointsForDepartment = spawnPointsForJob[closestLocation]
    if not spawnPointsForDepartment then
        return ESX.ShowNotification("Der findes ingen spawn-punkter for din afdeling.")
    end

    -- Find et ledigt spawnpunkt
    local spawnPoint = nil
    for _, sp in ipairs(spawnPointsForDepartment) do
        local c = sp.coords
        if not IsAnyVehicleNearPoint(c.x, c.y, c.z, 3.0) then
            spawnPoint = sp
            break
        end
    end

    if not spawnPoint then
        return ESX.ShowNotification("Alle spawn-punkter for " .. closestLocation .. " er optaget")
    end

    -- Spawn køretøjet
    ESX.Game.SpawnVehicle(data.vehicle.model, spawnPoint.coords, spawnPoint.coords.w, function(veh)
        if not veh or not DoesEntityExist(veh) then
            return ESX.ShowNotification("Kunne ikke spawne køretøjet!")
        end

        SetVehicleModKit(veh, 0)

        if Config.Maxmods then
            for _, modType in ipairs({ 11, 12, 13, 15 }) do
                SetVehicleMod(veh, modType, GetNumVehicleMods(veh, modType) - 1, false)
            end
            if Config.Turbo then
                ToggleVehicleMod(veh, 18, true)
            end
        end

        -- Sæt mods fra køretøjsdata
        for _, mod in ipairs(data.vehicle.mods or {}) do
            SetVehicleMod(veh, mod.id, mod.modenabled, false)
        end

        -- Sæt extras
        for _, extra in ipairs(data.vehicle.extras or {}) do
            SetVehicleExtra(veh, extra.id, extra.enabled)
        end

        -- Livery og farver
        SetVehicleLivery(veh, data.vehicle.livery or 0)
        local plateText = GenerateRandomPlate()
        SetVehicleNumberPlateText(veh, plateText)
        exports[Config.FuelSystem]:SetFuel(veh, 100.0)
        SetVehicleDirtLevel(veh, 0.0)
        SetVehicleColours(veh, data.vehicle.primarycolor or 0, data.vehicle.secondarycolor or 0)
        SetVehicleDashboardColour(veh, 111)
        SetVehicleExtraColours(veh, 0, 0)

        TaskWarpPedIntoVehicle(playerPed, veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", plateText)

        if data.vehicle.trunkItems then
            TriggerServerEvent("jobgarage:addTrunkItems", plateText, data.vehicle.trunkItems)
        end

        SetVehicleEngineOn(veh, true, true, false)
    end)
end)

RegisterNetEvent('jobgarage:storecar')
AddEventHandler('jobgarage:storecar', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
    if not vehicle or vehicle == 0 then
        return ESX.ShowNotification("Du har ikke et køretøj i nærheden")
    end

    if GetVehicleClass(vehicle) == 18 then
        DeleteVehicle(vehicle)
        ESX.ShowNotification("Dit køretøj er nu opbevaret")
    else
        ESX.ShowNotification("Dette er ikke et politikøretøj")
    end
end)
