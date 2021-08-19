-- Resource Metadata
fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'LSRP'
description 'qb-bahamas'
version '1.0.0'

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}

client_scripts {
    "config.lua",
    "client.lua",
    "gui.lua"
}

server_script 'server.lua'