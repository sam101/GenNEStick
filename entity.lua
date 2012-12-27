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
	o.direction = math.random(0,3)
	o.code = {}
	-- Builds the genetic code of the entity randomly
	for i = 0, 80 do
		o.code[i] = math.random(0,1)
	end
	
	setmetatable(o, self)
	self.__index = self
	return o
	
end 
-- Called at every tick, do stuff with the entity
function entity:tick()
	self:move()
	self:mutate()
end

-- Draws an entity
function entity:draw()
	local color, baseIndex, ts, reduction
	ts = config.tileSize / 4
	reduction = config.reduction
	-- Draw the contents
	for i = 0, 3 do
		for j = 0, 3 do
			baseIndex = i * 5 * 4 + j * 5
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
-- Move the entity
function entity:move()
	-- Change randomly the direction
	if math.random(0,5) == 4 then
		self:changeDirection()
	else
		-- Change the direction if we can't move
		if not(self:moveTo(self.direction)) then
			self.direction = 3 - self.direction
		end
	end
end
-- Mutates the entity
function entity:mutate()
	if math.random(0,config.chanceToMutate) == 1 then
		local toModify = math.random(0,80)
		if self.code[toModify] == 1 then
			self.code[toModify] = 0
		else
			self.code[toModify] = 1
		end
	end
end
function entity:changeDirection()
	local trials = 5
	-- Change the direction of the entity
	repeat
		direction = math.random(0,3)
		trials = trials + 1
	until self:moveTo(direction) or trials > 5
	self.direction = direction
end
-- Tries to move the entity into a direction, returns true
-- if it succedded, false otherwise
function entity:moveTo(direction)
	local moveX = 0
	local moveY = 0
	
	if direction == 0 then
		moveX = 1
	elseif direction == 3 then
		moveX = -1
	elseif direction == 1 then
		moveY = 1
	elseif direction == 2 then
		moveY = -1
	end
	if game:empty(self.x + moveX, self.y + moveY) 
	   and (self.x + moveX) >= 0 
	   and (self.y + moveY) >= 0
	   and (self.x + moveX) < game.width 
	   and (self.y + moveY) < game.height then
	   
		self.x = self.x + moveX
		self.y = self.y + moveY
		return true
	else
		return false
	end
end