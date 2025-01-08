local Slider = {
  min = 0,
  max = 1,
  value = 0,
  x = 0,
  y = 0,
  sliderX = 0,
  title = "Slider",
  isGrabbed = false,
}

function Slider:setValue(value)
  self.value = value
  self:updateSlider()
end

function Slider:getValue()
  return self.value
end

function Slider:update()
  if love.mouse.isDown(1) then
    local mouseX = love.mouse.getX()
    if self.isGrabbed then
      if mouseX <= self.x then
        self.value = self.min
      elseif mouseX >= self.x + 60 then
        self.value = self.max
      else
        self.value = ((mouseX - self.x) / 60) * (self.max - self.min) + self.min
      end
      self:updateSlider()
    else
      if mouseX >= self.x and mouseX <= self.x + 60 then
        local mouseY = love.mouse.getY()
        if mouseY >= (self.y - 4) and mouseY <= self.y + 16 then
          self.isGrabbed = true
        end
      end
    end
  elseif self.isGrabbed then
    self.isGrabbed = false
  end
end

function Slider:updateSlider()
  self.sliderX = self.x + ((self.value - self.min) / (self.max - self.min)) * (60 - 8)
end

function Slider:draw()
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.print(self.title, self.x, self.y - 20)

  love.graphics.setColor(0.3, 0.3, 0.3)
  love.graphics.rectangle("fill", self.x, self.y, 60, 8)

  love.graphics.setColor(0.6, 0.6, 0.6)
  love.graphics.rectangle("fill", self.sliderX, self.y - 4, 8, 16)
end

function Slider:new(title, x, y, min, max, default)
  local o = {}
  setmetatable(o, self)
  self.__index = self

  o.min = min or self.min
  o.max = max or self.max
  o.value = default or o.min
  o.title = title or self.title
  o.x = x or self.x
  o.y = y or self.y
  o:updateSlider()

  return o
end

return Slider
