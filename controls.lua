module(..., package.seeall)

function walk(sprite, direction)
	if direction == "right" then
		if sprite.state == "idle" or "walk_forward" or "walk_backward" then
			if sprite.state ~= "walk_forward" then
				sprite.frame = 0
				sprite.state = "walk_forward"
			end
			if sprite.x < 650 - 104 then
				sprite.x = sprite.x + 7
			end
			sprite.active = true
		end
	elseif direction == "left" then
		if sprite.state == "idle" or "walk_forward" or "walk_backward" then
			if sprite.state ~= "walk_backward" then
				sprite.frame = 0
				sprite.state = "walk_backward"
			end
			if sprite.x > 0 then
				sprite.x = sprite.x - 7
			end
			sprite.active = true
		end
	else
		sprite.active = false
	end
end

function crouch(sprite)
	if sprite.state ~= "crouch" then
		sprite.state = "crouch"
		sprite.frame = 0
	end
end

function jump(sprite, direction)
	if direction == "neutral" then
		print("neutral jump")
	elseif direction == "right" then
		print("jump right")
	elseif direction == "left" then
		print("jump left")
	end
end