-- Main file for the game mechanics.
require('colors')
require('conf')

game = {}
-- Game object initialisation
function game:init(width, height)
	self.width = width
	self.height = height
	
	self.map = {}
	
	for i = 0, width - 1 do
		self.map[i] = {}
		for j = 0, height - 1 do
			self.map[i][j] = 4 -- Purple color (found by inadvertance)
		end
	end
end

-- Drawing of the game objects
function game:draw()
	-- Draw the game map
	for i = 0, self.width - 1 do
		for j = 0, self.height - 1 do
			love.graphics.setColor(colors[self.map[i][j]])
			love.graphics.rectangle('fill',i * config.tileSize,(j + 1) * config.tileSize,config.tileSize,config.tileSize)
		end
	end
end

print('Game module loaded.')