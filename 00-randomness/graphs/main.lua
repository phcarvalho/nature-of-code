local TOTAL = 20
local WIDTH, HEIGHT = love.window.getMode()

local randomCounts = {}
local barWidth = 0

function love.load()
  for i = 1, TOTAL do
	table.insert(randomCounts, 0)
  end

  love.graphics.setBackgroundColor(1, 1, 1)
  love.graphics.setColor(0.3, 0.3, 0.3)

  barWidth = WIDTH / TOTAL
end

function love.draw()
  local index = math.random(1, TOTAL)
  randomCounts[index] = randomCounts[index] + 1


  for i = 1, TOTAL do
	love.graphics.rectangle(
	  "fill",
	  barWidth * (i - 1) + 1,
	  HEIGHT - randomCounts[i],
	  barWidth - 2,
	  randomCounts[i]
	)
  end
end
