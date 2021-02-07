local colors = require 'colors'
local utils = require 'utils'
local sceneManager = require 'src/sceneManager'
local soundManager = require 'soundManager'

local snake = {}

local selectSound = love.audio.newSource("assets/sfx/hit5.wav", "static")

function snake.load( ... )
  -- body
end

function snake.update( dt )
  -- body
end

function snake.draw( ... )
  utils.clearScreen()

  love.graphics.print("snake game", 150, 30)
end

function snake.keypressed( key )
  if key == 'escape' then
    love.event.quit(0)
  end
end

return snake
