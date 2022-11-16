--[[ ===================================================== ]]--
--[[          QBCore JumpScare Script by MaDHouSe          ]]--
--[[ ===================================================== ]]--

local QBCore = exports['qb-core']:GetCoreObject()
local zones = {}
local active = false
local firsttime = true
local isAlreadyScared = false
local pedSpawned = false
local JumpPed = {}

local function JumpByPed()
    TriggerEvent("qb-jumpscares:client:openNUI", src, true)
    Wait(1000)
    TriggerEvent("qb-jumpscares:client:closeNUI", src, false)
end

local function createPeds()
    if pedSpawned then return end
    for k, v in pairs(Config.JumpScarePeds) do
        if not JumpPed[k] then JumpPed[k] = {} end
        local current = v.ped
        current = type(current) == 'string' and GetHashKey(current) or current
        RequestModel(current)
        while not HasModelLoaded(current) do
            Wait(0)
        end
        JumpPed[k] = CreatePed(0, current, v.coords.x, v.coords.y, v.coords.z - 1, v.coords.w, false, false)
        TaskStartScenarioInPlace(JumpPed[k], "WORLD_HUMAN_STAND_MOBILE", true)
        FreezeEntityPosition(JumpPed[k], true)
        SetEntityInvincible(JumpPed[k], true)
        SetBlockingOfNonTemporaryEvents(JumpPed[k], true)
        exports['qb-target']:AddTargetEntity(JumpPed[k], {
            options = {
                {
                    label = v.label,
                    icon = "fas fa-shopping-basket",
                    action = function()
                        JumpByPed()
                    end
                }
            },
            distance = 2.0
        })
    end
    pedSpawned = true
end

local function deletePeds()
    if pedSpawned then
        for k, v in pairs(ShopPed) do
            DeletePed(v)
        end
    end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    createPeds()
end)

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
    Wait(math.random(3000, 7000))
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "hello", 0.5)
    Wait(math.random(10000, 13000))
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "findme", 0.5)
    if not isAlreadyScared then
        isAlreadyScared = true
        Wait(math.random(20000, 25000))
        TriggerEvent("qb-jumpscares:client:openNUI", src, true)
        Wait(1000)
        TriggerEvent("qb-jumpscares:client:closeNUI", src, false)
    end
end)

for k, v in pairs(Config.JumpScareZones) do
    zones[#zones + 1] = PolyZone:Create({table.unpack(v.vectors)}, {name = v.name})
    zones[#zones + 1] = zone
end
combo = ComboZone:Create(zones, { name = "jumpscareCombo", debugPoly = Config.DebugPoly })

CreateThread(function()
    Wait(1000)
    while true do
        if LocalPlayer.state.isLoggedIn then
            local pos = GetEntityCoords(PlayerPedId())
            local isPointInside = combo:isPointInside(pos)
            if isPointInside then
                if not active then
                    active = true
                    TriggerEvent('qb-jumpscares:client:enterzone', PlayerPedId())
                end
            else
                if active then
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
        isAlreadySaidHello = false
        isAlreadySaidFindme = false
        firsttime = true
        deletePeds()
        createPeds()
    end 
end)