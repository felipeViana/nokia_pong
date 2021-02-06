local colors = require 'colors'

local utils = {}

function utils.clearScreen( ... )
  love.graphics.setColor(colors.white)
  love.graphics.rectangle(
    'fill',
    0,
    0,
    84 * SCALING_FACTOR,
    48 * SCALING_FACTOR
  )

  love.graphics.setColor(colors.black)
end

return utils
