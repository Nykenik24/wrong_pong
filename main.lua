---@diagnostic disable: duplicate-set-field

function love.load()
	-- ##################
	-- ## LOAD MODULES ##
	-- ##################

	-- # LOAD UTILS #
	UTILS = {
		DEBUG = require("src.utils.debug"),
		TIMER = require("src.utils.timer"),
		CLASS = require("src.utils.class"),
	}
	LogMessage("info", "Loaded utils")

	-- # CREATE LOG HISTORY #
	-- creating it here as i load the debug util also here
	LOG_HISTORY = {}
	LogMessage("trace", "Created LOG_HISTORY")

	-- # RUN "init.lua" FILE #
	require("init")()
	LogMessage("info", 'Runned "init.lua"')

	-- # LOAD LIBRARIES (1) #
	LIB = {
		bump = require("lib.bump.bump"),
	}
	LogMessage("info", "Loaded libraries")

	-- ####################
	-- ## WORLD & PLAYER ##
	-- ####################

	WORLD = LIB.bump.newWorld() --create world
	LogMessage("trace", "Created WORLD") --log
	PLAYER = require("src.player") --"create" player
	LogMessage("trace", "Created PLAYER") --log
	PLAYER:init() --add player to world
	LogMessage("trace", "Added PLAYER to WORLD") --log

	-- ##################
	-- ## CREATE WALLS ##
	-- ##################

	local walls = {
		top = {
			x = 0,
			y = -25,
			w = love.graphics.getWidth(),
			h = 25,
			type = "wall",
		},
		bottom = {
			x = 0,
			y = love.graphics.getHeight(),
			w = love.graphics.getWidth(),
			h = 25,
			type = "wall",
		},
		right = {
			x = love.graphics.getWidth(),
			y = 0,
			w = 25,
			h = love.graphics.getHeight(),
			type = "side wall",
		},
		left = {
			x = -25,
			y = 0,
			w = 25,
			h = love.graphics.getHeight(),
			type = "side wall",
		},
	}
	for i, wall in pairs(walls) do
		LogMessage("trace", ("Created %s wall"):format(i))
		WORLD:add(wall, wall.x, wall.y, wall.w, wall.h)
	end

	-- #############
	-- ## OBJECTS ##
	-- #############

	OBJECTS = {}
	OBJECTS.main_player2 = require("src.classes.player2"):new()
	OBJECTS.main_player2:setX(love.graphics.getWidth() - 65)
	OBJECTS.main_player2:setY(25)
	OBJECTS.main_player2:init()
	LogMessage("trace", 'created "main_player2" obj')

	OBJECTS.main_ball = require("src.classes.ball"):new()
	OBJECTS.main_ball:setX(love.graphics.getWidth() / 2)
	OBJECTS.main_ball:setY(love.graphics.getHeight() / 2)
	OBJECTS.main_ball:init()
	-- OBJECTS.main_ball:setHorizontalVelocity(-1)
	-- OBJECTS.main_ball:setVerticalVelocity(1)
	LogMessage("trace", 'created "main_ball" obj')

	OBJECTS.player = PLAYER
	LogMessage("trace", 'created "player" obj')

	-- ############
	-- ## OTHERS ##
	-- ############
	STARTED = false

	-- LogMessage("info", tostring(OBJECTS.main_ball))
end

function love.update(dt)
	-- ############################
	-- ## UPDATE PLAYER POSITION ##
	-- ############################

	local player_goalX, player_goalY =
		PLAYER.x + (PLAYER.speed * PLAYER.vx) * dt, PLAYER.y + (PLAYER.speed * PLAYER.vy) * dt
	PLAYER.x, PLAYER.y = WORLD:move(PLAYER, player_goalX, player_goalY)

	PLAYER.vx = 0 -- reset player's horizontal velocity
	PLAYER.vy = 0 -- reset player's vertical velocity

	-- #################
	-- ## MOVE PLAYER ##
	-- #################

	local keystates = {
		up = love.keyboard.isDown("w") or love.keyboard.isDown("up"),
		down = love.keyboard.isDown("s") or love.keyboard.isDown("down"),
		left = love.keyboard.isDown("a") or love.keyboard.isDown("left"),
		right = love.keyboard.isDown("d") or love.keyboard.isDown("right"),
	}
	if PLAYER.move_x then -- if player can move horizontally then
		if keystates.right then -- if pressing "d" or "right"
			PLAYER.vx = 1 -- move to the right
		elseif keystates.left then -- if pressing "a" or "left"
			PLAYER.vx = -1 -- move to the left
		end
	end

	if PLAYER.move_y then -- if player can move vertically then
		if keystates.up then -- if pressing "w" or "up"
			PLAYER.vy = -1 -- move up
		elseif keystates.down then -- if pressing "s" or "down"
			PLAYER.vy = 1 -- move down
		end
	end

	-- ########################
	-- ## MOVE OTHER OBJECTS ##
	-- ########################
	-- # UPDATE BALL'S COLLIDER POSITION #

	OBJECTS.main_ball.collider.x = OBJECTS.main_ball.x - OBJECTS.main_ball.r
	OBJECTS.main_ball.collider.y = OBJECTS.main_ball.y - OBJECTS.main_ball.r

  for name, obj in pairs(OBJECTS) do
    if obj.type ~= "player" then
      local goalX, goalY = obj.x + (obj.speed * obj.vx) * dt, obj.y + (obj.speed * obj.vy) * dt
      local actualX, actualY, cols, len = WORLD:move(obj, goalX, goalY)
    end

    LogMessage("regular", ("object type: %s"):format(obj.type))
  end
end

function love.draw()
	for k, obj in pairs(OBJECTS) do
		SetColor(obj.color)
		obj:draw()
	end

	local ball_coll = OBJECTS.main_ball.collider
	SetColor({ r = 0, g = 1, b = 0, a = 1 })
	love.graphics.rectangle("line", ball_coll.x, ball_coll.y, ball_coll.w, ball_coll.h)

	SetColor({ r = 1, g = 1, b = 1, a = 1 })
	if not STARTED then
		love.graphics.print("PRESS SPACE TO START")
	end
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
	setKey("space", function()
		if not STARTED then
			OBJECTS.main_ball.vx = -1
			OBJECTS.main_ball.vy = 1
			STARTED = not STARTED
		end
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
