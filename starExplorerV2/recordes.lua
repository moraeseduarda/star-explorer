
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local json = require ("json") -- chama a biblioteca json no script.

local pontosTable = {}

local filePath = system.pathForFile ("pontos.json", system.DocumentsDirectory)

local function carregaPontos ()

	local pasta = io.open (filePath, "r") --  abre o arquivo pontos.json para somente leitura, apenas para confirmar que o arquivo existe.

	if pasta then 
		local contents = pasta:read ("*a")
		io.close (pasta)
		pontosTable = json.decode (contents)
end

	if (pontosTable == nil or #pontosTable == 0) then 
		pontosTable = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0} -- pontuações iniciais no recordes.

	end

end

local function salvaPontos ()
	for i = #pontosTable, 11, -1 do -- define que somente 10 pontuações serão salvas na tabela.
		table.remove (pontosTable, i)
	end

	local pasta = io.open (filePath, "w")

	if pasta then 
		pasta: write (json.encode(pontosTable))
		io.close (pasta)
	end
end

local function gotoMenu ()
	composer.gotoScene ("menu", {time=800, effect="crossFade"})
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	carregaPontos ()

	table.insert (pontosTable, composer.getVariable ("finalScore"))
	composer.setVariable ("finalScore", 0)

	local function compare ( a, b )
		return a > b 
	end
	table.sort (pontosTable, compare)

	salvaPontos ()

	local bg = display.newImageRect (sceneGroup, "imagens/bg.png", 800, 1400)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY

	local cabecalho = display.newText (sceneGroup, "Recordes", display.contentCenterX, 100, Arial, 120)

	for i = 1, 10 do
		if (pontosTable[1]) then 
			local yPos = 150 + (i * 56)

			local rankNum = display.newText (sceneGroup, i ..")", display.contentCenterX-50, yPos, Arial, 44)
			rankNum:setFillColor (0.8)
			rankNum.anchorX = 1

			local finalPontos = display.newText (sceneGroup, pontosTable[i], display.contentCenterX-30, yPos, Arial, 44)
			finalPontos.anchorX = 0	
		end
	end
		local botaoMenu = display.newText (sceneGroup, "Menu", display.contentCenterX, 810, Arial, 50)
		botaoMenu:setFillColor (0.75, 0.78, 1)
		botaoMenu:addEventListener ("tap", gotoMenu)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

		composer.removeScene ("recordes")

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
