local SWAGG_physics = {
    worldScale = 32,
    gravity = 9.81,

    --- @type love.World
    world = {}
}

function SWAGG_physics:load()
    -- Physics setup
    love.physics.setMeter(self.worldScale)
    self.world = love.physics.newWorld(0, self.gravity * self.worldScale, true)
end

return SWAGG_physics
