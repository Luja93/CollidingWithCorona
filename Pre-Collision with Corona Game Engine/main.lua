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
physics = require("physics")
physics.start()
physics.setGravity(0, 30)
--physics.setDrawMode( "hybrid" )
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------




--------------------------------------------------------------------------------------
-- Global definitions and setup (load strings, database, fonts, audio, etc..)
--------------------------------------------------------------------------------------
bcg = display.newRect(Global.screenWidth*.5, Global.screenHeight*.5, totalScreenWidth, totalScreenHeight)
bcg:setFillColor(1, 1, 1)
bcg:toBack()
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------




--------------------------------------------------------------------------------------
-- Functs..
--------------------------------------------------------------------------------------
local function performSplashAnimation(view)
	transition.to(view, {yScale = 0.7, xScale = 1.1, time = 75})
	transition.to(view, {yScale = 1, xScale = 1, time = 75, delay = 75})
end
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------




--------------------------------------------------------------------------------------
-- Listeners..
--------------------------------------------------------------------------------------
local function onLocalPreCollision(self, event)
	local collideObject = event.other
	if (collideObject.id == "platform" and collideObject.y <= self.y) then
		-- Disable this specific collision since character is below the platform.
		event.contact.isEnabled = false
	elseif (collideObject.id == "platform" and collideObject.y > self.y) then
		-- Enable the collision and bounce character of the platform.
		--event.contact.isEnabled = true
		-- If object is falling down, apply linear impulse to it and push it into the air.
		local vx, vy = self:getLinearVelocity()
		if (vy > 0) then 
			self:setLinearVelocity(0, 0)
			self:applyLinearImpulse(0, -0.7, self.x, self.y)
			performSplashAnimation(self)
		end
	end
end
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------
-- UI
--------------------------------------------------------------------------------------
local platformWidth = 100
local platformHeight = 20

local platform1 = display.newRoundedRect(Global.screenWidth*.5, Global.screenHeight + Global.extraY - 15, platformWidth, platformHeight, 10)
platform1.id = "platform"
platform1:setFillColor(0.35)
local platform2 = display.newRoundedRect(Global.screenWidth*.5, platform1.y - 160, platformWidth, platformHeight, 10)
platform2.id = "platform"
platform2:setFillColor(0.35)
local platform3 = display.newRoundedRect(Global.screenWidth*.5, platform2.y - 160, platformWidth, platformHeight, 10)
platform3.id = "platform"
platform3:setFillColor(0.35)
local platform4 = display.newRoundedRect(Global.screenWidth*.5, platform3.y - 160, platformWidth, platformHeight, 10)
platform4.id = "platform"
platform4:setFillColor(0.35)

physics.addBody(platform1, "static")
physics.addBody(platform2, "static")
physics.addBody(platform3, "static")
physics.addBody(platform4, "static")

local character = display.newCircle(platform1.x, platform1.y - platform1.height*.5, 30)
character.anchorY = 1
character:setFillColor(0.95, 0.4, 0.3)
character:toFront()

physics.addBody(character, "dynamic", {bounce = 0, friction = 0, radius = 30})

character.preCollision = onLocalPreCollision
character:addEventListener("preCollision")

timer.performWithDelay(2000, function() character:applyLinearImpulse(0, -0.7, character.x, character.y) end, 1)




