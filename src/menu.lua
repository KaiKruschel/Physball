
menu = {}

function menu:init()

  love.graphics.setBackgroundColor(104, 136, 248)
	print("Menu initialized")

end

function menu:draw()
	love.graphics.print("Press Enter to start game", 10, 10)
end

function menu:keyreleased(key, code)
	if key == 'return' then
		Gamestate.switch(game)
	end
end

function menu:update(dt)

end
