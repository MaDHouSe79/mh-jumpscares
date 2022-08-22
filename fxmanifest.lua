fx_version 'adamant'
game 'gta5'

description 'qb-jumpscares.'

client_scripts {
    '@PolyZone/client.lua',
	'@PolyZone/ComboZone.lua',
    'config.lua',
    'client.lua'
}

server_scripts {
    'config.lua',
    'server.lua', 
}

ui_page('html/index.html')

files {
    'html/listener.js',
    'html/style.css',
    'html/reset.css',
    'html/index.html',
    'html/yeet.ogg'
}
