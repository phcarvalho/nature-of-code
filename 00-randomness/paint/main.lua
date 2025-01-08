local Slider = require("slider")

math.randomseed(os.time())

local WIDTH = 640
local HEIGHT = 480
local SLIDER_Y = 35

local canvas
local keymap = {}

local sliders = {
  size = Slider:new("Size", 10, SLIDER_Y, 2, 30, 10),
  opacity = Slider:new("Opacity", 10, SLIDER_Y * 2, 0, 255, 120),

  red = Slider:new("Red", 10, SLIDER_Y * 4, 0, 255, math.random(0, 255)),
  green = Slider:new("Green", 10, SLIDER_Y * 5, 0, 255, math.random(0, 255)),
  blue = Slider:new("Blue", 10, SLIDER_Y * 6, 0, 255, math.random(0, 255)),
}

function love.load()
  love.window.setMode(WIDTH, HEIGHT, {
    vsync = true,
  })

  canvas = love.graphics.newCanvas(WIDTH, HEIGHT, {
    msaa = 4
  })
  love.graphics.setCanvas(canvas)
  love.graphics.clear(0, 0, 0, 0)

  love.graphics.setCanvas()
  love.graphics.setBackgroundColor(1, 1, 1, 1)
end

function clamp(value, min, max)
  return math.min(max, math.max(value, min))
end

function getRandomColor()
  local r = clamp((20 * love.math.randomNormal() + sliders.red.value), 0, 255)
  local g = clamp((20 * love.math.randomNormal() + sliders.green.value), 0, 255)
  local b = clamp((20 * love.math.randomNormal() + sliders.blue.value), 0, 255)

  return love.math.colorFromBytes(r, g, b, sliders.opacity.value)
end

function paint(x, y)
  love.graphics.setCanvas(canvas)
  love.graphics.setBlendMode("alpha")

  local x = (sliders.size.value * 0.8) * love.math.randomNormal() + x
  local y = (sliders.size.value * 0.8) * love.math.randomNormal() + y
  local r = sliders.size.value / 5 * love.math.randomNormal() + sliders.size.value

  love.graphics.setColor(getRandomColor())
  love.graphics.circle("fill", x, y, r)
end

local canPaint = true

function randomizeColor()
  sliders.red:setValue(math.random(0, 255))
  sliders.green:setValue(math.random(0, 255))
  sliders.blue:setValue(math.random(0, 255))
end

function clearCanvas()
  love.graphics.setCanvas(canvas)
  love.graphics.clear(0, 0, 0, 0)
  love.graphics.setCanvas()
end

function love.keyreleased(key, _)
  keymap[key] = true
end

function love.update()
  canPaint = true
  for _, slider in pairs(sliders) do
    slider:update()
    canPaint = canPaint and not slider.isGrabbed
  end

  if keymap["c"] then
    clearCanvas()
  end

  if keymap["r"] then
    randomizeColor()
  end

  if keymap["e"] then
    canvas:newImageData():encode("png","filename.png")
  end

  if keymap["escape"] then
    love.event.quit()
  end

  keymap = {}
end

function love.draw()
  if canPaint and love.mouse.isDown(1) then
    paint(love.mouse.getPosition())
  end

  love.graphics.setCanvas()
  love.graphics.setBlendMode("alpha", "premultiplied")
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(canvas, 0, 0)

  for _, slider in pairs(sliders) do
    slider:draw()
  end

  love.graphics.setColor(love.math.colorFromBytes(
    sliders.red.value,
    sliders.green.value,
    sliders.blue.value,
    255
  ))
  love.graphics.rectangle("fill", 10, SLIDER_Y * 7 - 10, 32, 32)
end
