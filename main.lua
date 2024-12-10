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

  local walls = {
    top = {
      x = 0,
      y = -25,
      w = love.graphics.getWidth(),
      h = 25
    },
    bottom = {
      x = 0,
      y = love.graphics.getHeight(),
      w = love.graphics.getWidth(),
      h = 25
    },
    right = {
      x = love.graphics.getWidth(),
      y = 0,
      w = 25,
      h = love.graphics.getHeight()
    },
    left = {
      x = -25,
      y = 0,
      w = 25,
      h = love.graphics.getHeight()
    }
  }
  for i, wall in pairs(walls) do
    LogMessage("trace", ("Created %s wall"):format(i))
    WORLD:add(wall, wall.x, wall.y, wall.w, wall.h)
  end
end

function love.update(dt)
  local goalX, goalY = PLAYER.x + (PLAYER.speed * PLAYER.vx) * dt, PLAYER.y + (PLAYER.speed * PLAYER.vy) * dt
  PLAYER.x, PLAYER.y = WORLD:move(PLAYER, goalX, goalY)

  PLAYER.vx = 0
  PLAYER.vy = 0
  local keystates = {
    up = love.keyboard.isDown('w'),
    down = love.keyboard.isDown('s'),
    left = love.keyboard.isDown('a'),
    right = love.keyboard.isDown('d')
  }
  if PLAYER.move_x then
    LogMessage("info", "X not locked")
    if keystates.right then
      PLAYER.vx = 1
    elseif keystates.left then
      PLAYER.vx = -1
    end
  end

  if PLAYER.move_y then
    if keystates.up  then
      PLAYER.vy = -1
    elseif keystates.down then
      PLAYER.vy = 1
    end
  end
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

---Log a message
---@param type string Log type (default: "regular")
---@param msg string Message
---@param add_to_hist? boolean Log the message
---@return unknown
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
