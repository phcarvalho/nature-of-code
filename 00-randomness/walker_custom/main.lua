local canvas

local walker = {
  x = 0,
  y = 0,
}

function acceptreject(step)
  step = step or 1
  while true do
    local r1 = math.random()
    local r2 = math.random()
    local p = r1 * r1

    if r2 < p then
      return (2 * r1 - 1) * step
    end
  end
end

function walker:walk()
  local xstep = acceptreject(2)
  local ystep = acceptreject(2)

  self.x = self.x + xstep
  self.y = self.y + ystep
end

function walker:draw()
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.points(self.x, self.y)
end

function love.load()
  love.graphics.setBackgroundColor(1, 1, 1, 1)

  canvas = love.graphics.newCanvas()
  love.graphics.setCanvas(canvas)
  love.graphics.clear(0, 0, 0, 0)
  love.graphics.setBlendMode("alpha")

  love.graphics.setCanvas()

  local w, h = love.window.getMode()
  walker.x = w / 2
  walker.y = h / 2
end

function love.update()
  walker:walk()
end

function love.draw()
  love.graphics.setCanvas(canvas)
  walker:draw()
  love.graphics.setCanvas()

  love.graphics.setBlendMode("alpha", "premultiplied")
  love.graphics.draw(canvas, 0, 0)
end
