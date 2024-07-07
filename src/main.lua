-- [] camera
-- [] map

local SWAGG_physics = require 'SWAGG.physics'
local gamera = require 'vendor.gamera'

local map = {}

-- Pato invadindo reino de gnomos
function love.load()
    SWAGG_physics:load()
    Cam = gamera.new(0, 0, 2000, 2000)

    -- Graphics setup
    love.graphics.setBackgroundColor(.4, .2, .7, 1.0)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setMode(320, 240)
    Cam:setWindow(0, 0, 320, 240)

    -- Entities
    Duck = require 'entities.duck'.load(200, 200)

    -- Environement
    map.ground = {}
    map.ground.sizeX = 320
    map.ground.sizeY = 32
    map.ground.body = love.physics.newBody(SWAGG_physics.world, map.ground.sizeX / 2, map.ground.sizeY / 2, 'static')
    map.ground.shape = love.physics.newRectangleShape(0, 240 - 32, map.ground.sizeX * 2, map.ground.sizeY)
    map.ground.fixture = love.physics.newFixture(map.ground.body, map.ground.shape)
end

function love.update(dt)
    SWAGG_physics.world:update(dt)
    if love.keyboard.isDown 'q' then
        love.event.quit()
    end

    Duck:update(dt)
    local _, camY = Cam:getPosition()
    Cam:setPosition(Duck.body:getX(), Duck.body:getY())
    if camY >= 111 then
        Cam:setPosition(Duck.body:getX(), camY - 111)
    end
end

function love.draw()
    love.graphics.setColor(.8, .2, .2)

    Cam:setScale(.5)
    Cam:draw(function()
        Duck:draw()

        love.graphics.polygon('fill', map.ground.body:getWorldPoints(map.ground.shape:getPoints()))
    end)
end
