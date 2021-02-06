local colors = require 'colors'
local utils = require 'utils'
local sceneManager = require 'src/sceneManager'
local soundManager = require 'soundManager'

local breakout = {}

local selectSound = love.audio.newSource("assets/sfx/hit5.wav", "static")

function breakout.load( ... )
  -- body
end

function breakout.update( dt )
  -- body
end

function breakout.draw( ... )
  utils.clearScreen()

  love.graphics.setColor(colors.black)
  love.graphics.print("breakout game", 150, 30)
end

function breakout.keypressed( key )
  if key == 'space' then
    soundManager.playSound(selectSound)
    sceneManager.changeScene(require 'src/snake')
  end

  if key == 'escape' then
    love.event.quit(0)
  end
end

return breakout
