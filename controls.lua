module(..., package.seeall)

function update(sprite)

	local down = love.keyboard.isDown("down")
	local up = love.keyboard.isDown("up")
	local left = love.keyboard.isDown("left")
	local right = love.keyboard.isDown("right")

	if sprite.state == "idle" then

		if down then
			crouch(sprite)
		elseif up then
			init_jump(sprite, "neutral")
		elseif left then
			walk(sprite, "left")
		elseif right then
			walk(sprite, "right")
		end

	elseif sprite.state == "walk_forward" then

		if down then
			crouch(sprite)
		elseif up then
			init_jump(sprite, "right")
		elseif left then
			walk(sprite, "left")
		elseif right then
			walk(sprite, "right")
		else
			sprite:set_state("idle")
		end

	elseif sprite.state == "walk_backward" then

		if down then
			crouch(sprite)
		elseif up then
			init_jump(sprite, "left")
		elseif left then
			walk(sprite, "left")
		elseif right then
			walk(sprite, "right")
		else
			sprite:set_state("idle")
		end

	elseif sprite.state == "crouch" then

		if down then
			crouch(sprite)
		elseif up then
			init_jump(sprite, "neutral")
		elseif left then
			walk(sprite, "left")
		elseif right then
			walk(sprite, "right")
		else
			sprite:set_state("idle")
		end

	elseif sprite.state == "neutral_jump" then
		jump(sprite)
	elseif sprite.state == "forward_jump" then
		jump(sprite)
		sprite.x = sprite.x + sprite.speed
	elseif sprite.state == "backward_jump" then
		jump(sprite)
		sprite.x = sprite.x - sprite.speed
	end

end

function walk(sprite, direction)
	-- local state = "idle"

	-- if sprite.facing == "right" then
	-- 	if direction == "right" then
	-- 		state = "walk_forward"
	-- 	elseif direction == "left" then
	-- 		state = "walk_backward"
	-- 	end
	-- elseif sprite.facing == "left" then
	-- 	if direction == "right" then
	-- 		state = "walk_backward"
	-- 	elseif direction == "left" then
	-- 		state = "walk_forward"
	-- 	end
	-- end
	local state = ""
	if direction == "right" then
		state = "walk_forward"
	elseif direction == "left" then
		state = "walk_backward"
	end

	if sprite.state ~= state then
		sprite:set_state(state)
	end
	if direction == "right" then
		if sprite.x < 650 - 50 then
			sprite.x = sprite.x + sprite.speed
		end
	elseif direction == "left" then
		if sprite.x > 50 then
			sprite.x = sprite.x - sprite.speed
		end
	end
end

function crouch(sprite)
	if sprite.state ~= "crouch" then
		sprite:set_state("crouch")
	end
end

function init_jump(sprite, direction)
	if direction == "neutral" then
		if sprite.state ~= "neutral_jump" then
			sprite.dy = sprite.jumpv
			sprite:set_state("neutral_jump")
		end
	elseif direction == "right" then
		if sprite.state ~= "forward_jump" then
			sprite.dy = sprite.jumpv
			sprite:set_state("forward_jump")
		end
	elseif direction == "left" then
		if sprite.state ~= "backward_jump" then
			sprite.dy = sprite.jumpv
			sprite:set_state("backward_jump")
		end
	end

	function jump(sprite)
		if sprite.y - sprite.dy >= 0 then
			sprite.y = 0
			sprite:set_state("idle")
		else
			sprite.y = sprite.y - sprite.dy
			sprite.dy = sprite.dy - .9
		end
	end
end