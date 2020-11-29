local Class = require 'libs/hump/class'
local Entity = require 'entities/Entity'

local time = 0
local maxTime = 0.080
local frames = {}
local currentFrame = 1
local jump = love.audio.newSource("assets/jump.mp3", "static")



local salaryman = Class{
  __includes = Entity -- Player class inherits our Entity class
}

function salaryman:init(world, x, y)
  self.img = love.graphics.newImage('/assets/Super Strong Normal Guy/Normal Guy Idle/Normal_Guy_Idle_Spritesheet.png')
  for y = 1, 1 do
    for x = 1, 1 do
      table.insert(frames, love.graphics.newQuad(15 * x - 15, 15 * y - 15, 15, 20, self.img:getDimensions()))
    end
  end

  

  Entity.init(self, world, x, y, 15, 20)

  -- Add our unique player values
  self.xVelocity = 0 -- current velocity on x, y axes
  self.yVelocity = 0
  self.acc = 100 -- the acceleration of our player
  self.maxSpeed = 600 -- the top speed
  self.friction = 50 -- slow our player down - we could toggle this situationally to create icy or slick platforms
  self.gravity = 80 -- we will accelerate towards the bottom

    -- These are values applying specifically to jumping
  self.isJumping = false -- are we in the process of jumping?
  self.isGrounded = false -- are we on the ground?
  self.hasReachedMax = false  -- is this as high as we can go?
  self.jumpAcc = 250 -- how fast do we accelerate towards the top
  self.jumpMaxSpeed = 9 -- our speed limit while jumping

  self.sx = 1
  self.sy = 1
  self.offset = 15

  self.i = 0

  self.world:add(self, self:getRect())
end

function salaryman:collisionFilter(other)
  local x, y, w, h = self.world:getRect(other)
  local playerBottom = self.y + self.h
  local otherBottom = y + h

  if playerBottom <= y then -- bottom of player collides with top of platform.
    return 'slide'
  end
end

function salaryman:update(dt)
  --local prevX, prevY = self.x, self.y
  local width = 32
  local height =32 

end

function salaryman:draw()
  love.graphics.draw(self.img, frames[currentFrame], self.x, self.y,0,self.sx, self.sy,self.offset)
end


return salaryman
