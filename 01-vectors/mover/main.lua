math.randomseed(os.time())

local c = require("constants")
local Mover = require("mover")

local mover = Mover.new()

function love.load()
  love.window.setMode(c.WIDTH, c.HEIGHT, {
    msaa = 8,
  })
  love.graphics.setBackgroundColor(1, 1, 1, 1)
end

function love.draw()
  mover:update()
  mover:checkEdges()
  mover:show()
end
