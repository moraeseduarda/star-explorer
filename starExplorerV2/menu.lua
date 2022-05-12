
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function goToGame ()
	composer.gotoScene ("game")
end

local function goToRecordes ()
	composer.gotoScene ("recordes")
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- ocorre quando a cena é criada pela primeira vez mas ainda não aparecer na tela.

	local bg = display.newImageRect (sceneGroup, "imagens/bg.png", 800, 1400)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY

	local titulo = display.newImageRect (sceneGroup, "imagens/title.png", 500, 80)
	titulo.x = display.contentCenterX
	titulo.y = 200

	local botaoPlay = display.newText (sceneGroup, "Play", display.contentCenterX, 700, Arial, 60)
	botaoPlay:setFillColor (0.82, 0.86, 1)

	local botaoRecordes = display.newText (sceneGroup, "Recordes", display.contentCenterX, 810, Arial, 60)
	botaoRecordes:setFillColor (0.74, 0.78, 1)

	botaoPlay:addEventListener ("tap", goToGame)
	botaoRecordes:addEventListener ("tap", goToRecordes)

end


-- show()
		-- ocorre imediatamente antes e após a cena aparecer na tela.
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- o código aqui é executado quando a cena ainda está fora da tela (mas está prestes a entrar na tela)

	elseif ( phase == "did" ) then
		-- o código aqui é executado quando a cena está inteiramente na tela.
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- o código aqui é executado quando a cena está na tela (mas está prestes a sair da tela).

	elseif ( phase == "did" ) then
		-- o código aqui é executado imediatamente após a cena sair totalmente da tela.

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
