local colors = require 'colors'
local utils = require 'utils'
local sceneManager = require 'src/sceneManager'
local soundManager = require 'soundManager'

local mainMenu = {}

local selectSound = love.audio.newSource("assets/sfx/hit5.wav", "static")
local changeSound = love.audio.newSource("assets/sfx/hit6.wav", "static")

local selectedButton = 0
local TOTAL_BUTTONS = 2

local BUTTON_WIDTH = 130
local BUTTON_HEIGHT = 40

function mainMenu.load( ... )
  -- body
end

function mainMenu.update( dt )
end

function mainMenu.draw( ... )
  utils.clearScreen()

  love.graphics.setColor(colors.black)
  love.graphics.print("Nokia Pong", 150, 30)

  if selectedButton == 0 then
    love.graphics.rectangle(
      "line",
      140,
      120,
      BUTTON_WIDTH,
      BUTTON_HEIGHT
    )
  end
  love.graphics.print("START GAME", 150, 120)


  if selectedButton == 1 then
    love.graphics.rectangle(
      "line",
      140,
      170,
      BUTTON_WIDTH,
      BUTTON_HEIGHT
    )
  end
  love.graphics.print("EXIT", 185, 170)
end

function mainMenu.keypressed(key)
  if key == 'space' then
    soundManager.playSound(selectSound)
    sceneManager.changeScene(require 'src/pong')
  end

  if key == 'escape' then
    love.event.quit(0)
  end

  if key == 'up' or key == 'w' then
    selectedButton = (selectedButton + 1) % TOTAL_BUTTONS
    soundManager.playSound(changeSound)
  end

  if key == 'down' or key == 's' then
    selectedButton = (selectedButton + TOTAL_BUTTONS - 1) % TOTAL_BUTTONS
    soundManager.playSound(changeSound)
  end
end

return mainMenu
