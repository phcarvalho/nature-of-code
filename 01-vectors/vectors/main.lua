local Vector = require("vector")

local WIDTH = 640
local HEIGHT = 480

local lg = love.graphics

function love.load()
  love.window.setMode(WIDTH, HEIGHT, {
    msaa = 4,
  })
  lg.setBackgroundColor(1, 1, 1, 1)
end

local center = Vector.new(WIDTH / 2, HEIGHT / 2)

function drawMult()
  local mouse = Vector.new(love.mouse.getPosition())

  lg.setLineWidth(2)
  lg.setColor(0.6, 0.6, 0.6, 1)
  lg.line(center.x, center.y, mouse.x, mouse.y)

  mouse:sub(center)
  mouse:mult(0.5)
  mouse:add(center)
  lg.setLineWidth(4)
  lg.setColor(0, 0, 0, 1)
  lg.line(center.x, center.y, mouse.x, mouse.y)
end

function drawMag()
  local mouse = Vector.new(love.mouse.getPosition())

  lg.setLineWidth(2)
  lg.setColor(0, 0, 0, 1)
  lg.line(center.x, center.y, mouse.x, mouse.y)

  mouse:sub(center)
  local mag = mouse:getMagnitude()

  lg.setLineWidth(16)
  lg.line(0, 8, mag, 8)
end

function drawNormalize()
  local mouse = Vector.new(love.mouse.getPosition())

  lg.setLineWidth(2)
  lg.setColor(0.6, 0.6, 0.6, 1)
  lg.line(center.x, center.y, mouse.x, mouse.y)


  mouse:sub(center)
  mouse:normalize()
  mouse:mult(50)
  mouse:add(center)
  lg.setLineWidth(4)
  lg.setColor(0, 0, 0, 1)
  lg.line(center.x, center.y, mouse.x, mouse.y)
end

function love.draw()
  drawNormalize()
end
