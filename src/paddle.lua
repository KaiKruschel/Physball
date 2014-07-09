class = require '../lib/30log'
Paddle = class {}

function Paddle:__init(player, color) -- screen_width and height are global and can be accessed

  self.speed = 10
  self.width = screen_width / 40
  self.height = 2 * screen_height / 15

  self.player = player

  if (self.player == 1) then
    self.x = self.width
    self.keys = keyboard.p1
    --self.up, self.down, self.left, self.right, self.turn_ccw, self.turn_cw = "w", "s", "a", "d", "q", "e"
    print("player1 ready")
  elseif (self.player == 2) then
    self.x = screen_width - self.width
    self.keys = keyboard.p2
    -- self.up, self.down, self.left, self.right, self.turn_ccw, self.turn_cw = "up", "down", "left", "right", "appback", "appforward"
    print("player2 ready")
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
  if love.keyboard.isDown(self.keys.up) then
    self.body:applyForce(0, -20000)
  elseif love.keyboard.isDown(self.keys.down) then
    self.body:applyForce(0, 20000)
  end
  if love.keyboard.isDown(self.keys.left) then
    self.body:applyForce(-20000, 0)
  elseif love.keyboard.isDown(self.keys.right) then
    self.body:applyForce(20000, 0)
  end
  if love.keyboard.isDown(self.keys.turn_ccw) then
    self.body:applyTorque(-150000) -- twist it counter clockwise
  elseif love.keyboard.isDown(self.keys.turn_cw) then
    self.body:applyTorque(150000) -- twist clockwise
  end
end
