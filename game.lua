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
	-- Generate the fittest element
	self.fittest = entity:new(1,width - 1,-1)	
	--Add entities to the map
	self.entities = {}
	local entitiesNumber = math.random(3,25)
	for i = 0, entitiesNumber do
		local x, y
		repeat
			x = math.random(0, width - 1)
			y = math.random(0, height - 1)
		until self:find(x,y) == nil
		table.insert(self.entities,entity:new(1,x,y))
	end
		
	-- Sets the counter of the game
	self.counter = 0
end
-- Called every tick of the game
function game:tick()
	self.counter = self.counter + 1
	-- Let the entities do their life
	for i, v in ipairs(self.entities) do
		v:tick()
	end
	-- Kill the entities 
	game:kill()
end
-- Kills a certain number of entities according to their fitness
function game:kill()
	-- Kill according to their fitness and if they have too much neighbors
	for i,v in ipairs(self.entities) do
		print(i,game:fitness(v),game:killNumber(v),table.getn(self.entities))
		if math.random(1,game:killNumber(v)) == 1 then
		    print("Killing entity number ",i)
			table.remove(self.entities,i)
		end		
	end	
end
-- Calculates the chance to be killed for a given entity
-- It should be in function of it fitness/number of entities in the game, etc.
function game:killNumber(entity)
	return math.floor(math.pow(1.2,game:fitness(entity))) / math.floor(math.pow(1.2,table.getn(game.entities)))
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
-- Returns if a given position is empty in the game space
function game:empty(x,y)
	if x < 0 or y < 0 or x >= self.width or y >= self.height then
		return false
	end
	return game:find(x,y) == nil
end
-- Add an entity to the game
function game:add(entity)
	if entity ~= nil then
		table.insert(self.entities,entity)
		print("Adding new entity to the game at position",entity.x,entity.y,self:fitness(entity))
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
	--Draw the game entities
	for i, v in ipairs(self.entities) do
		v:draw()
	end
	-- Draw the fittest
	self.fittest:draw()
end
-- Calculate the fitness of an entity
function game:fitness(entity)
	local fitness = 0
	
	for i = 0, 80 do
		if entity.code[i] == self.fittest.code[i] then
			fitness = fitness + 1
		end
	end
	
	return fitness
	
end
print('Game module loaded.')