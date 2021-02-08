local colors = require 'colors'
local utils = require 'utils'
local sceneManager = require 'src/sceneManager'
local soundManager = require 'soundManager'

local snake = {}

local selectSound = love.audio.newSource("assets/sfx/hit5.wav", "static")

local snake = {
  {['x'] = 50, ['y'] = 50},
  {['x'] = 40, ['y'] = 50},
  {['x'] = 30, ['y'] = 50},
}

local TILE_SIZE = 10

local snakeDirection = 'right'
local nextSnakeDirection = 'right'

local frame = 0
local CYCLE_TIME = 6

local score = 0

local HUD_HEIGHT = 30

function snake.load( ... )
  -- body
end

function snake.update( dt )
  frame = frame + 1

  if frame == CYCLE_TIME then
    for i = #snake, 2, -1 do
      snake[i].x = snake[i - 1].x
      snake[i].y = snake[i - 1].y
    end

    if nextSnakeDirection == 'right' then
      snake[1].x = snake[1].x + TILE_SIZE
      snakeDirection = 'right'
    elseif nextSnakeDirection == 'left' then
      snake[1].x = snake[1].x - TILE_SIZE
      snakeDirection = 'left'
    elseif nextSnakeDirection == 'up' then
      snake[1].y = snake[1].y - TILE_SIZE
      snakeDirection = 'up'
    elseif nextSnakeDirection == 'down' then
      snake[1].y = snake[1].y + TILE_SIZE
      snakeDirection = 'down'
    end

    if snake[1].y < HUD_HEIGHT then
      snake[1].y = windowHeight - TILE_SIZE
    elseif snake[1].y >= windowHeight then
      snake[1].y = HUD_HEIGHT
    elseif snake[1].x < 0 then
      snake[1].x = windowWidth - TILE_SIZE
    elseif snake[1].x >= windowWidth then
      snake[1].x = 0
    end

    frame = 0
  end

  if score >= 100 then
    sceneManager.changeScene(require 'src/winTheGame')
  end
end

function snake.draw( ... )
  utils.clearScreen()

  for key, snake_part in ipairs(snake) do
    love.graphics.setColor(colors.black)
    love.graphics.rectangle(
      'fill',
      snake_part.x,
      snake_part.y,
      TILE_SIZE,
      TILE_SIZE
    )
  end

  for key, snake_part in ipairs(snake) do
    love.graphics.setColor(colors.white)
    love.graphics.rectangle(
      'line',
      snake_part.x,
      snake_part.y,
      TILE_SIZE,
      TILE_SIZE
    )
  end

  love.graphics.setColor(colors.black)
  love.graphics.rectangle(
    'fill',
    0,
    0,
    windowWidth,
    HUD_HEIGHT
  )

  love.graphics.setColor(colors.white)
  love.graphics.print('SCORE: ' .. score .. '/100', 280, 0 )
  love.graphics.line(0, HUD_HEIGHT, windowWidth, HUD_HEIGHT)
end

function snake.keypressed( key )
  if snakeDirection ~= 'left' and snakeDirection ~= 'right' and (key == 'd' or key == 'right') then
    nextSnakeDirection = 'right'
  elseif snakeDirection ~= 'right' and snakeDirection ~= 'left' and (key == 'a' or key == 'left') then
    nextSnakeDirection = 'left'
  elseif snakeDirection ~= 'down' and snakeDirection ~= 'up' and (key == 'w' or key == 'up') then
    nextSnakeDirection = 'up'
  elseif snakeDirection ~= 'up' and snakeDirection ~= 'down' and (key == 's' or key == 'down') then
    nextSnakeDirection = 'down'
  end

  if key == 'escape' then
    love.event.quit(0)
  end
end

return snake
