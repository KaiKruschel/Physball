function love.load()

  -- screen
  screen_width = 800
  screen_height = 600

  -- paddle
  paddle_width = 20
  paddle_height = 80
  paddle_pos1 = (screen_height - paddle_height) / 2
  paddle_pos2 = (screen_height - paddle_height) / 2
  paddle_speed = 10

  -- ball
  ball_radius = 10
  ball_speed = {x = 10; y = 10}
  ball_pos = {x = 400; y = 300}

  -- score
  font = love.graphics.newFont(20) -- with only one argument, only the size is specified
                                   -- otherwise it would be love.graphics.newFont(file, size)
  score = {0; 0}

  do_reset = false


  -- set up physics
  love.physics.setMeter(20)
  world = love.physics.newWorld(0, 0, false) -- horizontal gravity, vertical gravity and wether objects are allowed to sleep
  world:setCallbacks( scoring ) -- scoring is a callback that gets called whenever a collision happens

  objects = {}

    -- paddles
    objects.paddle1 = {}
    objects.paddle1.body = love.physics.newBody(world, 20, screen_height/2, "dynamic")
    objects.paddle1.shape = love.physics.newRectangleShape(paddle_width, paddle_height)
    objects.paddle1.fixture = love.physics.newFixture(objects.paddle1.body, objects.paddle1.shape, 10)
    objects.paddle1.fixture:setRestitution(0.4)
    objects.paddle1.fixture:setCategory(1) -- put it in the paddle category
    objects.paddle1.body:setAngularDamping(1.5) -- how fast spinning stops
    objects.paddle1.body:setLinearDamping(0.8) -- how fast directional movement stops

    objects.paddle2 = {}
    objects.paddle2.body = love.physics.newBody(world, screen_width - 20, screen_height/2, "dynamic")
    objects.paddle2.shape = love.physics.newRectangleShape(paddle_width, paddle_height)
    objects.paddle2.fixture = love.physics.newFixture(objects.paddle2.body, objects.paddle2.shape, 10)
    objects.paddle2.fixture:setRestitution(0.4)
    objects.paddle2.fixture:setCategory(1)
    objects.paddle2.body:setAngularDamping(1.5) -- how fast spinning stops
    objects.paddle2.body:setLinearDamping(0.8) -- how fast directional movement stops

    -- ball
    objects.ball = {}
    objects.ball.body = love.physics.newBody(world, screen_width/2, screen_height/2, "dynamic")
    objects.ball.shape = love.physics.newCircleShape(ball_radius)
    objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1)
    objects.ball.fixture:setRestitution(0.9) -- bouncyness
    objects.ball.fixture:setCategory(2) -- ball category


    -- boundaries
    objects.top = {}
    objects.top.body = love.physics.newBody(world, screen_width/2, 0, "static")
    objects.top.shape = love.physics.newRectangleShape(screen_width, 5)
    objects.top.fixture = love.physics.newFixture(objects.top.body, objects.top.shape)
    objects.top.fixture:setCategory(3)

    objects.bottom = {}
    objects.bottom.body = love.physics.newBody(world, screen_width/2, screen_height, "static")
    objects.bottom.shape = love.physics.newRectangleShape(screen_width, 5)
    objects.bottom.fixture = love.physics.newFixture(objects.bottom.body, objects.bottom.shape)
    objects.bottom.fixture:setCategory(3)

    objects.left = {}
    objects.left.body = love.physics.newBody(world, 0, screen_height/2, "static")
    objects.left.shape = love.physics.newRectangleShape(5, screen_height)
    objects.left.fixture = love.physics.newFixture(objects.left.body, objects.left.shape)
    objects.left.fixture:setCategory(4)

    objects.right = {}
    objects.right.body = love.physics.newBody(world, screen_width, screen_height/2, "static")
    objects.right.shape = love.physics.newRectangleShape(5, screen_height)
    objects.right.fixture = love.physics.newFixture(objects.right.body, objects.right.shape)
    objects.right.fixture:setCategory(5)

  -- initial graphics setup
  love.graphics.setBackgroundColor(104, 136, 248)
  love.window.setMode(800, 600)
  print("Pong init")

end

function love.draw()


  -- paddle 1
  love.graphics.setColor(255, 255, 255)
  love.graphics.polygon("fill", objects.paddle1.body:getWorldPoints(objects.paddle1.shape:getPoints()))

  -- paddle 2
  love.graphics.setColor(0, 0, 0)
  love.graphics.polygon("fill", objects.paddle2.body:getWorldPoints(objects.paddle2.shape:getPoints()))

  -- ball
  love.graphics.setColor(0, 0, 255)
  love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())

  -- boundaries
  love.graphics.setColor(0, 0, 0)
  love.graphics.polygon("fill", objects.top.body:getWorldPoints(objects.top.shape:getPoints()))
  love.graphics.polygon("fill", objects.bottom.body:getWorldPoints(objects.bottom.shape:getPoints()))
  love.graphics.polygon("fill", objects.left.body:getWorldPoints(objects.left.shape:getPoints()))
  love.graphics.polygon("fill", objects.right.body:getWorldPoints(objects.right.shape:getPoints()))

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

  -- paddle 1
  if love.keyboard.isDown("w") then
    objects.paddle1.body:applyForce(0, -8000)
  elseif love.keyboard.isDown("s") then
    objects.paddle1.body:applyForce(0, 8000)
  end
  if love.keyboard.isDown("a") then
    objects.paddle1.body:applyForce(-8000, 0)
  elseif love.keyboard.isDown("d") then
    objects.paddle1.body:applyForce(8000, 0)
  end
  if love.keyboard.isDown("q") then
    objects.paddle1.body:applyTorque(-60000) -- twist it counter clockwise
  elseif love.keyboard.isDown("e") then
    objects.paddle1.body:applyTorque(60000) -- twist clockwise
  end

  -- paddle 2
  if love.keyboard.isDown("up") then
    objects.paddle2.body:applyForce(0, -8000)
  elseif love.keyboard.isDown("down") then
    objects.paddle2.body:applyForce(0, 8000)
  end
  if love.keyboard.isDown("left") then
    objects.paddle2.body:applyForce(-8000, 0)
  elseif love.keyboard.isDown("right") then
    objects.paddle2.body:applyForce(8000, 0)
  end
  if love.keyboard.isDown("n") then
    objects.paddle2.body:applyTorque(-60000) -- twist it counter clockwise
  elseif love.keyboard.isDown("m") then
    objects.paddle2.body:applyTorque(60000) -- twist clockwise
  end

end

function scoring (object_1, object_2, contact)
  if ( object_1:getCategory() + object_2:getCategory() == 6 ) then -- ball plus left wall
    score[2] = score[2] + 1
    do_reset = true
  elseif ( object_1:getCategory() + object_2:getCategory() == 7 ) then -- ball plus right wall
    score[1] = score[1] +1
    do_reset = true
  end
end

function reset()
  objects.paddle1.body:setPosition( 20, screen_height/2 )
  objects.paddle1.body:setLinearVelocity( 0, 0 )
  objects.paddle1.body:setAngularVelocity( 0 )
  objects.paddle1.body:setAngle( 0 )

  objects.paddle2.body:setPosition( screen_width - 20, screen_height/2 )
  objects.paddle2.body:setLinearVelocity( 0, 0 )
  objects.paddle2.body:setAngularVelocity( 0 )
  objects.paddle2.body:setAngle( 0 )

  objects.ball.body:setPosition( screen_width/2, screen_height/2 )
  objects.ball.body:setLinearVelocity( 0, 0 )
end
