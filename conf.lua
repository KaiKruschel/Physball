function love.conf(t)
  t.modules.joystick  = true       -- enable joystick and Gamepad Support
  t.modules.audio     = false      -- enable audio
  t.modules.keyboard  = true       -- enable keyboard
  t.modules.event     = true       -- enable event module(os events)
  t.modules.image     = false      -- enable image module
  t.modules.graphics  = true       -- enable graphics module
  t.modules.timer     = true
  t.modules.mouse     = true
  t.modules.sound     = false      -- different from audio
  t.modules.thread    = true       -- multithreading support ???
  t.modules.physics   = true       -- enable physics module
  t.modules.window    = true

  t.window.title      = "Pong 4"   -- the game's title
  t.author            = "exPileo"  -- the game's author
  t.identity          = "./saves"

  t.window.fullscreen = false
  t.window.vsync      = false      -- enable vertical sync
  t.window.fsaa       = 0          -- number of fsaa buffers
  t.window.width      = 800
  t.window.height     = 600
end
