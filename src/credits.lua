local colors = require 'colors'
local utils = require 'utils'
local sceneManager = require 'src/sceneManager'
local soundManager = require 'soundManager'

local credits = {}

local selectSound = love.audio.newSource("assets/sfx/hit5.wav", "static")

function credits.load( ... )
  -- body
end

function credits.update( dt )
  -- body
end

function credits.draw( ... )
  utils.clearScreen()

  love.graphics.setColor(colors.black)
  love.graphics.print("credits game", 150, 30)
end

function credits.keypressed( key )
  if key == 'escape' then
    love.event.quit(0)
  end
end

return credits
