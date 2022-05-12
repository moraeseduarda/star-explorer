-- carregar a biblioteca composer no script.
local composer = require ("composer")

display.setStatusBar (display.HiddenStatusBar)

math.randomseed (os.time())

-- cria o comando da cena Menu
composer.gotoScene ("menu")