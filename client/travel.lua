local QBCore = exports['qb-core']:GetCoreObject()

local State = {
    isTraveling = false,
    planes = {}
}

local function CreatePlane(coords)
    local hash = GetHashKey("luxor2")
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(0) end
    
    local plane = CreateVehicle(hash, coords.x, coords.y, coords.z, coords.w, false, false)
    FreezeEntityPosition(plane, true)
    SetEntityInvincible(plane, true)
    SetVehicleDoorsLocked(plane, 2)
    SetVehicleEngineOn(plane, false, true, true)
    SetVehicleUndriveable(plane, true)
    SetEntityAsMissionEntity(plane, true, true)
    SetModelAsNoLongerNeeded(hash)
    
    return plane
end

CreateThread(function()
    for id, config in pairs(Config.Locations) do
        if Config.EnableBlips then
            local blip = AddBlipForCoord(config.coords.x, config.coords.y, config.coords.z)
            SetBlipSprite(blip, 307)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 3)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(config.name .. " Airport")
            EndTextCommandSetBlipName(blip)
        end

        local plane = CreatePlane(config.planeSpawn)
        State.planes[id] = plane

        exports['qb-target']:AddTargetEntity(plane, {
            options = {
                {
                    type = "client",
                    event = "plane-travel:showDestinations",
                    icon = "fas fa-plane-departure",
                    label = "View Available Flights",
                    airport = id
                }
            },
            distance = 3.0
        })
    end
end)

local function StartLandingSequence(toAirport)
    if IsCutsceneActive() then
        StopCutsceneImmediately()
    end

    RequestCutscene(toAirport.cutscene.name, toAirport.cutscene.flags or 8)
    
    local timeout = GetGameTimer() + 5000
    while not HasCutsceneLoaded() and GetGameTimer() < timeout do
        Wait(0)
    end

    if not HasCutsceneLoaded() then
        return false
    end
    
    local landingConfig = toAirport.landingConfig
    SetCutsceneOrigin(
        landingConfig.position.x,
        landingConfig.position.y,
        landingConfig.position.z,
        landingConfig.rotation.x,
        landingConfig.rotation.y,
        landingConfig.rotation.z
    )

    RegisterEntityForCutscene(PlayerPedId(), "MP_1", 3, GetHashKey("MP_1"), landingConfig.playerFlags or 64)
    
    return true
end

local function StartTravel(fromId, toId)
    if State.isTraveling then return end
    
    local toAirport = Config.Locations[toId]
    if not toAirport then return end
    
    State.isTraveling = true
    
    DoScreenFadeOut(1000)
    Wait(1000)

    local success = StartLandingSequence(toAirport)
    
    if not success then
        local spawn = toAirport.playerSpawn
        SetEntityCoords(PlayerPedId(), spawn.x, spawn.y, spawn.z)
        SetEntityHeading(PlayerPedId(), spawn.w)
        DoScreenFadeIn(1000)
        State.isTraveling = false
        QBCore.Functions.Notify("Welcome to " .. toAirport.name, "success")
        return
    end

    StartCutscene(0)
    DoScreenFadeIn(1000)
    
    CreateThread(function()
        Wait(toAirport.landingConfig.duration)
        
        if IsCutsceneActive() then
            DoScreenFadeOut(1000)
            Wait(1000)
            
            StopCutsceneImmediately()
            RemoveCutscene()
            
            Wait(2000)
            
            local spawn = toAirport.playerSpawn
            local playerPed = PlayerPedId()
            SetEntityCoords(playerPed, spawn.x, spawn.y, spawn.z)
            SetEntityHeading(playerPed, spawn.w)
            
            Wait(1000)
            DoScreenFadeIn(1000)
            
            QBCore.Functions.Notify("Welcome to " .. toAirport.name, "success")
            State.isTraveling = false
        end
    end)
end

RegisterNetEvent('plane-travel:showDestinations')
AddEventHandler('plane-travel:showDestinations', function(data)
    if State.isTraveling then return end
    
    local currentAirport = data.airport
    local destinations = {}
    
    for id, config in pairs(Config.Locations) do
        if id ~= currentAirport then
            table.insert(destinations, {
                header = config.name,
                txt = ("Flight Cost: $%d"):format(Config.TravelCost),
                params = {
                    event = "plane-travel:startTravel",
                    args = {
                        from = currentAirport,
                        to = id
                    }
                }
            })
        end
    end
    
    exports['qb-menu']:openMenu(destinations)
end)

RegisterNetEvent('plane-travel:startTravel')
AddEventHandler('plane-travel:startTravel', function(data)
    if State.isTraveling then return end
    
    local Player = QBCore.Functions.GetPlayerData()
    if Player.money.cash >= Config.TravelCost then
        TriggerServerEvent('plane-travel:removeMoney', Config.TravelCost)
        StartTravel(data.from, data.to)
    else
        QBCore.Functions.Notify("Insufficient funds for this flight!", "error")
    end
end)

if Config.Debug then
    RegisterCommand('testflight', function(_, args)
        local toAirport = args[1]
        if not toAirport or not Config.Locations[toAirport] then
            QBCore.Functions.Notify("Invalid airport ID", "error")
            return
        end
        StartTravel('los_santos', toAirport)
    end)
    
    RegisterCommand('getposdetailed', function()
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local heading = GetEntityHeading(playerPed)
        print('Position Info:')
        print(string.format('position = vector3(%s, %s, %s),', coords.x, coords.y, coords.z))
        print(string.format('rotation = vector3(0.0, 0.0, %s),', heading))
    end)
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    for _, plane in pairs(State.planes) do
        if DoesEntityExist(plane) then
            DeleteEntity(plane)
        end
    end
end)