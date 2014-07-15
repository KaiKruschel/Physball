pause = {}

function pause:init()

	print("pause initialized")

end

function pause:draw()
	love.graphics.setBackgroundColor(255, 0, 127)
	love.graphics.print("press Return to get back to the game or Escape to go to the game menu")
end

function pause:keyreleased(key, code)
	if key == 'return' then
		print("switch back to game")
		Gamestate.switch(game)
	elseif key == 'escape' then
		print("switch back to menu")
		Gamestate.switch(menu)
	end
end

function pause:update(dt)

end
