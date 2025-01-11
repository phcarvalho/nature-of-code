local Vector = {}
Vector.__index = Vector

function Vector.new(x, y)
  local v = {x = x or 0, y = y or 0}
  setmetatable(v, Vector)
  return v
end

function Vector.from(v)
  return Vector.new(v.x, v.y)
end

function Vector:add(v)
  self.x = self.x + v.x
  self.y = self.y + v.y
end

function Vector:sub(v)
  self.x = self.x - v.x
  self.y = self.y - v.y
end

function Vector:copy(v)
  self.x = v.x
  self.y = v.y
end

function Vector:mult(n)
  self.x = self.x * n
  self.y = self.y * n
end

function Vector:div(n)
  self.x = self.x / n
  self.y = self.y / n
end

function Vector:getMagnitude()
  return math.sqrt(self.x * self.x + self.y * self.y)
end

function Vector:normalize()
  local m = self:getMagnitude()
  if m > 0 then
	self:div(m)
  end
end

function Vector.__tostring(v)
  return "(" .. v.x .. ", " .. v.y .. ")"
end

return Vector
