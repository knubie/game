module(..., package.seeall)

function move(sprite)
	if love.keyboard.isDown('right') then
		sprite.state = "walk_forward"
		sprite.x = sprite.x + 3
		sprite.active = true
	elseif love.keyboard.isDown('left') then
		sprite.state = "walk_backward"
		sprite.x = sprite.x - 3
		sprite.active = true
	else
		sprite.active = false
	end
end