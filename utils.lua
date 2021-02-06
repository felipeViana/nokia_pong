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

function utils.clamp( value, min, max )
  if value > max then
    return max
  end

  if value < min then
    return min
  end

  return value
end

return utils
