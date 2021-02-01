local colors = require 'colors'
local utils = require 'utils'

function love.load( ... )
  -- body
end

function love.update( dt )

  -- 15 fps

  -- body
end

function love.draw( ... )
  utils.clearScreen()

  love.graphics.setColor(colors.black)
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 0, 0)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit(0)
  end
end
