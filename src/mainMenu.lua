local colors = require 'colors'
local utils = require 'utils'
local sceneManager = require 'src/sceneManager'
local soundManager = require 'soundManager'

local mainMenu = {}

local selectSound = love.audio.newSource("assets/sfx/hit5.wav", "static")
local changeSound = love.audio.newSource("assets/sfx/blip1.wav", "static")

local selectedButton = 0
local TOTAL_BUTTONS = 3

local BUTTON_WIDTH = 130
local BUTTON_HEIGHT = 40
local BUTTON_RECTANGLE_X = 140

local BUTTON_1_Y = 80

function mainMenu.load( ... )
  -- body
end

function mainMenu.update( dt )
end

function mainMenu.draw( ... )
  utils.clearScreen()

  love.graphics.setColor(colors.black)
  love.graphics.print("Nokia Pong", 150, 10)

  if selectedButton == 0 then
    love.graphics.rectangle(
      "line",
      BUTTON_RECTANGLE_X,
      BUTTON_1_Y,
      BUTTON_WIDTH,
      BUTTON_HEIGHT
    )
  end
  love.graphics.print("START GAME", 150, BUTTON_1_Y)


  if selectedButton == 1 then
    love.graphics.rectangle(
      "line",
      BUTTON_RECTANGLE_X,
      BUTTON_1_Y + 50,
      BUTTON_WIDTH,
      BUTTON_HEIGHT
    )
  end
  love.graphics.print("CREDITS", 165, BUTTON_1_Y + 50)

  if selectedButton == 2 then
    love.graphics.rectangle(
      "line",
      BUTTON_RECTANGLE_X,
      BUTTON_1_Y + 50 * 2,
      BUTTON_WIDTH,
      BUTTON_HEIGHT
    )
  end
  love.graphics.print("EXIT", 185, BUTTON_1_Y + 50 * 2)
end

function mainMenu.keypressed(key)
  if key == 'space' or key == 'return' then
    soundManager.playSound(selectSound)

    if selectedButton == 0 then
      sceneManager.changeScene(require 'src/pong')
    elseif selectedButton == 1 then
      sceneManager.changeScene(require 'src/credits')
    elseif selectedButton == 2 then
      love.event.quit(0)
    end
  end

  if key == 'up' or key == 'w' then
    selectedButton = (selectedButton + TOTAL_BUTTONS - 1) % TOTAL_BUTTONS
    soundManager.playSound(changeSound)
  end

  if key == 'down' or key == 's' then
    selectedButton = (selectedButton + 1) % TOTAL_BUTTONS
    soundManager.playSound(changeSound)
  end
end

return mainMenu
