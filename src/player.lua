---@class player
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
		r = 1,
		g = 1,
		b = 1,
		a = 1,
	},
}

return player
