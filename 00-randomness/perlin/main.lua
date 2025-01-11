local WIDTH = 640
local HEIGHT = 480

local t = 0
local ty = 5000
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

local tz = 0
function drawTexture()
  local scale = 0.02
  for x = 1, WIDTH - 2, 2 do
    for y = 1, HEIGHT - 2, 2 do
      local xscaled, yscaled = x * scale, y * scale
      -- local rvalue = love.math.noise(xscaled, yscaled, tz)
      -- local gvalue = love.math.noise(xscaled + 5000, yscaled + 5000, tz)
      -- local bvalue = love.math.noise(xscaled + 10000, yscaled + 10000, tz)
      --
      -- love.graphics.setColor(rvalue, gvalue, bvalue, 1)
      
      local value = love.math.noise(xscaled, yscaled, tz)
      love.graphics.setColor(value, value, value, 1)
      love.graphics.rectangle("fill", x, y, 2, 2)
    end
  end

  tz = tz + scale
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

local circle = {
  x = WIDTH / 2,
  y = HEIGHT / 2,
  r = 20,
}

local stepSize = 10

function drawCircleStepWalker()
  local xstep = 2 * (love.math.noise(t) - 0.5) * stepSize
  local ystep = 2 * (love.math.noise(t + 10000) - 0.5) * stepSize

  circle.x = circle.x + xstep
  circle.y = circle.y + ystep

  if circle.x + circle.r < 0 then
    circle.x = WIDTH + circle.r - 1
  elseif circle.x - circle.r > WIDTH then
    circle.x = - circle.r + 1
  end

  if circle.y + circle.r < 0 then
    circle.y = HEIGHT + circle.r - 1
  elseif circle.y - circle.r > HEIGHT then
    circle.y = -circle.r + 1
  end

  love.graphics.setColor(0.2, 0.2, 0.2, 1)
  love.graphics.circle("fill", circle.x, circle.y, circle.r + 1)
  love.graphics.setColor(0.3, 0.3, 0.3, 1)
  love.graphics.circle("fill", circle.x, circle.y, circle.r)

  t = t + 0.01
end

function love.draw()
  love.graphics.setCanvas(canvas)
  drawCircleStepWalker()
  love.graphics.setCanvas()
  love.graphics.setBlendMode("alpha", "premultiplied")

  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(canvas, 0, 0)
end
