-- Main entry point for the zombie shooter game
require("src/constants")
require("src/sprites")
require("src/player")
require("src/zombie")
require("src/bullet")
require("src/game")

function love.load()
    Game:initialize()
end

function love.update(dt)
    Game:update(dt)
end

function love.draw()
    Game:draw()
end

function love.keypressed(key)
    Game:keypressed(key)
end

function love.mousepressed(x, y, button)
    Game:mousepressed(x, y, button)
end