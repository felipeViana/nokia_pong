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

function utils.random(a, b)
  if not a then a, b = 0, 1 end
  if not b then b = 0 end
  return a + math.random() * (b - a)
end


return utils
