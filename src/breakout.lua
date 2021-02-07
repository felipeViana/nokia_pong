local colors = require 'colors'
local utils = require 'utils'
local sceneManager = require 'src/sceneManager'
local soundManager = require 'soundManager'

local breakout = {}

local selectSound = love.audio.newSource("assets/sfx/hit5.wav", "static")
local hitSound = love.audio.newSource("assets/sfx/blip4.wav", "static")

local PAD_SPEED = 200
local PAD_WIDTH = 80
local PAD_HEIGHT = 10
local padX = 170
local padY = 200
local padVelocity = 0

local BALL_SIZE = 10
local ballX = 205
local ballY = 190
local ballVelocityX = - 100
local ballVelocityY = - 100

local BRICK_WIDTH = 80
local BRICK_HEIGHT = 20
-- brick table

function breakout.load( ... )
  padX = 170
  padY = 200
  padVelocity = 0

  ballX = 205
  ballY = 190
  ballVelocityX = - 100
  ballVelocityY = - 100

  -- revive bricks
end

local function collideBallRectangle( nextBallX, nextBallY, recX, recY, recWidth, recHeigth )
  local nextBallCenterX = nextBallX + BALL_SIZE / 2
  local nextBallCenterY = nextBallY + BALL_SIZE / 2

  local ballCenterX = ballX + BALL_SIZE / 2
  local ballCenterY = ballY + BALL_SIZE / 2

  -- check if ball is going inside the rectangle
  if nextBallCenterX >= recX and nextBallCenterX <= recX + recWidth and
  nextBallCenterY >= recY and nextBallCenterY <= recY + recHeigth then
    if ballCenterX < recX or ballCenterX > recX + recWidth then
      ballVelocityX = - ballVelocityX
    end

    if ballCenterY < recY or ballCenterY > recY + recHeigth then
      ballVelocityY = - ballVelocityY
    end

    return true
  end

  return false
end

function breakout.update( dt )
  -- player
  if love.keyboard.isDown('right', 'd') and love.keyboard.isDown('left', 'a') then
    padVelocity = 0
  elseif love.keyboard.isDown('left', 'a') then
    padVelocity = - PAD_SPEED
  elseif love.keyboard.isDown('right', 'd') then
    padVelocity = PAD_SPEED
  else
    padVelocity = 0
  end

  padX = padX + padVelocity * dt

  local nextBallX = ballX + ballVelocityX * dt
  local nextBallY = ballY + ballVelocityY * dt


  -- ball colliding with walls
  if nextBallY < 0 then
    ballVelocityY = - ballVelocityY
    soundManager.play(hitSound)
  end
  if nextBallX + BALL_SIZE > windowWidth then
    ballVelocityX = - ballVelocityX
    soundManager.play(hitSound)
  end
  if nextBallX < 0 then
    ballVelocityX = - ballVelocityX
    soundManager.play(hitSound)
  end
  if nextBallY > windowHeight then
    sceneManager.changeScene(require 'src/gameOver', 'breakout')
  end

  -- ball colliding with player pad
  collideBallRectangle(nextBallX, nextBallY, padX - 5, padY - 5, PAD_WIDTH + 10, PAD_HEIGHT + 10)

  -- ball colliding with bricks



  ballX = ballX + ballVelocityX * dt
  ballY = ballY + ballVelocityY * dt
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
  if key == 'escape' then
    love.event.quit(0)
  end
end

return breakout
