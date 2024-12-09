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
	LIB = {}
	LogMessage("info", "Loaded libraries")
	PLAYER = require("src.player")
	LogMessage("trace", "Created PLAYER")
end

function love.update(dt) end

function love.draw()
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
	add_to_hist = add_to_hist or false
	if add_to_hist then
		LOG_HISTORY[#LOG_HISTORY + 1] = {
			type = type,
			msg = msg,
		}
	end
	return UTILS.DEBUG[type](msg)
end
