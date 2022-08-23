local QBCore = exports['qb-core']:GetCoreObject()
local zones = {}
local active = false
local firsttime = true
local isAlreadyScared = false

RegisterNetEvent("qb-jumpscares:client:openNUI", function(display)
    SendNUIMessage({type = "ui", display = true})
end)

RegisterNetEvent("qb-jumpscares:client:closeNUI", function(display)
    SendNUIMessage({type = "ui", display = false})
end)

RegisterNetEvent('qb-jumpscares:client:jumpscareholeserver', function(source)
    local src = source
    TriggerEvent("qb-jumpscares:client:openNUI", src, true)
    Wait(1000)
    TriggerEvent("qb-jumpscares:client:closeNUI", src, false)
end)

RegisterNetEvent('qb-jumpscares:client:jumpscareplayer', function(source)
    local src = source
    TriggerEvent("qb-jumpscares:client:openNUI", src, true)
    Wait(1000)
    TriggerEvent("qb-jumpscares:client:closeNUI", src, false)
end)

RegisterNetEvent('qb-jumpscares:client:enterzone', function(source)
    local src = source
    local timer = math.random(10000, 20000)
    Wait(timer)
    TriggerEvent("qb-jumpscares:client:openNUI", src, true)
    Wait(1000)
    TriggerEvent("qb-jumpscares:client:closeNUI", src, false)
end)

for k, v in pairs(Config.JumpScareZones) do
    zones[#zones + 1] = PolyZone:Create({table.unpack(v.vectors)}, {name = v.name})
end
combo = ComboZone:Create(zones, {name = "jumpscareCombo", debugPoly = Config.DebugPoly})

CreateThread(function()
    Wait(1000)
    while true do
        if LocalPlayer.state.isLoggedIn then
            local pos = GetEntityCoords(PlayerPedId())
            local isPointInside = combo:isPointInside(pos)
            if isPointInside then
                if not active then
                    active = true
                    if not isAlreadyScared and firsttime then
                        isAlreadyScared = true
                        TriggerEvent('qb-jumpscares:client:enterzone', PlayerPedId())
                    end
                end
            else
                if active then
                    firsttime = false
                    active = false
                end
            end
        end
        Wait(3000)
    end
end)

CreateThread(function()
    for k, v in pairs(Config.JumpScareZones) do
        if v.showBlip then
            local blip = AddBlipForCoord(v.coords)
            SetBlipSprite(blip, v.blipSprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, v.blipScale)
            SetBlipAsShortRange(blip, true)
            SetBlipColour(blip, 3)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(v.name)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        TriggerEvent('chat:removeSuggestion', '/jumpscare')
        TriggerEvent('chat:removeSuggestion', '/jumpscareplayer')
        isAlreadyScared = false
        firsttime = true
    end 
end)
