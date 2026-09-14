-- Player class
Player = {}
Player.__index = Player

function Player:new()
    local self = setmetatable({}, Player)
    self.x = SCREEN_WIDTH / 2
    self.y = SCREEN_HEIGHT / 2
    self.speed = PLAYER.speed
    self.width = PLAYER.width
    self.height = PLAYER.height
    self.angle = 0
    return self
end

function Player:update(dt)
    self:handleMovement(dt)
    self:updateAngle()
end

function Player:handleMovement(dt)
    local moveX = 0
    local moveY = 0

    if love.keyboard.isDown("d") then moveX = moveX + 1 end
    if love.keyboard.isDown("a") then moveX = moveX - 1 end
    if love.keyboard.isDown("w") then moveY = moveY - 1 end
    if love.keyboard.isDown("s") then moveY = moveY + 1 end

    -- Normalize diagonal movement (prevents faster diagonal speed)
    local length = math.sqrt(moveX * moveX + moveY * moveY)
    if length > 0 then
        moveX = moveX / length
        moveY = moveY / length
    end

    self.x = self.x + moveX * self.speed * dt
    self.y = self.y + moveY * self.speed * dt

    -- Clamp to screen boundaries
    self:clampToScreen()
end

function Player:clampToScreen()
    self.x = math.max(0, math.min(self.x, SCREEN_WIDTH))
    self.y = math.max(0, math.min(self.y, SCREEN_HEIGHT))
end

function Player:updateAngle()
    local dx = love.mouse.getX() - self.x
    local dy = love.mouse.getY() - self.y
    self.angle = math.atan2(dy, dx)
end

function Player:draw()
    if Sprites.player then
        love.graphics.draw(
            Sprites.player,
            self.x,
            self.y,
            self.angle,
            1, 1,  -- scaleX, scaleY
            self.width / 2,
            self.height / 2
        )
    end
end

return Player