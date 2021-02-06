local utils = require 'utils'
local soundManager = require 'soundManager'

local winTheGame = {}

local winTheGameSound = love.audio.newSource("assets/sfx/negative1.wav", "static")

function winTheGame.load()
  soundManager.play(winTheGameSound)
end

function winTheGame.update( dt )
  -- body
end

function winTheGame.draw( ... )
  utils.clearScreen()

  love.graphics.print("THANKS FOR PLAYING!", 150, 10)
end

return winTheGame
