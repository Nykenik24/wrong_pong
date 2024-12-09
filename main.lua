---@diagnostic disable: duplicate-set-field

function love.load()
	UTILS = {
		DEBUG = require("src.utils.debug"),
		TIMER = require("src.utils.timer"),
		CLASS = require("src.utils.class"),
	}
	LogMessage("info", "Loaded utils")
	LOG_HISTORY = {}
	LogMessage("trace", "Created LOG_HISTORY")
	require("init")()
	LogMessage("info", 'Runned "init.lua"')
	LIB = {
		bump = require("lib.bump.bump"),
	}
	LogMessage("info", "Loaded libraries")

	WORLD = LIB.bump.newWorld()
	LogMessage("trace", "Created WORLD")
	PLAYER = require("src.player")
	LogMessage("trace", "Created PLAYER")
	WORLD:add(PLAYER, PLAYER.x, PLAYER.y, PLAYER.w, PLAYER.h)
	LogMessage("trace", "Added PLAYER to WORLD")
end

function love.update(dt)
  local goalX, goalY = PLAYER.x + (PLAYER.speed * PLAYER.vx) * dt, PLAYER.y + (PLAYER.speed * PLAYER.vy) * dt
  PLAYER.x, PLAYER.y = WORLD:move(PLAYER, goalX, goalY)
end

function love.draw()
	SetColor(PLAYER.color)
	love.graphics.rectangle("fill", PLAYER.x, PLAYER.y, PLAYER.w, PLAYER.h)
end

function love.keypressed(key)
	local function setKey(new_key, action)
		if key == new_key then
			action()
		end
	end

	setKey("escape", love.event.quit)
	setKey("f1", function()
		love.event.quit("restart")
	end)
end

function LogMessage(type, msg, add_to_hist)
	type = type or "regular"
	add_to_hist = add_to_hist or false
	if add_to_hist then
		LOG_HISTORY[#LOG_HISTORY + 1] = {
			type = type,
			msg = msg,
		}
	end
	return UTILS.DEBUG[type](msg)
end

---Set color
---@param color color
function SetColor(color)
	color.a = color.a or 1
	love.graphics.setColor(color.r, color.g, color.b, color.a)
end
