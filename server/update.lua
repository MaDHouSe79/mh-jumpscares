--[[ ===================================================== ]]--
--[[          QBCore JumpScare Script by MaDHouSe          ]]--
--[[ ===================================================== ]]--

local script = GetCurrentResourceName()
local txt

local function checkVersion(err, responseText, headers)
    curVersion = LoadResourceFile(script, "version")
    if responseText == nil then
        print("[^6"..script.."^7] Check for script update ^1FAILED^7")
        return
    end
    if curVersion ~= responseText and tonumber(curVersion) < tonumber(responseText) then
        updateavail = true
        print("^1----------------------------------------------------------------------------------^7")
        print(script.." is outdated, latest version is: ^2"..responseText.."^7, installed version: ^1"..curVersion.."^7!\nupdate from https://github.com/MaDHouSe79/"..script.."")
        print("^1----------------------------------------------------------------------------------^7")
    elseif tonumber(curVersion) > tonumber(responseText) then
        print("^3----------------------------------------------------------------------------------^7")
        print(script.." git version is: ^2"..responseText.."^7, installed version: ^1"..curVersion.."^7!")
        print("^3----------------------------------------------------------------------------------^7")
    else
        print(script.." is up to date. (^2"..curVersion.."^7)")
    end
end

Citizen.CreateThread( function()
    PerformHttpRequest("https://raw.githubusercontent.com".."/MaDHouSe79/"..script.."/master/version", checkVersion, "GET")
end)