local WIDTH = 640
local HEIGHT = 480
local canvas

function love.load()
  love.window.setMode(WIDTH, HEIGHT)
  canvas = love.graphics.newCanvas()

  love.graphics.setBackgroundColor(1, 1, 1)

  love.graphics.setCanvas(canvas)
  love.graphics.clear(0, 0, 0, 0)

  love.graphics.setCanvas()
end

function drawCircle()
  local x = 60 * love.math.randomNormal() + WIDTH / 2

  love.graphics.setBlendMode("alpha")
  love.graphics.setColor(0.2, 0.2, 0.2, 0.05)
  love.graphics.circle("fill", x, math.floor(HEIGHT / 2), 30)
end

function love.draw()
  love.graphics.setCanvas(canvas)
  drawCircle()

  love.graphics.setBlendMode("alpha", "premultiplied")
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setCanvas()
  love.graphics.draw(canvas, 0, 0)
end


