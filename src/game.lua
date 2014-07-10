game = {}

function game:init()

	score = {0; 0}
  do_reset = false

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

end

function game:update(dt)

 -- local joysticks = love.joystick.getJoysticks()
 -- for i, joystick in ipairs(joysticks) do
 --   love.graphics.print(joystick:getName(), 10, i * 20)
 -- end

	 world:update(dt)

  if do_reset then
    reset()
    do_reset = false
  end

  -- paddles
  paddle1:update()
  paddle2:update()

end

function game:keyreleased(key, code)
	if (key == 'escape') then
		Gamestate.switch(pause)
	end
end

function game:draw()

  love.graphics.setBackgroundColor(0, 204, 0)

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
