local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('plane-travel:removeMoney')
AddEventHandler('plane-travel:removeMoney', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player then
        Player.Functions.RemoveMoney('cash', amount)
    end
end)