-- File for handling a flag set by the player
require('colors')

flag = {x = 0, y = 0}
-- Builds a new flag
function flag:new(x,y)
	local o = {visible = false}
	o.x = x
	o.y = y
	
	setmetatable(o, self)
	self.__index = self

	return o
end
-- Draw the flag
function flag:draw()
	if self.visible == true then
		love.graphics.setColor(colors[33])
		love.graphics.rectangle('fill', (self.x + 0.25) * config.tileSize, (self.y + 0.25) * config.tileSize, config.tileSize / 2, 
								config.tileSize / 2)
	end
end