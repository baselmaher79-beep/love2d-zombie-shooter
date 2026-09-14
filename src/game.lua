-- Game state manager
local Player = require("src/player")
local Zombie = require("src/zombie")
local Bullet = require("src/bullet")
local Sprites = require("src/sprites")

Game = {}

function Game:initialize()
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.window.setTitle("Zombie Shooter")
    
    Sprites:initialize()
    
    self.player = Player:new()
    self.zombies = {}
    self.bullets = {}
    
    self.score = 0
    self.wave = 1
    self.zombie_count = 5
    self.spawn_timer = 0
    self.spawn_cooldown = ZOMBIE.spawn_cooldown
    
    self:spawnInitialZombies()
end

function Game:spawnInitialZombies()
    for i = 1, self.zombie_count do
        self:spawnZombie()
    end
end

function Game:spawnZombie()
    -- Spawn on screen edges to avoid spawning on player
    local side = math.random(4)
    local x, y
    
    if side == 1 then
        x = math.random(SCREEN_WIDTH)
        y = 0
    elseif side == 2 then
        x = SCREEN_WIDTH
        y = math.random(SCREEN_HEIGHT)
    elseif side == 3 then
        x = math.random(SCREEN_WIDTH)
        y = SCREEN_HEIGHT
    else
        x = 0
        y = math.random(SCREEN_HEIGHT)
    end
    
    table.insert(self.zombies, Zombie:new(x, y))
end

function Game:update(dt)
    self.player:update(dt)
    
    -- Update zombies
    for i, zombie in ipairs(self.zombies) do
        if zombie.alive then
            zombie:update(dt, self.player)
        end
    end
    
    -- Update bullets
    for i, bullet in ipairs(self.bullets) do
        if bullet.alive then
            bullet:update(dt)
            self:checkBulletCollisions(bullet)
        end
    end
    
    -- Handle zombie spawning
    self.spawn_timer = self.spawn_timer + dt
    if self.spawn_timer >= self.spawn_cooldown then
        self:spawnZombie()
        self.spawn_timer = 0
    end
    
    -- Clean up dead entities
    self:cleanupDeadEntities()
    
    -- Check win/loss conditions
    self:checkGameState()
end

function Game:checkBulletCollisions(bullet)
    for i, zombie in ipairs(self.zombies) do
        if zombie.alive and bullet:checkCollision(zombie) then
            zombie:kill()
            bullet.alive = false
            self.score = self.score + 100
            break
        end
    end
end

function Game:cleanupDeadEntities()
    -- Remove dead zombies
    for i = #self.zombies, 1, -1 do
        if not self.zombies[i].alive then
            table.remove(self.zombies, i)
        end
    end
    
    -- Remove dead bullets
    for i = #self.bullets, 1, -1 do
        if not self.bullets[i].alive then
            table.remove(self.bullets, i)
        end
    end
end

function Game:checkGameState()
    -- Check for game over (zombie reached player)
    for i, zombie in ipairs(self.zombies) do
        local dx = zombie.x - self.player.x
        local dy = zombie.y - self.player.y
        local distance = math.sqrt(dx * dx + dy * dy)
        
        if distance < 20 then
            -- Game over logic - implement as needed
        end
    end
end

function Game:draw()
    -- Draw background
    if Sprites.background then
        love.graphics.draw(Sprites.background, 0, 0)
    else
        love.graphics.clear(0.2, 0.2, 0.2)
    end
    
    -- Draw zombies
    for i, zombie in ipairs(self.zombies) do
        if zombie.alive then
            zombie:draw()
        end
    end
    
    -- Draw bullets
    for i, bullet in ipairs(self.bullets) do
        if bullet.alive then
            bullet:draw()
        end
    end
    
    -- Draw player
    self.player:draw()
    
    -- Draw UI
    self:drawUI()
end

function Game:drawUI()
    love.graphics.setColor(COLORS.white)
    love.graphics.print("Score: " .. self.score, 10, 10)
    love.graphics.print("Zombies: " .. #self.zombies, 10, 40)
    love.graphics.print("Bullets: " .. #self.bullets, 10, 70)
end

function Game:keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function Game:mousepressed(x, y, button)
    if button == 1 then  -- Left mouse button
        local bullet = Bullet:new(
            self.player.x,
            self.player.y,
            self.player.angle
        )
        table.insert(self.bullets, bullet)
    end
end

return Game