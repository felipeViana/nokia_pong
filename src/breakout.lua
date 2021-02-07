local colors = require 'colors'
local utils = require 'utils'
local sceneManager = require 'src/sceneManager'
local soundManager = require 'soundManager'

local breakout = {}

local selectSound = love.audio.newSource("assets/sfx/hit5.wav", "static")
local hitSound = love.audio.newSource("assets/sfx/blip4.wav", "static")
local padHitSound = love.audio.newSource("assets/sfx/blip8.wav", "static")
local brickHitSound = love.audio.newSource("assets/sfx/good3.wav", "static")

local lives = 3

local PAD_SPEED = 250
local PAD_WIDTH = 80
local PAD_HEIGHT = 10
local padX = 170
local padY = 220
local padVelocity = 0

local BALL_SIZE = 10
local ballX = 205
local ballY = 190
local ballVelocityX = - 100
local ballVelocityY = - 100

local BRICK_WIDTH = 80
local BRICK_HEIGHT = 20
local bricks = {}

function breakout.load( ... )
  lives = 3
  padX = 170
  padY = 220
  padVelocity = 0

  ballX = 205
  ballY = 210
  ballVelocityX = - 100
  ballVelocityY = - 100

  -- revive bricks
  bricks = {}
  for x = 50, 320, BRICK_WIDTH do
    for y = 40, 120, BRICK_HEIGHT do
      table.insert(bricks, {["x"] = x, ['y'] = y})
    end
  end
end

local function collideBallRectangle( ballX, ballY, nextBallX, nextBallY, recX, recY, recWidth, recHeigth )
  local nextBallCenterX = nextBallX + BALL_SIZE / 2
  local nextBallCenterY = nextBallY + BALL_SIZE / 2

  local ballCenterX = ballX + BALL_SIZE / 2
  local ballCenterY = ballY + BALL_SIZE / 2

  -- check if ball is going inside the rectangle
  if nextBallCenterX >= recX and nextBallCenterX <= recX + recWidth and
  nextBallCenterY >= recY and nextBallCenterY <= recY + recHeigth then
    local x = false
    local y = false

    if ballCenterX < recX or ballCenterX > recX + recWidth then
      -- ballVelocityX = - ballVelocityX
      x = true
    end

    if ballCenterY < recY or ballCenterY > recY + recHeigth then
      -- ballVelocityY = - ballVelocityY
      y = true
    end

    return {['x'] = x, ['y'] = y}
  end

  return false
end

local function resetBall( ... )
  ballX = 205
  ballY = 210
  ballVelocityX = - 100
  ballVelocityY = - 100
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
  if padX > windowWidth - PAD_WIDTH then
    padX = windowWidth - PAD_WIDTH
  end
  if padX < 0 then
    padX = 0
  end

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
    lives = lives - 1
    resetBall()
  end

  -- ball colliding with player pad
  local padCollided = collideBallRectangle(ballX, ballY, nextBallX, nextBallY, padX - 5, padY + 5, PAD_WIDTH + 10, PAD_HEIGHT + 5)
  if padCollided  then
    soundManager.play(padHitSound)
    if padCollided.x then
      ballVelocityX = - ballVelocityX
    end
    if padCollided.y then
      ballVelocityY = - ballVelocityY
      ballVelocityX = ballVelocityX - padVelocity / 4
    end
  end

  -- ball colliding with bricks
  local collidedBricks = {}
  local shouldTurnX = false
  local shouldTurnY = false

  for key, brick in ipairs(bricks) do
    local collided = collideBallRectangle(ballX, ballY, nextBallX, nextBallY, brick.x - 5, brick.y - 5, BRICK_WIDTH + 10, BRICK_HEIGHT + 10)
    if collided then
      soundManager.play(brickHitSound)
      table.insert(collidedBricks, key)

      shouldTurnX = shouldTurnX or collided.x
      shouldTurnY = shouldTurnY or collided.y
    end
  end
  if shouldTurnX then
    ballVelocityX = - ballVelocityX
  end
  if shouldTurnY then
    ballVelocityY = - ballVelocityY
  end

  for i = #collidedBricks, 1, -1 do
    table.remove(bricks, collidedBricks[i])
  end

  ballVelocityX = utils.clamp(ballVelocityX, -3000, 3000)

  ballX = ballX + ballVelocityX * dt
  ballY = ballY + ballVelocityY * dt

  if lives < 1 then
    sceneManager.changeScene(require 'src/gameOver', 'breakout')
  end

  if #bricks < 1 then
    sceneManager.changeScene(require 'src/winTheGame')
  end
end

function breakout.draw( ... )
  utils.clearScreen()

  love.graphics.print("LIVES: " .. lives - 1, 5, 0)

  for key, brick in ipairs(bricks) do
    love.graphics.rectangle(
      'line',
      brick.x,
      brick.y,
      BRICK_WIDTH,
      BRICK_HEIGHT
    )
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
