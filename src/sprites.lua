-- Sprite management and loading
Sprites = {}

function Sprites:initialize()
    self.background = self:loadImage('sprites/background.png')
    self.bullet = self:loadImage('sprites/bullet.png')
    self.player = self:loadImage('sprites/player.png')
    self.zombie = self:loadImage('sprites/zombie.png')
end

function Sprites:loadImage(path)
    -- Safely load images with fallback to white rectangle
    local success, image = pcall(love.graphics.newImage, path)
    
    if success then
        return image
    else
        print("Warning: Could not load sprite at " .. path)
        -- Return a simple white canvas as placeholder
        local canvas = love.graphics.newCanvas(32, 32)
        love.graphics.setCanvas(canvas)
        love.graphics.clear(1, 1, 1)
        love.graphics.setCanvas()
        return canvas
    end
end

return Sprites