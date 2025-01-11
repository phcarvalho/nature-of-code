local Vector = require("vector")
local c = require("constants")

local Mover = {
  position = Vector.new(),
  velocity = Vector.new(),
}
Mover.__index = Mover

function Mover.new()
  local m = {
    position = Vector.new(math.random(c.WIDTH), math.random(c.HEIGHT)),
    velocity = Vector.new(math.random(-2, 2), math.random(-2, 2)),
  }
  setmetatable(m, Mover)
  return m
end

function Mover:update()
  self.position:add(self.velocity)
end

function Mover:show()
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.circle("fill", self.position.x, self.position.y, 26)
  love.graphics.setColor(0.6, 0.6, 0.6, 1)
  love.graphics.circle("fill", self.position.x, self.position.y, 24)
end

function Mover:checkEdges()
  if self.position.x > c.WIDTH then
    self.position.x = 0
  elseif self.position.x < 0 then
    self.position.x = c.WIDTH
  end

  if self.position.y > c.HEIGHT then
    self.position.y = 0
  elseif self.position.y < 0 then
    self.position.y = c.HEIGHT
  end
end

return Mover
