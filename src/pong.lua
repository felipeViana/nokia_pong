local colors = require 'colors'
local utils = require 'utils'
local sceneManager = require 'src/sceneManager'
local soundManager = require 'soundManager'

local pong = {}

local selectSound = love.audio.newSource("assets/sfx/hit5.wav", "static")

local PAD_SPEED = 150
local PAD_WIDTH = 20
local PAD_HEIGHT = 100

local playerX = 50
local playerY = 70
local playerSpeedY = 0

local enemyX = windowWidth - PAD_WIDTH - 50
local enemyY = 70
local enemySpeedY = 0

local playerScore = 0
local enemyScore = 0

local BALL_STARTING_SPEED_X = 100
local BALL_STARTING_SPEED_Y = 70
local ballX = 70
local ballY = 120
local ballSpeedX = BALL_STARTING_SPEED_X
local ballSpeedY =  - BALL_STARTING_SPEED_Y
local BALL_SIZE = 14

local BALL_SPEED_INCREASE_FACTOR = 1.3

function pong.load( ... )
  -- body
end

local function centerBall()
  ballX = windowWidth / 2 - BALL_SIZE / 2
  ballY = windowHeight / 2 - BALL_SIZE / 2

  if ballSpeedX > 0 then
    ballSpeedX = - BALL_STARTING_SPEED_X
  else
    ballSpeedX = BALL_STARTING_SPEED_X
  end

  if ballSpeedY > 0 then
    ballSpeedY = - BALL_STARTING_SPEED_Y
  else
    ballSpeedY = BALL_STARTING_SPEED_Y
  end
end

function pong.update( dt )
  -- player
  if love.keyboard.isDown('up', 'w') and love.keyboard.isDown('down', 's') then
    playerSpeedY = 0
  elseif love.keyboard.isDown('up', 'w') then
    playerSpeedY = - PAD_SPEED
  elseif love.keyboard.isDown('down', 's') then
    playerSpeedY = PAD_SPEED
  else
    playerSpeedY = 0
  end

  playerY = playerY + playerSpeedY * dt

  if playerY < 0 then
    playerY = 0
  end
  if playerY > windowHeight - PAD_HEIGHT then
    playerY = windowHeight - PAD_HEIGHT
  end

  -- ball
  if ballY < 0 and ballSpeedY < 0 then
    ballSpeedY = - ballSpeedY
  end
  if ballY > windowHeight - BALL_SIZE and ballSpeedY > 0 then
    ballSpeedY = - ballSpeedY
  end

  local nextBallX = ballX + ballSpeedX * dt
  local nextBallY = ballY + ballSpeedY * dt

  -- colliding with enemy
  if ballSpeedX > 0 and nextBallX + BALL_SIZE >= enemyX and nextBallX + BALL_SIZE <= enemyX + PAD_WIDTH then
    if nextBallY >= enemyY - BALL_SIZE and nextBallY <= enemyY + PAD_HEIGHT then
      ballSpeedX = - (ballSpeedX * BALL_SPEED_INCREASE_FACTOR)
      ballSpeedY = (ballSpeedY - enemySpeedY / 3) * BALL_SPEED_INCREASE_FACTOR
    end
  end

  -- colliding with player
  if ballSpeedX < 0 and nextBallX <= playerX + PAD_WIDTH and nextBallX >= playerX  then
    if nextBallY >= playerY - BALL_SIZE and nextBallY <= playerY + PAD_HEIGHT then
      ballSpeedX = - (ballSpeedX * BALL_SPEED_INCREASE_FACTOR)
      ballSpeedY = (ballSpeedY - playerSpeedY / 3) * BALL_SPEED_INCREASE_FACTOR
    end
  end

  -- AI movement
  if ballSpeedX > 0 and ballX > windowWidth / 2 then
    if ballY + BALL_SIZE / 2 > enemyY + PAD_HEIGHT / 2 then
      enemySpeedY = PAD_SPEED
    else
      enemySpeedY = - PAD_SPEED
    end
  else
    enemySpeedY = 0
  end

  enemyY = enemyY + enemySpeedY * dt
  if enemyY < 0 then
    enemyY = 0
  end
  if enemyY > windowHeight - PAD_HEIGHT then
    enemyY = windowHeight - PAD_HEIGHT
  end


  ballX = nextBallX
  ballY = nextBallY

  -- ball goes out
  if ballX > windowWidth then
    playerScore = playerScore + 1
    centerBall()
  end

  if ballX < 0 - BALL_SIZE then
    enemyScore = enemyScore + 1
    centerBall()
  end

  if playerScore > 2 then
    sceneManager.changeScene(require 'src/shooter')
  end
end

function pong.draw( ... )
  utils.clearScreen()

  love.graphics.print(tostring(playerScore) .. " x " .. tostring(enemyScore), 180, 10)

  love.graphics.rectangle(
    'fill',
    playerX,
    playerY,
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

  love.graphics.rectangle(
    'fill',
    enemyX,
    enemyY,
    PAD_WIDTH,
    PAD_HEIGHT
  )
end

function pong.keypressed( key )
  if key == 'escape' then
    love.event.quit(0)
  end
end

return pong
