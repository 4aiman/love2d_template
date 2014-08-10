local Main = Game:addState('Main')
local Vector  = require('lib.vector')

function Main:enteredState()
  Collider = HC(100, self.on_start_collide, self.on_stop_collide)

  love.mouse.setVisible(false)
  local Camera = require("lib/camera")
  self.camera = Camera:new()

  g.setFont(self.preloaded_fonts["04b03_16"])

  local joysticks = love.joystick.getJoysticks()
  local i = game.preloaded_images
  self.player1 = Player:new(COLORS.red, i["alpha_red.png"], i["beta_red.png"])
  self.player1.game_over_image = self.preloaded_images["winp2.png"]
  self.player1.joystick = joysticks[1]
  self.player1.controls = {
    keyboard = {
      up = Player.up,
      right = Player.right,
      down = Player.down,
      left = Player.left,
    }
  }

  self.player2 = Player:new(COLORS.blue, i["alpha_blue.png"], i["beta_blue.png"])
  self.player2.game_over_image = self.preloaded_images["winp1.png"]
  self.player2.joystick = joysticks[2]
  self.player2.controls = {
    keyboard = {
      w = Player.up,
      d = Player.right,
      s = Player.down,
      a = Player.left,
    }
  }

  local w_fourth = LovePixlr._w / 4
  local player2_zone = Section:new(self.player2, w_fourth * 0, 0, w_fourth, LovePixlr._h)
  local neutral_zone = Section:new(nil, w_fourth * 1, 0, w_fourth * 2, LovePixlr._h)
  local player1_zone = Section:new(self.player1, w_fourth * 3, 0, w_fourth, LovePixlr._h)

  Predator:new(neutral_zone, Vector(LovePixlr._w / 2, LovePixlr._h / 2))
  Predator:new(neutral_zone, Vector(LovePixlr._w / 10 * 4, LovePixlr._h / 3))
  Predator:new(neutral_zone, Vector(LovePixlr._w / 10 * 4, LovePixlr._h / 3 * 2))
  Predator:new(neutral_zone, Vector(LovePixlr._w / 10 * 6, LovePixlr._h / 3))
  Predator:new(neutral_zone, Vector(LovePixlr._w / 10 * 6, LovePixlr._h / 3 * 2))

  player1_zone:spawn_new_resources(0.1)
  neutral_zone:spawn_new_resources(0.2)
  player2_zone:spawn_new_resources(0.1)
end

function Main:update(dt)
  for _,section in pairs(Section.instances) do
    section:update(dt)
  end

  for i,player in pairs(Player.instances) do
    player:update(dt)
  end

  for _,predator in pairs(Predator.instances) do
    predator:update(dt)
  end

  Collider:update(dt)

  -- for i,boid in pairs(BoidedEntity.instances) do
  --   boid:update(dt)
  -- end
end

function Main:draw()
  self.camera:set()
  g.setColor(COLORS.white:rgb())
  g.draw(game.preloaded_images["background.png"], 0, 0)

  -- for _,section in pairs(Section.instances) do
  --   section:draw()
  -- end

  for _,resource in pairs(Resource.instances) do
    resource:draw()
  end

  for i,player in pairs(Player.instances) do
    player:draw()
  end

  for _,predator in pairs(Predator.instances) do
    predator:draw()
  end

  -- for i,boid in pairs(BoidedEntity.instances) do
  --   boid:draw()
  -- end

  -- g.setColor(COLORS.white:rgb())
  -- for k,shape in Collider:activeShapes() do
  --   shape:draw()
  -- end
  -- Collider._hash:draw("line", false, true)

  self.camera:unset()

  g.setColor(COLORS.green:rgb())
  g.print(love.timer:getFPS())
end

function Main:mousepressed(x, y, button)
end

function Main:mousereleased(x, y, button)
end

function Main:keypressed(key, unicode)
end

function Main:keyreleased(key, unicode)
end

function Main:joystickpressed(joystick, button)
end

function Main:joystickreleased(joystick, button)
end

function Main:focus(has_focus)
end

-- shape_one and shape_two are the colliding shapes. mtv_x and mtv_y define the minimum translation vector,
-- i.e. the direction and magnitude shape_one has to be moved so that the collision will be resolved.
-- Note that if one of the shapes is a point shape, the translation vector will be invalid.
function Main.on_start_collide(dt, shape_one, shape_two, mtv_x, mtv_y)
  local object_one, object_two = shape_one.parent, shape_two.parent

  if object_one and is_func(object_one.on_collide) then
    object_one:on_collide(dt, object_two, mtv_x, mtv_y)
  end

  if object_two and is_func(object_two.on_collide) then
    object_two:on_collide(dt, object_one, -mtv_x, -mtv_y)
  end
end

function Main.on_stop_collide(dt, shape_one, shape_two)
end

function Main:exitedState()
  for _,resource in pairs(Resource.instances) do
    resource:destroy()
  end

  for _,section in pairs(Section.instances) do
    section:destroy()
  end

  for i,player in pairs(Player.instances) do
    player:destroy()
  end

  for _,predator in pairs(Predator.instances) do
    predator:destroy()
  end

  Collider:clear()
  Collider = nil
  love.mouse.setVisible(true)
end

return Main
