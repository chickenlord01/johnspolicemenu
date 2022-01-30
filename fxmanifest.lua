fx_version 'cerulean'
game 'gta5'

name 'johnspolicemenu'
description 'Police Menu for Menu servers'
version '1.0.0'
url 'https://github.com/chickenlord01/johnspolicemenu'
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