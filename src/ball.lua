class = require "../lib/30log/30log"
Ball = class {}

function Ball:__init(color)

  self.radius = screen_width / 80
  self.color = color

  self.body = love.physics.newBody(world, screen_width/2, screen_height/2, "dynamic")
  self.shape = love.physics.newCircleShape(self.radius)
  self.fixture = love.physics.newFixture(self.body, self.shape, 1)
  self.fixture:setRestitution(0.9) -- bouncyness
  self.fixture:setCategory(2) -- self category
  self.body:setLinearDamping(0.3)
end

function Ball:draw()
  love.graphics.setColor(self.color)
  love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
end
