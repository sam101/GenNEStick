-- File for handling a flag set by the player
flag = {x = 0, y = 0}
-- Builds a new flag
function flag:new()
	local o = {x = 0, y = 0}

	setmetatable(o, self)
	self.__index = self

	return o
end