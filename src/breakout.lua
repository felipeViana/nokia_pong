local colors = require 'colors'
local utils = require 'utils'
local sceneManager = require 'src/sceneManager'
local soundManager = require 'soundManager'

local breakout = {}

local selectSound = love.audio.newSource("assets/sfx/hit5.wav", "static")

local PAD_SPEED = 200
local PAD_WIDTH = 80
local PAD_HEIGHT = 10
local padX = 170
local padY = 200
local padCurrentVelocity = 0

local BALL_SIZE = 10
local ballX = 205
local ballY = 190
local ballCurrentVelocityX = - 100
local ballCurrentVelocityY = - 100

local BRICK_WIDTH = 80
local BRICK_HEIGHT = 20

function breakout.load( ... )
  -- body
end

function breakout.update( dt )
  -- player
  if love.keyboard.isDown('right', 'd') and love.keyboard.isDown('left', 'a') then
    padCurrentVelocity = 0
  elseif love.keyboard.isDown('left', 'a') then
    padCurrentVelocity = - PAD_SPEED
  elseif love.keyboard.isDown('right', 'd') then
    padCurrentVelocity = PAD_SPEED
  else
    padCurrentVelocity = 0
  end

  padX = padX + padCurrentVelocity * dt

  local nextBallX = ballX + ballCurrentVelocityX * dt
  local nextBallY = ballY + ballCurrentVelocityY * dt


  -- ball colliding with walls
  if nextBallY < 0 then
    ballCurrentVelocityY = - ballCurrentVelocityY
  end

  if nextBallX + BALL_SIZE > windowWidth then
    ballCurrentVelocityX = - ballCurrentVelocityX
  end

  if nextBallX < 0 then
    ballCurrentVelocityX = - ballCurrentVelocityX
  end

  -- ball colliding with player pad


  ballX = ballX + ballCurrentVelocityX * dt
  ballY = ballY + ballCurrentVelocityY * dt
end

function breakout.draw( ... )
  utils.clearScreen()

  for x = 50, 320, BRICK_WIDTH do
    for y = 30, 110, BRICK_HEIGHT do
      love.graphics.rectangle(
        'line',
        x,
        y,
        BRICK_WIDTH,
        BRICK_HEIGHT
      )
    end
  end

  love.graphics.rectangle(
    'fill',
    padX,
    padY,
    PAD_WIDTH,
    PAD_HEIGHT
  )

  love.graphics.rectangle(
    'fill',
    ballX,
    ballY,
    BALL_SIZE,
    BALL_SIZE
  )
end

function breakout.keypressed( key )
  if key == 'space' then
    -- soundManager.play(selectSound)
    -- sceneManager.changeScene(require 'src/snake')
  end

  if key == 'escape' then
    love.event.quit(0)
  end
end

return breakout
