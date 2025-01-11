local mesh
local gridSize = 10       -- Distance between grid points
local width, height = 50, 50 -- Number of grid points (resolution)
local noiseScale = 0.1    -- Controls the frequency of the noise
local heightScale = 50    -- Controls the height of the mountains
local vertices = {}

function love.load()
    -- Generate vertices with Z-axis controlled by Perlin noise
    for x = 0, width - 1 do
        for y = 0, height - 1 do
            local nx = x * noiseScale
            local ny = y * noiseScale
            local z = love.math.noise(nx, ny) * heightScale -- Height (Z-axis)

            -- Assign color based on height (higher is lighter)
            local brightness = z / heightScale
            table.insert(vertices, {
                x * gridSize, y * gridSize, 0, 0, 
                brightness, brightness, brightness, 1
            })
        end
    end

    -- Create triangle indices to form the mesh
    local indices = {}
    for x = 0, width - 2 do
        for y = 0, height - 2 do
            local i = x * height + y + 1
            table.insert(indices, i)
            table.insert(indices, i + 1)
            table.insert(indices, i + height)

            table.insert(indices, i + 1)
            table.insert(indices, i + height + 1)
            table.insert(indices, i + height)
        end
    end

    -- Create the mesh
    mesh = love.graphics.newMesh(vertices, "triangles", "static")
    mesh:setVertexMap(indices)
end

function love.draw()
    love.graphics.clear(0.1, 0.1, 0.1)
    love.graphics.push()
    love.graphics.translate(400, 300) -- Move the terrain to the center
    love.graphics.rotate(-math.pi / 4) -- Rotate to simulate perspective
    love.graphics.scale(1, 0.5) -- Scale for a 3D-like effect
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(mesh)
    love.graphics.pop()
end

