local colors = require 'colors'
local utils = require 'utils'
local sceneManager = require 'src/sceneManager'
local soundManager = require 'soundManager'
local pong = require 'src/pong'

local gameOver = {}

local BUTTON_WIDTH = 130
local BUTTON_HEIGHT = 40
local BUTTON_RECTANGLE_X = 140
local BUTTON_Y = 120

local selectSound = love.audio.newSource("assets/sfx/hit5.wav", "static")
local gameOverSound = love.audio.newSource("assets/sfx/negative1.wav", "static")

local currentGame = ''

function gameOver.load( game )
  currentGame = game

  soundManager.play(gameOverSound)
end

function gameOver.update( dt )
  -- body
end

function gameOver.draw( ... )
  utils.clearScreen()

  love.graphics.print("GAME OVER", 150, 10)

  love.graphics.rectangle(
    "line",
    BUTTON_RECTANGLE_X,
    BUTTON_Y,
    BUTTON_WIDTH,
    BUTTON_HEIGHT
  )
  love.graphics.print("TRY AGAIN", 160, BUTTON_Y)
end

function gameOver.keypressed( key )
  if key == 'space' then
    soundManager.play(selectSound)

    if currentGame == 'pong' then
      sceneManager.changeScene(pong)
    end
  end
end

return gameOver
