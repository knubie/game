module(..., package.seeall)

function update(sprite)

	local left = love.keyboard.isDown("left") and not love.keyboard.isDown("up") and not love.keyboard.isDown("right") and not love.keyboard.isDown("down")
	local left_up = love.keyboard.isDown("left") and love.keyboard.isDown("up") and not love.keyboard.isDown("right") and not love.keyboard.isDown("down")
	local left_down = love.keyboard.isDown("left") and love.keyboard.isDown("down") and not love.keyboard.isDown("right") and not love.keyboard.isDown("up")
	local right = love.keyboard.isDown("right") and not love.keyboard.isDown("up") and not love.keyboard.isDown("left") and not love.keyboard.isDown("down")
	local right_up = love.keyboard.isDown("right") and love.keyboard.isDown("up") and not love.keyboard.isDown("left") and not love.keyboard.isDown("down")
	local right_down = love.keyboard.isDown("right") and love.keyboard.isDown("down") and not love.keyboard.isDown("left") and not love.keyboard.isDown("up")
	local up = love.keyboard.isDown("up") and not love.keyboard.isDown("right") and not love.keyboard.isDown("down") and not love.keyboard.isDown("left")
	local down = love.keyboard.isDown("down")
	local space = love.keyboard.isDown(" ")

	if sprite.state == "idle" then

		if left then
			walk(sprite, "left")
		elseif left_up then
			init_jump(sprite, "left")
		elseif left_down then
			crouch(cammy)
		elseif right then
			walk(sprite, "right")
		elseif right_up then
			init_jump(sprite, "right")
		elseif right_down then
			crouch(sprite)
		elseif down then
			crouch(sprite)
		elseif up then -- up must come after direction, as they modify up
			init_jump(sprite, "neutral")
		elseif space then
			jab(sprite, "standing")
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
		if space then
			jab(sprite, "standing")
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
		sprite.x = sprite.x + sprite.speed + 1
	elseif sprite.state == "backward_jump" then
		jump(sprite)
		sprite.x = sprite.x - sprite.speed + 1
	elseif sprite.state == "sjab" then
		if sprite.frame == 3 then
			sprite:set_state("idle")
		end
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
end

function jump(sprite)
	if sprite.y - sprite.dy >= 0 then
		sprite.y = 0
		sprite:set_state("idle")
	else
		sprite.y = sprite.y - sprite.dy
		sprite.dy = sprite.dy - sprite.g
	end
end

function jab(sprite, position)
	if sprite.state ~= "sjab" then
		sprite:set_state("sjab")
	end
end
