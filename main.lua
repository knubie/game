require('sprites')
require('controls')

-- animate > change state > draw

function love.load()
	love.graphics.setMode(650, 650, false, true, 0)
	love.graphics.setBackgroundColor(255, 255, 255)
	i = 0
end

function love.draw()
	sprites.cammy:draw()
end

function love.update(dt)
	controls.update(sprites.cammy)
	if i > 2 then
		i = 0
		sprites.cammy:animate()
	else
		i = i + 1
	end
end

function love.keypressed(key)
end