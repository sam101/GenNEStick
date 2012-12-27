-- Game file for handling the various entities
require('conf')
require('colors')
entity = {}

-- Builds a new entity, with a specific owner
function entity:new(owner,x,y)
	--Builds the entity object
	local o = {}
	o.owner = owner
	o.x = x
	o.y = y
	o.code = {}
	-- Builds the genetic code of the entity randomly
	for i = 0, 5 * 4 * 4 + 5 * 4 + 4 - 1 do
		o.code[i] = math.random(0,1)
	end
	
	setmetatable(o, self)
	self.__index = self
	return o
	
end 

-- Draws an entity
function entity:draw()
	local color, baseIndex, ts, reduction
	ts = config.tileSize / 4
	reduction = config.reduction
	-- Draw the contents
	for i = 0, 3 do
		for j = 0, 3 do
			baseIndex = i * 5 * 4 + j * 4
			color = self.code[baseIndex] * 32 + self.code[baseIndex + 1] * 16 + 
			self.code[baseIndex + 2] * 8 + self.code[baseIndex + 3] * 4 +
			self.code[baseIndex + 4] * 2 + self.code[baseIndex + 5] + 1
			love.graphics.setColor(colors[color])
			love.graphics.rectangle('fill', self.x * config.tileSize + i * ts, (self.y + 1) * config.tileSize + j * ts, ts, ts) 
		end
	end
	-- Draw the corner
	love.graphics.setColor(colors[self.owner])
	love.graphics.rectangle('fill',self.x * config.tileSize, (self.y + 1) * config.tileSize, 
		config.tileSize, ts / reduction)	
	love.graphics.rectangle('fill',self.x * config.tileSize, (self.y + 1) * config.tileSize, 
		 ts / reduction,config.tileSize)	
	love.graphics.rectangle('fill',self.x * config.tileSize, 
		(self.y + 1) * config.tileSize + config.tileSize - ts / reduction, 
		config.tileSize, ts / reduction)	
	love.graphics.rectangle('fill',self.x * config.tileSize + config.tileSize - ts / reduction, 
		(self.y + 1) * config.tileSize, 
		ts / reduction, config.tileSize)	
end