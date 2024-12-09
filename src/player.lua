---@class player
---@field x integer x pos
---@field y integer y pos
---@field w integer width
---@field h integer height
---@field color color color
local player = {
	x = 0,
	y = 0,
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
