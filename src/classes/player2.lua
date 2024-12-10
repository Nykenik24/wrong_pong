local class_syst = require("src.utils.class")

return class_syst({
	x = 0,
	y = 0,
	w = 40,
	h = 100,
	vx = 0,
	vy = 0,
	speed = 400,
	---@type color
	color = {
		r = 0.75,
		g = 0.25,
		b = 0.25,
		a = 1,
	},
	type = "player 2",
	draw = function(self)
		love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
	end,
	init = function(self)
		WORLD:add(self, self.x, self.y, self.w, self.h)
	end,
	setX = function(self, new_x)
		self.x = new_x
	end,
	setY = function(self, new_y)
		self.y = new_y
	end,
	setHorizontalVelocity = function(self, new_vx)
		self.vx = new_vx
	end,
	setVerticalVelocity = function(self, new_vy)
		self.vy = new_vy
	end,
	setSpeed = function(self, new_speed)
		self.speed = new_speed
	end,
	getX = function(self)
		return self.x
	end,
	getY = function(self)
		return self.y
	end,
	getHorizontalVelocity = function(self)
		return self.vx
	end,
	getVerticalVelocity = function(self)
		return self.vy
	end,
	getSpeed = function(self)
		return self.speed
	end,
	setWidth = function(self, new_w)
		self.w = new_w
	end,
	setHeight = function(self, new_h)
		self.h = new_h
	end,
	getWidth = function(self)
		return self.w
	end,
	getHeight = function(self)
		return self.h
	end,
}, {})
