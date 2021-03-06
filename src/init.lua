--! init.lua
--: Gotta get that real randomness
Socket = require 'socket'
math.randomseed(Socket.gettime()*1000)

--: Enums
builtins = {
    enum = require "builtins.enum"
}
enums = require 'modules.enums'

--: Libraries
tick = require 'libs.tick'
Object = require 'libs.classic'
json = require 'libs.json'
hex = require 'libs.hexmaniac'

--: Util doesn't use anything outside itself
Util = require 'modules.util'
--: Localization uses Util and enums
l10n = require 'modules.localization'
l10n:init('en-ca') -- At some point this will get pulled from a config file
--: Console uses Localization and Util
Console = require 'modules.console'

--: Debug
Debug = require 'modules.debug'
Debug:init({}, 'f5')
Console.log(l10n:getString('console.startup', { love.window.getTitle() }))

--: Assets
AssetManager = require 'assets.manager'
AssetManager:init('assets')

--: Objects
ObjectManager = require 'objects.manager'
ObjectManager:init('objects')
