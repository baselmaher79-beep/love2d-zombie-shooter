-- Zombie class
Zombie = {}
Zombie.__index = Zombie

function Zombie:new(x, y)
    local self = setmetatable({}, Zombie)
    self.x = x or math.random(SCREEN_WIDTH)
    self.y = y or math.random(SCREEN_HEIGHT)
    self.speed = ZOMBIE.speed
    self.width = ZOMBIE.width
    self.height = ZOMBIE.height
    self.angle = 0
    self.alive = true
    return self
end

function Zombie:update(dt, player)
    if not self.alive then return end
    
    self:moveToward(player, dt)
    self:updateAngle(player)
end

function Zombie:moveToward(player, dt)
    local dx = player.x - self.x
    local dy = player.y - self.y
    local distance = math.sqrt(dx * dx + dy * dy)

    if distance > 0 then
        local moveX = (dx / distance) * self.speed * dt
        local moveY = (dy / distance) * self.speed * dt
        self.x = self.x + moveX
        self.y = self.y + moveY
    end
end

function Zombie:updateAngle(player)
    local dx = player.x - self.x
    local dy = player.y - self.y
    self.angle = math.atan2(dy, dx)
end

function Zombie:draw()
    if Sprites.zombie then
        love.graphics.draw(
            Sprites.zombie,
            self.x,
            self.y,
            self.angle,
            1, 1,
            self.width / 2,
            self.height / 2
        )
    end
end

function Zombie:kill()
    self.alive = false
end

return Zombie