require('sprites')
require('controls')

function love.load()
	love.graphics.setMode(650, 650, false, true, 0)
	love.graphics.setBackgroundColor(255, 255, 255)
	cammy = sprites.new('assets/cammy.png')
	sprites.new_state(cammy, "stance", 78, 93, 482, {70,160,248,334,421,503})
	sprites.new_state(cammy, "walk_forward", 75, 104, 587, {74,152,231,309,389,468,551,631,708,788})
	sprites.new_state(cammy, "walk_backward", 79, 106, 715, {92, 172, 257, 355, 452, 557, 662, 769, 874, 978})
	cammy.state = "stance"
	i = 0
end

function love.draw()
	sprites.draw(cammy)
end

function love.update(dt)
	if i >= .04 then
		sprites.animate(cammy)
		i = 0
	else
		i = i+dt
	end
	controls.move(cammy)	
end