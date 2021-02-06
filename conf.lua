NOKIA_WIDTH = 84
NOKIA_HEIGHT = 48
SCALING_FACTOR = 5
windowWidth = NOKIA_WIDTH * SCALING_FACTOR
windowHeight = NOKIA_HEIGHT * SCALING_FACTOR

function love.conf(t)
  t.identity = nil -- save directory (string)
  t.author = 'felipeViana'
  t.accelerometerjoystick = false
  t.title = "Nokia Pong"
  t.version = "11.3"
  t.console = true

  t.window.width = windowWidth
  t.window.height = windowHeight
  t.window.fullscreen = false
  -- t.window.icon = "assets/logo.png"
  t.window.borderless = false
  t.window.resizable = false

  t.modules.audio = true
  t.modules.event = true
  t.modules.font = true
  t.modules.graphics = true
  t.modules.keyboard = true
  t.modules.math = true
  t.modules.sound = true
  t.modules.timer = true
  t.modules.window = true
  t.modules.image = true
  t.modules.data = false
  t.modules.joystick = false
  t.modules.mouse = false
  t.modules.physics = false
  t.modules.system = false
  t.modules.thread = false
  t.modules.touch = false
  t.modules.video = false
end
