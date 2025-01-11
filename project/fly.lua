local Vector = require("vector")
local c = require("constants")

local Fly = {
  position = Vector.new(),
  lastPosition = Vector.new(),
  rotation = 0,
  t = 0,
  drawLine = 0,
  dt = 0,
}
Fly.__index = Fly

local function newPosition(t)
  return Vector.new(love.math.noise(t) * c.WIDTH, love.math.noise(t + 10000) * c.HEIGHT)
end

function Fly.new()
  local t = math.random(0, 10000)
  local f = {
    position = newPosition(t),
    t = t,
  }
  setmetatable(f, Fly)
  return f
end

function Fly:update()
  self.t = self.t + 0.005
  self.lastPosition = self.position
  self.position = newPosition(self.t)

  local diff = Vector.from(self.position)
  diff:sub(self.lastPosition)
  diff:normalize()
  if diff.y ~= 0 and diff.x ~= 0 then
    self.rotation = math.atan2(diff.y, diff.x) - math.pi / 2
  end

  self.dt = self.dt + 1
  if self.dt > 3 then
    self.dt = 0
    self.drawLine = not self.drawLine
  end
end

function Fly:draw()
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.push()
  love.graphics.translate(self.position.x, self.position.y)
  love.graphics.rotate(self.rotation)
  love.graphics.circle("line", 0, 0, 15)
  love.graphics.circle("fill", 5, 5, 2)
  love.graphics.circle("fill", -5, 5, 2)
  love.graphics.line(-7, 0, -25, -15, -25, 15, -7, 0)
  love.graphics.line(7, 0, 25, -15, 25, 15, 7, 0)
  love.graphics.pop()

  if self.drawLine then
    love.graphics.setCanvas(canvas)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.line(self.lastPosition.x, self.lastPosition.y, self.position.x, self.position.y)
    love.graphics.setCanvas()
  end
end

return Fly
