local colors = require 'colors'
local utils = require 'utils'
local sceneManager = require 'src/sceneManager'
local soundManager = require 'soundManager'

local pong = {}

local selectSound = love.audio.newSource("assets/sfx/hit5.wav", "static")

function pong.load( ... )
  -- body
end

function pong.update( dt )
  -- body
end

function pong.draw( ... )
  utils.clearScreen()

  love.graphics.setColor(colors.black)
  love.graphics.print("Pong game", 150, 30)
end

function pong.keypressed( key )
  if key == 'escape' then
    love.event.quit(0)
  end
end

return pong
