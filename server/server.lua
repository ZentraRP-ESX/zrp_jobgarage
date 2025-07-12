local ESX = exports['es_extended']:getSharedObject()

-- Add items to a vehicle trunk (ox_inventory)
RegisterNetEvent("jobgarage:addTrunkItems", function(plate, trunkItems)
    local stashId = 'jobtrunk-' .. plate  -- Undgå 'trunk-' for at forhindre entitetskrav

    -- Tjek først om stash allerede eksisterer
    local existing = exports.ox_inventory:GetInventory(stashId)
    if not existing then
        TriggerEvent('ox_inventory:registerStash', stashId, {
            label = 'Vehicle Trunk',
            slots = 40,
            weight = 80000,
            owner = false -- vigtigt: undgår at stash bindes til spiller
        })
        Wait(100)
    end

    -- Tilføj trunk items
    for _, item in pairs(trunkItems) do
        exports.ox_inventory:AddItem(stashId, item.name, item.amount, nil, item.info or {})
    end
end)
