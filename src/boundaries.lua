class = require "../lib/30log/30log"
Boundaries = class {}

function Boundaries:__init(color)

  self.color = color

  self.top = {}
  self.top.body = love.physics.newBody(world, screen_width/2, 0, "static")
  self.top.shape = love.physics.newRectangleShape(screen_width, 5)
  self.top.fixture = love.physics.newFixture(self.top.body, self.top.shape)
  self.top.fixture:setCategory(4)

  self.bottom = {}
  self.bottom.body = love.physics.newBody(world, screen_width/2, screen_height, "static")
  self.bottom.shape = love.physics.newRectangleShape(screen_width, 5)
  self.bottom.fixture = love.physics.newFixture(self.bottom.body, self.bottom.shape)
  self.bottom.fixture:setCategory(4)

  self.left_top = {}
  self.left_top.body = love.physics.newBody(world, 10, 85, "static")
  self.left_top.shape = love.physics.newRectangleShape(20, 170)
  self.left_top.fixture = love.physics.newFixture(self.left_top.body, self.left_top.shape)
  self.left_top.fixture:setCategory(4)

  self.left_bottom= {}
  self.left_bottom.body = love.physics.newBody(world, 10, 530, "static")
  self.left_bottom.shape = love.physics.newRectangleShape(20, 170)
  self.left_bottom.fixture = love.physics.newFixture(self.left_bottom.body, self.left_bottom.shape)
  self.left_bottom.fixture:setCategory(4)

  self.right_top = {}
  self.right_top.body = love.physics.newBody(world, screen_width - 10, 85, "static")
  self.right_top.shape = love.physics.newRectangleShape(20, 170)
  self.right_top.fixture = love.physics.newFixture(self.right_top.body, self.right_top.shape)
  self.right_top.fixture:setCategory(4)

  self.right_bottom= {}
  self.right_bottom.body = love.physics.newBody(world, screen_width - 10, 530, "static")
  self.right_bottom.shape = love.physics.newRectangleShape(20, 170)
  self.right_bottom.fixture = love.physics.newFixture(self.right_bottom.body, self.right_bottom.shape)
  self.right_bottom.fixture:setCategory(4)

  self.left = {}
  self.left.body = love.physics.newBody(world, 0, screen_height/2, "static")
  self.left.shape = love.physics.newRectangleShape(5, screen_height)
  self.left.fixture = love.physics.newFixture(self.left.body, self.left.shape)
  self.left.fixture:setCategory(5)

  self.right = {}
  self.right.body = love.physics.newBody(world, screen_width, screen_height/2, "static")
  self.right.shape = love.physics.newRectangleShape(5, screen_height)
  self.right.fixture = love.physics.newFixture(self.right.body, self.right.shape)
  self.right.fixture:setCategory(7)
end

function Boundaries:draw()

  love.graphics.setColor(self.color)
  love.graphics.polygon("fill", self.top.body:getWorldPoints(self.top.shape:getPoints()))
  love.graphics.polygon("fill", self.bottom.body:getWorldPoints(self.bottom.shape:getPoints()))
  love.graphics.polygon("fill", self.left.body:getWorldPoints(self.left.shape:getPoints()))
  love.graphics.polygon("fill", self.right.body:getWorldPoints(self.right.shape:getPoints()))
  love.graphics.polygon("fill", self.left_top.body:getWorldPoints(self.left_top.shape:getPoints()))
  love.graphics.polygon("fill", self.left_bottom.body:getWorldPoints(self.left_bottom.shape:getPoints()))
  love.graphics.polygon("fill", self.right_top.body:getWorldPoints(self.right_top.shape:getPoints()))
  love.graphics.polygon("fill", self.right_bottom.body:getWorldPoints(self.right_bottom.shape:getPoints()))
end
