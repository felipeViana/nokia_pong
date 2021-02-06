local colors = require 'colors'
local utils = require 'utils'
local sceneManager = require 'src/sceneManager'
local soundManager = require 'soundManager'

local pong = {}

local selectSound = love.audio.newSource("assets/sfx/hit5.wav", "static")

local playerY = 70
local playerSpeedY = 0

local enemyY = 70

local PAD_SPEED = 150
local PAD_WIDTH = 20
local PAD_HEIGHT = 100

local playerScore = 3
local enemyScore = 1

function pong.load( ... )
  -- body
end

function pong.update( dt )
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
  if playerY > 140 then
    playerY = 140
  end
end

function pong.draw( ... )
  utils.clearScreen()

  love.graphics.print(tostring(playerScore) .. " x " .. tostring(enemyScore), 180, 10)

  love.graphics.rectangle(
    'fill',
    50,
    playerY,
    PAD_WIDTH,
    PAD_HEIGHT
  )

  love.graphics.rectangle(
    'fill',
    70,
    120,
    14,
    14
  )

  love.graphics.rectangle(
    'fill',
    340,
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
