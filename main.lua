require "src/helpers"
require "src/paddle"
require "src/ball"
require "src/boundaries"

-- gamestates
require "src/menu"
require "src/game"
require "src/pause"

-- config
require "keys"

function love.load()

	Gamestate = require "lib/hump.gamestate"

	Gamestate.registerEvents()

  -- settings
  keyboard = {}
  set_keyboard(keyboard)

  -- screen
  screen_width, screen_height = love.window.getMode()

  -- score
  font = love.graphics.newFont(20) -- with only one argument, only the size is specified
                                   -- otherwise it would be love.graphics.newFont(file, size)


  -- initial graphics setup
  print("Pong init")

	-- initial gamestate
	Gamestate.switch(menu)

end

function love.draw()

	if (Gamestate.current() == "game") then
		game:draw()
	elseif (Gamestate.current() == "pause") then
		pause:draw()
	elseif (Gamestate.current() == "menu") then
		menu:draw()
	end

end

function love.update(dt)

	if (Gamestate.current() == "game") then
		game:update(dt)
	elseif (Gamestate.current() == "pause") then
		pause:update(dt)
	elseif (Gamestate.current() == "menu") then
		menu:update(dt)
	end

end
