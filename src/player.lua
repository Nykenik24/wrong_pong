---@class player
---@field x integer x pos
---@field y integer y pos
---@field w integer width
---@field h integer height
---@field color color color
---@field vx integer horizontal velocity
---@field vy integer vertical velocity
---@field speed integer speed
local player = {
	x = 0,
  vx = 0,
	y = 0,
  vy = 0,
  speed = 300,
	w = 50,
	h = 50,
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
