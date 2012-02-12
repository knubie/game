require('sprites')
require('controls')

-- animate > change state > draw

function love.load()
	love.graphics.setMode(650, 650, false, true, 0)
	love.graphics.setBackgroundColor(255, 255, 255)
	cammy = sprites.new('assets/cammy.png')
	sprites.new_state(cammy, "idle", 78, 93, 482, {70,160,248,334,421,503})
	sprites.new_state(cammy, "walk_forward", 75, 104, 587, {74,152,231,309,389,468,551,631,708,788})
	sprites.new_state(cammy, "walk_backward", 79, 106, 715, {92, 172, 257, 355, 452, 557, 662, 769, 874, 978})
	sprites.new_state(cammy, "crouch", 78, 89, 840, {96, 187, 270})
	cammy.state = "idle"
	i = 0
end

function love.draw()
	sprites.draw(cammy)
end

function love.update(dt)
	if i > .03 then
		i = 0
		if love.keyboard.isDown('down') then
			controls.crouch(cammy)
		else
			if love.keyboard.isDown('right') then
				controls.walk(cammy, "right")
			elseif love.keyboard.isDown('left') then
				controls.walk(cammy, "left")
			else
				cammy.state = "idle"
			end
		end
		sprites.animate(cammy)
	else
		i = i + dt
	end
end

function love.keypressed(key)
	if key == 'up' then
		if love.keyboard.isDown('right') then
			controls.jump(cammy, 'right')
		elseif love.keyboard.isDown('left') then
			controls.jump(cammy, 'left')
		else
			controls.jump(cammy, 'neutral')
		end
	end
end