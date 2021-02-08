local colors = require 'colors'
local utils = require 'utils'
local sceneManager = require 'src/sceneManager'
local soundManager = require 'soundManager'

local snake = {}

local selectSound = love.audio.newSource("assets/sfx/hit5.wav", "static")

local snakeX = 50
local snakeY = 50

local TILE_SIZE = 10

local frame = 0
local CYCLE_TIME = 15

function snake.load( ... )
  -- body
end

function snake.update( dt )
  frame = frame + 1

  if frame == CYCLE_TIME then
    snakeX = snakeX + TILE_SIZE
    frame = 0
  end
end

function snake.draw( ... )
  utils.clearScreen()

  love.graphics.setColor(colors.black)
  love.graphics.rectangle(
    'fill',
    snakeX,
    snakeY,
    TILE_SIZE,
    TILE_SIZE
  )
  love.graphics.rectangle(
    'fill',
    snakeX - TILE_SIZE,
    snakeY,
    TILE_SIZE,
    TILE_SIZE
  )
  love.graphics.rectangle(
    'fill',
    snakeX - TILE_SIZE * 2,
    snakeY,
    TILE_SIZE,
    TILE_SIZE
  )

  love.graphics.setColor(colors.white)
  love.graphics.rectangle(
    'line',
    snakeX,
    snakeY,
    TILE_SIZE,
    TILE_SIZE
  )
  love.graphics.rectangle(
    'line',
    snakeX - TILE_SIZE,
    snakeY,
    TILE_SIZE,
    TILE_SIZE
  )
  love.graphics.rectangle(
    'line',
    snakeX - TILE_SIZE * 2,
    snakeY,
    TILE_SIZE,
    TILE_SIZE
  )
end

function snake.keypressed( key )
  if key == 'escape' then
    love.event.quit(0)
  end
end

return snake
