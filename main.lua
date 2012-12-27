-- Main file for the game
require('game')
require('colors')
-- Called when the game has to be loaded
function love.load()
	print('Welcome to GenNEStick !')
	--Sets the graphic mode
	--Load the font of the game
	font = love.graphics.newFont("nintendo_nes_font.ttf",16)
	love.graphics.setFont(font)
	love.graphics.setBackgroundColor(0,0,0)
	-- Sets the current timer
	timer = 0
	ticks = 0
	-- Inits the game object
	game:init(32,27)
end
-- Update the current game state
function love.update(dt)
	timer = timer + dt
	-- Make a tick every 0.1 second.	
	if timer > 0.1 then
		timer = 0
		ticks = ticks + 1
		-- Call the 
		
	end
end
-- Draw the various elements of the game
function love.draw()
	--Draw the game object
	game:draw()
	--Draw the "test" text
	love.graphics.setColor(colors[33])
	love.graphics.print("GenNEStick." .. ticks,0,0)
end