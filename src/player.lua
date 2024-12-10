local player = {
	x = 25,
  vx = 0,
  move_x = false,
	y = 25,
  vy = 0,
  move_y = true,
  speed = 400,
	w = 40,
	h = 100,
	---@class color
	---@field r integer red
	---@field g integer green
	---@field b integer blue
	---@field a integer alpha
	color = {
		r = 0.25,
		g = 0.25,
		b = 0.75,
		a = 1,
	},
  type = "player",
  draw = function(self)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
  end,
  init = function(self)
    WORLD:add(self, self.x, self.y, self.w, self.h)
  end
}

return player
