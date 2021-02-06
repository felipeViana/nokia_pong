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

local playerScore = 0
local enemyScore = 0

local ballX = 70
local ballY = 120
local ballSpeedX = 150
local ballSpeedY =  - 150
local BALL_SIZE = 14

function pong.load( ... )
  -- body
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
  ballX = ballX + ballSpeedX * dt
  ballY = ballY + ballSpeedY * dt

  if ballY < 0 and ballSpeedY < 0 then
    ballSpeedY = - ballSpeedY
  end
  if ballY > windowHeight - BALL_SIZE and ballSpeedY > 0 then
    ballSpeedY = - ballSpeedY
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
    14,
    14
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
