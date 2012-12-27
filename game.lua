-- Main file for the game mechanics.
require('colors')
require('conf')
require('entity')

game = {}
-- Game object initialisation
function game:init(width, height)
	self.width = width
	self.height = height
	--Build the game map
	self.map = {}
	for i = 0, width - 1 do
		self.map[i] = {}
		for j = 0, height - 1 do
			self.map[i][j] = 4 -- Purple color (found by inadvertance)
		end
	end
	--Add entities to the map
	self.entities = {}
	table.insert(self.entities,entity:new(1,0,0))
	-- Sets the counter of the game
	self.counter = 0
end
-- Called every tick of the game
function game:tick()
	-- Move the entities
end
-- Finds (or not) an entity at a given position
-- (Yes, its complexity is O(n), and that sucks)
function game:find(x,y)
	for i,v in ipairs(self.entities) do
		if v.x == x and v.y == y then
			return v
		end
	end
	return nil
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
	--Draw the game entities
	for i, v in ipairs(self.entities) do
		v:draw()
	end
end

print('Game module loaded.')