local class_syst = require("src.utils.class")

return class_syst({
  x = 0,
  y = 0,
  r = 10,
  vx = 0,
  vy = 0,
  speed = 400,
  collider = {
    x = 0,
    y = 0,
    w = 20,
    h = 20
  },
  ---@type color
  color = {
    r = 1,
    g = 1,
    b = 1,
    a = 1
  },
  type = "ball",
  draw = function(self)
    love.graphics.circle("fill", self.x, self.y, self.r)
  end,
  init = function(self)
    local rect = self.collider
    WORLD:add(self, rect.x, rect.y, rect.w, rect.h)
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
  setRadius = function(self, new_radius)
    self.r = new_radius
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
  getRadius = function(self)
    return self.r
  end,
  getRect = function(self)
    return self.collider
  end,
  resetPosition = function(self)
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
  end
}, {})
