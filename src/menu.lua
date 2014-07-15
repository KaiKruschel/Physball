
menu = {}

function menu:init()

	print("Menu initialized")
	--[[
	loveframe
	make a frame
	make three buttons
	-start game
		switch to gamestate game
	-options
		switch to gamestate options
	-exit
		exit game
	]]

end

function menu:enter()

	--[[
	set loveframe gamestate to menu

	]]

	love.graphics.setBackgroundColor(104, 136, 248)
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
