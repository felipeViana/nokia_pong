local colors = require 'colors'
local utils = require 'utils'
local sceneManager = require 'src/sceneManager'
local pong = {}

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
