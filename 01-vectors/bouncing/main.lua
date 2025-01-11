local WIDTH = 640
local HEIGHT = 480

local lg = love.graphics

local x = 100
local y = 100
local xspeed = 2.5
local yspeed = 2

function love.load()
  love.window.setMode(WIDTH, HEIGHT, {
	msaa = 4,
  })
  lg.setBackgroundColor(1, 1, 1, 1)
end

function love.draw()
  x = x + xspeed
  y = y + yspeed

  if x > WIDTH or x < 0 then
	xspeed = -xspeed
  end
  if y > HEIGHT or y < 0 then
	yspeed = -yspeed
  end

  lg.setColor(0, 0, 0, 1)
  lg.circle("fill", x, y, 22)
  lg.setColor(0.5, 0.5, 0.5, 1)
  lg.circle("fill", x, y, 20)
end
