---@diagnostic disable: duplicate-set-field

function love.load()
	UTILS = {
		DEBUG = require("src.utils.debug"),
		TIMER = require("src.utils.timer"),
		CLASS = require("src.utils.class"),
	}
	LogMessage("info", "Loaded utils")
	require("init")()
  LogMessage("info", 'Runned "init.lua"')
	LOG_HISTORY = {}
  LogMessage("trace", "Created LOG_HISTORY", true)
end

function love.update(dt) end

function love.draw() end

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
      msg = msg
    }
	end
	return UTILS.DEBUG[type](msg)
end
