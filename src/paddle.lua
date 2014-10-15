class = require "../lib/30log/30log"
Paddle = class {}


function Paddle:__init(player, color) -- screen_width and height are global and can be accessed


  self.speed = 20000
  self.width = screen_width / 40
  self.height = 2 * screen_height / 15

  self.player = player

  if (self.player == 1) then
    self.x = self.width
    self.keys = keyboard.p1
    self.controls = keyboard.p1.controls
    print("player1 ready")
  elseif (self.player == 2) then
    self.x = screen_width - self.width
    self.keys = keyboard.p2
    self.controls = keyboard.p2.controls
    print("player2 ready")
  end

  print (self.controls)

  --TODO get this to work
  if self.controls == "normal" then
    self.ctl_func = Paddle.normal_controls
  else
    self.ctl_func = Paddle.tank_controls
  end

  self.y = screen_height / 2
  self.color = color

  self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
  self.shape = love.physics.newRectangleShape(self.width, self.height)
  self.fixture = love.physics.newFixture(self.body, self.shape, 10)
  self.fixture:setRestitution(0.4)
  self.fixture:setCategory(1) -- put it in the paddle category
  self.body:setAngularDamping(1.8) -- how fast spinning stops
  self.body:setLinearDamping(0.8) -- how fast directional movement stops
end


function Paddle:draw()
  love.graphics.setColor(self.color)
  love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end


function Paddle:update()
  self:ctl_func()
end

function Paddle:tank_controls()
  self.angle = self.body:getAngle()
  self.dir_x = (self.speed * math.cos(self.angle))
  self.dir_y = (self.speed * math.sin(self.angle))
  if love.keyboard.isDown(self.keys.up) then
    self.body:applyForce(self.dir_x, self.dir_y)
  elseif love.keyboard.isDown(self.keys.down) then
    self.body:applyForce(-self.dir_x, -self.dir_y)
  end
  if love.keyboard.isDown(self.keys.left) then
    self.body:applyTorque(-150000) -- twist it counter clockwise
  elseif love.keyboard.isDown(self.keys.right) then
    self.body:applyTorque(150000) -- twist clockwise
  end
end


function Paddle:normal_controls()
  if love.keyboard.isDown(self.keys.up) then
    self.body:applyForce(0 , -self.speed)
  elseif love.keyboard.isDown(self.keys.down) then
    self.body:applyForce(0 , self.speed)
  end
  if love.keyboard.isDown(self.keys.left) then
    self.body:applyForce(-self.speed, 0)
  elseif love.keyboard.isDown(self.keys.right) then
    self.body:applyForce(self.speed, 0)
  end
  if love.keyboard.isDown(self.keys.turn_ccw) then
    self.body:applyTorque(-150000) -- twist it counter clockwise
  elseif love.keyboard.isDown(self.keys.turn_cw) then
    self.body:applyTorque(150000) -- twist clockwise
  end
end


