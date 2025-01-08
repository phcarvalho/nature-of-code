local WIDTH = 640
local HEIGHT = 480

local t = 0.0
local ty = 1000.0
local canvas

function love.load()
  love.window.setMode(WIDTH, HEIGHT)
  love.graphics.setBackgroundColor(1, 1, 1, 1)

  canvas = love.graphics.newCanvas(WIDTH, HEIGHT, {
    msaa = 4
  })
  love.graphics.setCanvas(canvas)
  love.graphics.clear(0, 0, 0, 0)
  love.graphics.setBlendMode("alpha")

  love.graphics.setCanvas()
end

function drawGraph()
  local points = {}
  for i = 1, WIDTH do
	local y = love.math.noise(t + i * 0.01) * HEIGHT
	table.insert(points, i)
	table.insert(points, y)
  end

  love.graphics.line(points)

  t = t + 0.01
end

function drawTexture()
  local scale = 1.01
  for x = 1, WIDTH do
	for y = 1, HEIGHT do
	  local value = love.math.noise((x + t) * scale, y * scale)

	  love.graphics.setColor(value, value, value, 1)
	  love.graphics.points(x, y)
	end
  end

  t = t + 1
end

function drawCircleWalker()
  local x = love.math.noise(t) * WIDTH
  local y = love.math.noise(ty) * HEIGHT

  love.graphics.setColor(0.2, 0.2, 0.2, 1)
  love.graphics.circle("fill", x, y, 21)
  love.graphics.setColor(0.3, 0.3, 0.3, 1)
  love.graphics.circle("fill", x, y, 20)

  t = t + 0.01
  ty = ty + 0.01
end

function love.draw()
  love.graphics.setCanvas(canvas)
  drawCircleWalker()
  love.graphics.setCanvas()
  love.graphics.setBlendMode("alpha", "premultiplied")

  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(canvas, 0, 0)
end
