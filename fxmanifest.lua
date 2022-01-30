fx_version 'cerulean'
game 'gta5'

name 'johnspolicemenu'
description ''
version '0.0.1'
url ''
author 'JohnL#6869'

shared_scripts {
	'config/weapons.lua',
	'config/config.lua'
}

client_scripts {
	'warmenu.lua',
	'spikestrips/client.lua',
	'client.lua'
}

server_scripts {
	'spikestrips/server.lua',
	'server.lua'
}

dependencies {
	'dpemotes'
}