--[[ ===================================================== ]]--
--[[          QBCore JumpScare Script by MaDHouSe          ]]--
--[[ ===================================================== ]]--

Config = {}

Config.DebugPoly = false

Config.JumpScarePeds = {
    [1] = {
        ped = "csb_reporter",
        label = "Goodies",
        coords = vector4(-553.5886, -618.5695, 34.6767, 186.4352),
        event = "qb-jumpscares:client:jumpscareplayer",
    },
    [2] = {
        ped = "csb_reporter",
        label = "Key Shop",
        coords = vector4(214.7049, -806.7850, 30.8064, 341.8014),
        event = "qb-jumpscares:client:jumpscareplayer",
    }
}

-- you can download my mh-polycreator at: https://github.com/MaDHouSe79/mh-polycreator
-- you can create zones very easy and precise with `mh-polycreator`
Config.JumpScareZones = { 
    ['1'] = {
        ['vectors'] = {
            vector2(-1563.82, 236.33),
            vector2(-1605.81, 216.93),
            vector2(-1588.91, 180.56),
            vector2(-1546.97, 200.11),
            vector2(-1563.82, 236.33),
        },
        ['coords'] = vector3(-1580.59, 203.81, 61.65),
        ['name'] = 'Een Geheim',
        ['showBlip'] = true,
        ['blipSprite'] = 465,
        ['blipScale'] = 1.0,
    },
}