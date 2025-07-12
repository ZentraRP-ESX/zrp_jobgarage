local ESX = exports['es_extended']:getSharedObject()

-- Pæne labels til menu
local DepartmentLabels = {
    police = "👮‍♂️ Politi",
    ambulance = "👩‍⚕️ Ambulance",
    mechanic = "👨‍🔧 Mekaniker"
}

-- Funktion til at generere køretøjs-menu per afdeling
function CreateDepartmentMenu(departmentName, departmentVehicles)
    local elements = {}
    local xPlayer = ESX.GetPlayerData()
    local jobName = xPlayer.job.name
    local rank = xPlayer.job.grade

    for vehicleName, vehicleData in pairs(departmentVehicles) do
        local allowed = true

        if Config.RestrictVehiclesRank and vehicleData.rank and rank < vehicleData.rank then
            allowed = false
        end

        if Config.RestrictVehiclesJob and vehicleData.job and vehicleData.job ~= jobName then
            allowed = false
        end

        if allowed then
            table.insert(elements, {
                title = vehicleData.label,
                icon = 'car-side',
                event = 'jobgarage:spawnVehicle',
                args = {
                    Department = departmentName,
                    vehicle = vehicleData
                }
            })
        end
    end

    return elements
end

-- Register submenu for en afdeling
function RegisterDepartmentSubmenu(menuId, departmentName, departmentVehicles)
    local options = CreateDepartmentMenu(departmentName, departmentVehicles)
    local niceName = DepartmentLabels[departmentName] or departmentName

    lib.registerContext({
        id = menuId,
        title = niceName .. " Køretøjer",
        menu = 'garage_main_menu',
        options = options
    })
end

-- Hovedmenu med afdelinger
RegisterNetEvent('garage:jobmenu', function()
    local elements = {}

    for departmentName, departmentVehicles in pairs(Config.DepartmentVehicles) do
        local subMenuId = 'department_menu_' .. departmentName:gsub("%s+", "_"):lower()
        local options = CreateDepartmentMenu(departmentName, departmentVehicles)

        if #options > 0 then
            RegisterDepartmentSubmenu(subMenuId, departmentName, departmentVehicles)

            local niceName = DepartmentLabels[departmentName] or departmentName
            table.insert(elements, {
                title = niceName,
                icon = 'car',
                menu = subMenuId
            })
        end
    end

    table.insert(elements, {
        title = '🚗 Opbevar Køretøj',
        icon = 'warehouse',
        event = 'jobgarage:storecar'
    })

    lib.registerContext({
        id = 'garage_main_menu',
        title = '🚙 Jobgarage',
        options = elements
    })

    lib.showContext('garage_main_menu')
end)
