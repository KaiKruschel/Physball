require "src/helpers"
require "src/paddle"
require "src/ball"
require "src/boundaries"
require "keys"

function love.load()

  -- settings
  keyboard = {}
  set_keyboard(keyboard)

  -- screen
  screen_width, screen_height = love.window.getMode()

  -- score
  font = love.graphics.newFont(20) -- with only one argument, only the size is specified
                                   -- otherwise it would be love.graphics.newFont(file, size)
  score = {0; 0}

  do_reset = false

	Gamestate = require "lib/hump.gamestate"

	require "src/menu"
	require "src/game"
	require "src/pause"

  -- set up physics
  love.physics.setMeter(20)
  world = love.physics.newWorld(0, 0, false) -- horizontal gravity, vertical gravity and wether objects are allowed to sleep
  world:setCallbacks( scoring ) -- scoring is a callback that gets called whenever a collision happens

  -- paddles
  paddle1 = Paddle:new(1, {255, 255, 255})
  paddle2 = Paddle:new(2, {0, 0, 0})

  -- ball
  ball = Ball:new({0, 0, 255})


  -- boundaries
  boundaries = Boundaries:new({50, 50, 50})

  -- initial graphics setup
  love.graphics.setBackgroundColor(104, 136, 248)
  print("Pong init")

end

function love.draw()

 -- local joysticks = love.joystick.getJoysticks()
 -- for i, joystick in ipairs(joysticks) do
 --   love.graphics.print(joystick:getName(), 10, i * 20)
 -- end


  -- paddle
  paddle1:draw()
  paddle2:draw()

  -- ball
  ball:draw()

  -- boundaries
  boundaries:draw()

  -- score
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(font)
  love.graphics.print(("Player 1: " .. score[1] .. " Player 2: " .. score[2]), 300, 20)
end

function love.update(dt)

  world:update(dt)
  if do_reset then
    reset()
    do_reset = false
  end

  -- paddles
  paddle1:update()
  paddle2:update()


end
