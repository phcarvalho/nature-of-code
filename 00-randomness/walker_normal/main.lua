local WIDTH = 640
local HEIGHT = 480

local canvas

local walker = {
  x = WIDTH / 2,
  y = HEIGHT / 2
}

function walker:walk()
  local xstep = 2 * love.math.randomNormal()
  local ystep = 2 * love.math.randomNormal()

  self.x = self.x + xstep
  self.y = self.y + ystep
end

function walker:draw()
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.points(self.x, self.y)
end

function love.load()
  love.graphics.setBackgroundColor(1, 1, 1, 1)

  canvas = love.graphics.newCanvas(WIDTH, HEIGHT, {
    msaa = 4
  })

  love.graphics.setCanvas(canvas)
  love.graphics.clear(0, 0, 0, 0)
  love.graphics.setBlendMode("alpha")

  love.graphics.setCanvas()
end

function love.update()
  walker:walk()
end

function love.draw()
  love.graphics.setCanvas(canvas)
  walker:draw()
  love.graphics.setCanvas()

  love.graphics.setBlendMode("alpha", "premultiplied")
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(canvas)
end
