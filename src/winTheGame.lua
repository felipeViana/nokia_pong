local utils = require 'utils'
local soundManager = require 'soundManager'

local winTheGame = {}

local winTheGameSound = love.audio.newSource("assets/sfx/bad_melody.wav", "static")

function winTheGame.load()
  soundManager.play(winTheGameSound)
end

function winTheGame.update( dt )
  -- body
end

function winTheGame.draw( ... )
  utils.clearScreen()

  love.graphics.print("THANKS FOR PLAYING!", 110, 10)
  love.graphics.print("Have a nice day", 130, 50)

  love.graphics.print("Press ESC to exit", 130, 170)
end

function winTheGame.keypressed( key )
  if key == 'escape' then
    love.event.quit(0)
  end
end

return winTheGame
