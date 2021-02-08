local sceneManager = require 'src/sceneManager'

local defaultFont = love.graphics.newFont(
  'assets/fonts/EffortsPro.ttf', 36
)

function love.load( ... )
  love.graphics.setFont(defaultFont)
  sceneManager.changeScene(require 'src/mainMenu')
end


function love.update(dt)
  sceneManager.currentScene.update(dt)
end

function love.draw()
  sceneManager.draw()
end

function love.keypressed(key)
  sceneManager.currentScene.keypressed(key)
end
