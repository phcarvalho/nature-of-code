math.randomseed(os.time())

local c = require("constants")
local Fly = require("fly")

canvas = nil

function love.load()
  love.window.setMode(c.WIDTH, c.HEIGHT, {
    msaa = 8,
  })
  love.graphics.setBackgroundColor(1, 1, 1, 1)

  canvas = love.graphics.newCanvas(c.WIDTH, c.HEIGHT)
  love.graphics.setCanvas(canvas)
  love.graphics.clear(0, 0, 0, 0)
  love.graphics.setBackgroundColor(1, 1, 1, 1)
  love.graphics.setBlendMode("alpha")

  love.graphics.setCanvas()
end

local flies = {}

function love.mousereleased(_, _, button) 
  if button == 1 then
    table.insert(flies, Fly.new())
  end
end

function love.update()
  for _, fly in pairs(flies) do
    fly:update()
  end
end

function love.draw()
  love.graphics.setCanvas(canvas)
  love.graphics.setBlendMode("alpha")
  love.graphics.setColor(1, 1, 1, 0.1)
  love.graphics.rectangle("fill", 0, 0, c.WIDTH, c.HEIGHT)

  love.graphics.setCanvas()
  love.graphics.setBlendMode("alpha", "premultiplied")
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(canvas)

  for _, fly in pairs(flies) do
    fly:draw()
  end
end
