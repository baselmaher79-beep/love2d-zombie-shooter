-- Bullet class
Bullet = {}
Bullet.__index = Bullet

function Bullet:new(x, y, angle)
    local self = setmetatable({}, Bullet)
    self.x = x
    self.y = y
    self.angle = angle
    self.speed = BULLET.speed
    self.width = BULLET.width
    self.height = BULLET.height
    self.lifetime = BULLET.lifetime
    self.age = 0
    self.alive = true
    return self
end

function Bullet:update(dt)
    self.age = self.age + dt

    if self.age > self.lifetime then
        self.alive = false
        return
    end

    -- Move bullet in direction of angle
    local moveX = math.cos(self.angle) * self.speed * dt
    local moveY = math.sin(self.angle) * self.speed * dt

    self.x = self.x + moveX
    self.y = self.y + moveY

    -- Remove if off-screen
    if self.x < 0 or self.x > SCREEN_WIDTH or self.y < 0 or self.y > SCREEN_HEIGHT then
        self.alive = false
    end
end

function Bullet:draw()
    if Sprites.bullet then
        love.graphics.draw(
            Sprites.bullet,
            self.x,
            self.y,
            self.angle,
            1, 1,
            self.width / 2,
            self.height / 2
        )
    end
end

function Bullet:checkCollision(zombie)
    -- Simple AABB collision detection
    return self.x < zombie.x + zombie.width and
           self.x + self.width > zombie.x and
           self.y < zombie.y + zombie.height and
           self.y + self.height > zombie.y
end

return Bullet