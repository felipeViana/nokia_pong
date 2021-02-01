local colors = require 'colors'
local utils = require 'utils'
local soundManager = require 'soundManager'

local defaultFont = love.graphics.newFont(
  'assets/fonts/EffortsPro.ttf', 36
)

local sound = love.audio.newSource("assets/sfx/hit5.wav", "static")

function love.load( ... )
  love.graphics.setFont(defaultFont)
end

function love.update( dt )
  -- body
end

function love.draw( ... )
  utils.clearScreen()

  love.graphics.setColor(colors.black)
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 0, 10)
end

function love.keypressed(key)
  if key == 'space' then
    soundManager.playSound(sound)
  end

  if key == 'escape' then
    love.event.quit(0)
  end
end
