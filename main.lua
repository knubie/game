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
	if i > .03 then
		i = 0
		if sprites.cammy.state ~= "neutral_jump" then
			if love.keyboard.isDown('down') then
				controls.crouch(sprites.cammy)
			else
				if love.keyboard.isDown('right') then
					controls.walk(sprites.cammy, "walk_forward")
				elseif love.keyboard.isDown('left') then
					controls.walk(sprites.cammy, "walk_backward")
				else
					sprites.cammy.state = "idle"
				end
			end
		end
		sprites.cammy:animate()
	else
		i = i + dt
	end
end

function love.keypressed(key)
	if key == 'up' then
		if love.keyboard.isDown('right') then
			controls.jump(sprites.cammy, 'right')
		elseif love.keyboard.isDown('left') then
			controls.jump(sprites.cammy, 'left')
		else
			controls.jump(sprites.cammy, 'neutral')
		end
	end
end