local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add("jumpscare", "", {}, false, function(source)
    local timer = math.random(15000, 20000)
    Wait(timer)
    TriggerClientEvent("qb-jumpscares:client:jumpscareholeserver", -1)
end, 'admin')

QBCore.Commands.Add("jumpscareplayer", "", {}, false, function(source, args)
    if args[1] and tonumber(args[1]) > 0 then
        local id = tonumber(args[1])
        local timer = math.random(15000, 20000)
        Wait(timer)
        TriggerClientEvent("qb-jumpscares:client:jumpscareplayer", id)
    end
end, 'admin')