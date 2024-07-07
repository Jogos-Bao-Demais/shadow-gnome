local SWAGG_physics = require 'SWAGG.physics'
local SWAGG_math = require 'SWAGG.math'

local duck = {
    --- @type love.Body
    body      = {},
    --- @type love.Shape
    shape     = {},
    --- @type love.Fixture
    fixture   = {},

    size      = 32,
    x         = 0,
    y         = 0,
    health    = 0,
    moveSpeed = 0.0,
    jumpSpeed = 0.0,
}

duck.__index = duck
setmetatable(duck, {
    _call = function(cls, ...)
        return cls.load(...)
    end
})

--- @param spawnX number
--- @param spawnY number
function duck.load(spawnX, spawnY)
    local size = 32
    local density = 1.

    local body = love.physics.newBody(SWAGG_physics.world, size, size, 'dynamic')
    local shape = love.physics.newRectangleShape(size, size + 32)
    local fixture = love.physics.newFixture(body, shape, density)

    local _duck = {
        body      = body,
        shape     = shape,
        fixture   = fixture,
        x         = spawnX,
        y         = spawnY,
        health    = 3,
        moveSpeed = 140.,
        jumpSpeed = 10.,
    }

    return setmetatable(_duck, duck)
end

--- @param dt number
function duck:update(dt)
    self:move(dt)
end

function duck:draw()
    love.graphics.rectangle('fill', self.body:getX(), self.body:getY(), self.size, self.size)
end

function duck:move(dt)
    local dir      = (love.keyboard.isDown 'd' and 1 or 0) - (love.keyboard.isDown 'a' and 1 or 0)
    local friction = .05
    local maxSpeed = 300

    local xv, yv   = self.body:getLinearVelocity()
    if dir ~= 0 then
        self.body:setLinearVelocity(self.moveSpeed * dir, yv)
    else
        self.body:setLinearVelocity(SWAGG_math.lerp(xv, 0., friction), yv)
    end

    if love.keyboard.isDown 'w' then
        self.body:applyLinearImpulse(.0, -self.jumpSpeed)
    end
end

return duck
