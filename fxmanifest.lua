fx_version 'cerulean'
game 'gta5'

description 'qb-tequilala'

author ''

version '2.0.0'

client_scripts {
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'config.lua',
	'client/main.lua',
	'client/garage.lua',
}

server_scripts {
    'server/main.lua',
	'config.lua',
}

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}