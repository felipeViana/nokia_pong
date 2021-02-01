local colors = require 'colors'
local utils = require 'utils'

local defaultFont = love.graphics.newFont(
  'assets/fonts/EffortsPro.ttf', 36
)

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
  if key == 'escape' then
    love.event.quit(0)
  end
end
