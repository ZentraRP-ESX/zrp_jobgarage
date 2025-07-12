fx_version 'cerulean'
game 'gta5'

author 'Omega Scripts'
description 'esx_policegarage'
version '2.3.0'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'client/main.lua',
    'client/menu.lua',
    'client/target.lua'
}

server_script 'server/server.lua'

dependencies {
    'es_extended',
    'ox_lib',
    'ox_inventory'
}
