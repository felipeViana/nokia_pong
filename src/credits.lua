local colors = require 'colors'
local utils = require 'utils'
local sceneManager = require 'src/sceneManager'
local soundManager = require 'soundManager'

local credits = {}

local BUTTON_WIDTH = 130
local BUTTON_HEIGHT = 40
local BUTTON_RECTANGLE_X = 140

local selectSound = love.audio.newSource("assets/sfx/hit5.wav", "static")

function credits.load( ... )
  -- body
end

function credits.update( dt )
  -- body
end

function credits.draw( ... )
  utils.clearScreen()

  love.graphics.setColor(colors.black)
  love.graphics.print("CREDITS", 165, 10)


  love.graphics.print("author: Felipe Viana (Flash)", 50, 60)
  love.graphics.print("Fonts: Efforts Pro by @somepx", 50, 90)
  love.graphics.print("sfx: nokia 3310 soundpack by @Trix", 50, 120)


  love.graphics.rectangle(
    "line",
    BUTTON_RECTANGLE_X,
    180,
    BUTTON_WIDTH,
    BUTTON_HEIGHT
  )
  love.graphics.print("BACK", 180, 180)
end

function credits.keypressed( key )
  if key == 'space' or key == 'return' then
    soundManager.playSound(selectSound)
    sceneManager.changeScene(require 'src/mainMenu')
  end

  if key == 'escape' then
    love.event.quit(0)
  end
end

return credits
