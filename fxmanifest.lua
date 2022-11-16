fx_version 'cerulean'
game 'gta5'

author "MaDHouSe"
description "MH Jumpscares - to scare your players ;)"
version "1.0"

shared_scripts {
    'config.lua'
}

client_scripts {
    '@PolyZone/client.lua',
	'@PolyZone/ComboZone.lua',
    'client/main.lua'
}

server_scripts {
    'server/main.lua',
    'server/update.lua',
}

ui_page('html/index.html')

files {
    'html/assets/css/*.css',
    'html/assets/js/*.js',
    'html/assets/sounds/*.ogg',
    'html/index.html',
}
