-- Hides the status bar
display.setStatusBar(display.HiddenStatusBar)



--------------------------------------------------------------------------------------
-- Global contsts
--------------------------------------------------------------------------------------
Global = {
	screenHeight = display.viewableContentHeight,
	screenWidth  = display.viewableContentWidth, 
	extraX = math.abs(display.screenOriginX),
	extraY = math.abs(display.screenOriginY)
}
local totalScreenWidth = Global.screenWidth + 2*Global.extraX
local totalScreenHeight = Global.screenHeight + 2*Global.extraY
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------




--------------------------------------------------------------------------------------
-- Global requirements/implementations
-- Add new libraries here..
--------------------------------------------------------------------------------------
local physics = require("physics")
physics.start()
physics.setGravity(0, 0)
--physics.setDrawMode( "hybrid" )
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------




--------------------------------------------------------------------------------------
-- Global definitions and setup (load strings, database, fonts, audio, etc..)
--------------------------------------------------------------------------------------
local bcg = display.newRect(Global.screenWidth*.5, Global.screenHeight*.5, totalScreenWidth, totalScreenHeight)
bcg:setFillColor(1, 1, 1)
bcg:toBack()

local forceTxt
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------




--------------------------------------------------------------------------------------
-- All kinds of functs..
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------






--------------------------------------------------------------------------------------
-- Listeners..
--------------------------------------------------------------------------------------
local function onLocalPostCollision(self, event)
	local collideObject = event.other

	if(event.force ~= 0) then
		forceTxt.text = forceTxt.text .. string.format("%.3f", event.force)
		-- Play audio and set its volume according to the event force value.
	end
end
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------
-- UI
--------------------------------------------------------------------------------------
local character = display.newCircle(Global.screenWidth*.5, Global.screenHeight*.5 - 100, 30)
character:setFillColor(0.8, 0.6, 0.3)
character:toFront()

physics.addBody(character, "dynamic", {bounce = 0.1, radius = 30,})

character.postCollision = onLocalPostCollision
character:addEventListener("postCollision")

local ball = display.newCircle(character.x, character.y + 200, 20)
ball:setFillColor(0, 0, 1)

physics.addBody(ball, "dynamic", {bounce = 0.3, radius = 20})


forceTxt = display.newText("Force: ", Global.screenWidth*.5, Global.screenHeight + Global.extraY - 30, native.systemFont, 20)
forceTxt:setFillColor(0)


timer.performWithDelay(2000, 
	function()
		local xForce = math.random(0, 1)
		local yForce = math.random(10, 30)
		local xDirection
		if (math.random(1, 2) == 1) then 
			xDirection = -1 
		else 
			xDirection = 1 
		end
		ball:applyForce(xForce*xDirection, -yForce, ball.x, ball.y)
	end
, 1)




