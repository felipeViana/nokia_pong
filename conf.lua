SCALING_FACTOR = 4

function love.conf(t)
  t.identity = nil -- save directory (string)
  t.author = 'felipeViana'
  t.accelerometerjoystick = false
  t.title = "Game name"
  t.version = "11.3"
  t.console = true

  t.window.width = 84 * SCALING_FACTOR
  t.window.height = 48 * SCALING_FACTOR
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
  t.modules.image = false
  t.modules.data = false
  t.modules.joystick = false
  t.modules.mouse = false
  t.modules.physics = false
  t.modules.system = false
  t.modules.thread = false
  t.modules.touch = false
  t.modules.video = false
end
