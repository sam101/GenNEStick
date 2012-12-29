-- Main file for the game
require('game')
require('colors')
-- Called when the game has to be loaded
function love.load()
	print('Welcome to GenNEStick !')
	--Sets the graphic mode
	--Load the font of the game
	font = love.graphics.newFont("nintendo_nes_font.ttf",config.tileSize / 2)
	love.graphics.setFont(font)
	love.graphics.setBackgroundColor(0,0,0)
	-- Sets the current timer
	timer = 0
	ticks = 0
	ticksInterval = config.ticks
	-- Inits the game object
	game:init(config.gameWidth,config.gameHeight)
end
-- Update the current game state
function love.update(dt)
	if love.keyboard.isDown("p") then
		ticksInterval = ticksInterval + dt * 1000
		if ticksInterval < 0 then
			ticksInterval = 0
		end
	elseif love.keyboard.isDown("m") then
		ticksInterval = ticksInterval - dt * 1000
		if ticksInterval < 0 then
			ticksInterval = 0
		end
	end
	timer = timer + dt
	-- Make a tick every 1 second.	
	if timer > ticksInterval / 1000 then
		timer = 0
		ticks = ticks + 1
		-- Call the update method of the game
		game:tick()	
	end
end
-- Called when a key is pressed
function love.keypressed(key, unicode)
	game:keypressed(key, unicode)
end
-- Called when the mouse is pressed
function love.mousepressed(x, y, button)
	game:mousepressed(x,y,button)
end
-- Draw the various elements of the game
function love.draw()
	--Draw the game object
	game:draw()
end