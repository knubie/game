module(..., package.seeall)

function walk(sprite, direction)
	if sprite.state == "idle" or "walk_forward" or "walk_backward" then
		if sprite.state ~= direction then
			sprite.frame = 0
			sprite.state = direction
		end
		if direction == "walk_forward" then
			if sprite.x < 650 - 104 then
				sprite.x = sprite.x + 8
			end
		elseif direction == "walk_backward" then
			if sprite.x > 0 then
				sprite.x = sprite.x - 8
			end
		end
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
		if sprite.state ~= "neutral_jump" then
			sprite.frame = 1
			sprite.state = "neutral_jump"
		end
		print("neutral jump")
	elseif direction == "right" then
		print("jump right")
	elseif direction == "left" then
		print("jump left")
	end
end