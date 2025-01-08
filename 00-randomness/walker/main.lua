local WIDTH, HEIGHT = love.window.getMode()

local Walker = {
  x = math.floor(WIDTH / 2),
  y = math.floor(HEIGHT / 2),
  points = {}
}

function Walker.draw(self)
  love.graphics.points(self.points)
end

function Walker.step(self)
  local moveToMouse = math.random() < 0.1

  local stepX = 0
  local stepY = 0

  if moveToMouse then
    local mouseX = love.mouse.getX()
    local mouseY = love.mouse.getY()

    stepX = mouseX > self.x and 1 or -1
    stepY = mouseY > self.y and 1 or -1
  else
    local xchoice = math.random()
    local ychoice = math.random()

    if xchoice >= 0.66 then
      stepX = 1
    elseif xchoice < 0.33 then
      stepX = -1
    end

    if ychoice > 0.66 then
      stepY = 1
    elseif ychoice < 0.33 then
      stepY = -1
    end
  end

  self.x = self.x + stepX
  self.y = self.y + stepY

  table.insert(self.points, {self.x, self.y})
end

love.graphics.setBackgroundColor(1, 1, 1)
love.graphics.setColor(0, 0, 0)

function love.draw()
  Walker:step()
  Walker:draw()
end
