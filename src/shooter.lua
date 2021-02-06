local colors = require 'colors'
local utils = require 'utils'
local sceneManager = require 'src/sceneManager'
local soundManager = require 'soundManager'

local shooter = {}

local selectSound = love.audio.newSource("assets/sfx/hit5.wav", "static")

function shooter.load( ... )
  -- body
end

function shooter.update( dt )
  -- body
end

function shooter.draw( ... )
  utils.clearScreen()

  love.graphics.print("shooter game", 150, 30)
end

function shooter.keypressed( key )
  if key == 'space' then
    soundManager.play(selectSound)
    sceneManager.changeScene(require 'src/breakout')
  end
end

return shooter
