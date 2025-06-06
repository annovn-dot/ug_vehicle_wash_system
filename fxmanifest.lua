fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'BOGi'
name "Vehicle wash system"
description 'The Underground - Vehicle wash system'
version '4.2.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config/cfg_settings.lua'
}

client_scripts {
    'client/cl_cloth_wash.lua',
    'client/cl_car_wash.lua'
}

server_scripts {
    'server/sv_cloth_wash.lua'
}
