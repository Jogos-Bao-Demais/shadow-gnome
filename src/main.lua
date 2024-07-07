local SWAGG_physics = require 'SWAGG.physics'

local map = {}

-- Pato invadindo reino de gnomos
function love.load()
    SWAGG_physics:load()

    -- Graphics setup
    love.graphics.setBackgroundColor(.4, .2, .7, 1.0)
    love.window.setMode(320, 240)

    -- Entities
    Duck = require 'player.duck'.load(200, 200)

    -- Environement
    map.ground = {}
    map.ground.sizeX = 320
    map.ground.sizeY = 32
    map.ground.body = love.physics.newBody(SWAGG_physics.world, map.ground.sizeX / 2, map.ground.sizeY / 2, 'static')
    map.ground.shape = love.physics.newRectangleShape(0, 240 - 32, map.ground.sizeX, map.ground.sizeY)
    map.ground.fixture = love.physics.newFixture(map.ground.body, map.ground.shape)
end

function love.update(dt)
    SWAGG_physics.world:update(dt)
    if love.keyboard.isDown 'q' then
        love.event.quit()
    end

    Duck:update(dt)
end

function love.draw()
    love.graphics.setColor(.8, .2, .2)
    love.graphics.polygon('fill', map.ground.body:getWorldPoints(map.ground.shape:getPoints()))

    Duck:draw()
end
