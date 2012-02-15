module(..., package.seeall)

function update(sprite)

	if sprite:right_side() > sprite.opponent:left_side() and sprite:bottom() > sprite.opponent:top() and sprite:top() < sprite.opponent:bottom() and sprite:is_on_left() then
		print('collision facing right')
		sprite.x = sprite.x - sprite.speed/2
		sprite.opponent.x = sprite.opponent.x + sprite.speed/2
	elseif sprite:is_on_right() and sprite.opponent:right_side() > sprite:left_side() and sprite:bottom() > sprite.opponent:top() and sprite:top() < sprite.opponent:bottom() then
		print('collision facing left')
		sprite.x = sprite.x + sprite.speed/2
		sprite.opponent.x = sprite.opponent.x - sprite.speed/2
	end

	-- TODO: use force to calculate pushback (mass and velocity)

	local left = love.keyboard.isDown(sprite.left)
								and not love.keyboard.isDown(sprite.up)
								and not love.keyboard.isDown(sprite.right)
								and not love.keyboard.isDown(sprite.down)

	local left_up = love.keyboard.isDown(sprite.left)
									and love.keyboard.isDown(sprite.up)
									and not love.keyboard.isDown(sprite.right)
									and not love.keyboard.isDown(sprite.down)

	local left_down = love.keyboard.isDown(sprite.left)
										and love.keyboard.isDown(sprite.down)
										and not love.keyboard.isDown(sprite.right)
										and not love.keyboard.isDown(sprite.up)

	local right = love.keyboard.isDown(sprite.right)
								and not love.keyboard.isDown(sprite.up)
								and not love.keyboard.isDown(sprite.left)
								and not love.keyboard.isDown(sprite.down)

	local right_up = love.keyboard.isDown(sprite.right)
										and love.keyboard.isDown(sprite.up)
										and not love.keyboard.isDown(sprite.left)
										and not love.keyboard.isDown(sprite.down)

	local right_down = love.keyboard.isDown(sprite.right)
											and love.keyboard.isDown(sprite.down)
											and not love.keyboard.isDown(sprite.left)
											and not love.keyboard.isDown(sprite.up)

	local up = love.keyboard.isDown(sprite.up)
							and not love.keyboard.isDown(sprite.right)
							and not love.keyboard.isDown(sprite.down)
							and not love.keyboard.isDown(sprite.left)

	local down = love.keyboard.isDown(sprite.down)
								and not love.keyboard.isDown(sprite.right)
								and not love.keyboard.isDown(sprite.up)
								and not love.keyboard.isDown(sprite.left)

	local jabb = love.keyboard.isDown(sprite.jab)	

	sprite:set_face()

	if sprite.state == "idle" then

		if left then
			walk(sprite, "left")

		elseif left_up then
			init_jump(sprite, "left")

		elseif left_down then
			sprite:crouch()

		elseif right then
			walk(sprite, "right")

		elseif right_up then
			init_jump(sprite, "right")

		elseif right_down then
			sprite:crouch()

		elseif down then
			sprite:crouch()

		elseif up then
			init_jump(sprite, "neutral")
			
		elseif jabb then
			jab(sprite, "standing")
		end

	elseif sprite.state == "walk_forward" then

		if down then
			sprite:crouch()
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
			sprite:crouch()
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
			sprite:crouch()
		elseif left_down then
			sprite:crouch()
		elseif right_down then
			sprite:crouch()
		elseif up then
			init_jump(sprite, "neutral")
		elseif left then
			walk(sprite, "left")
		elseif left_up then
			init_jump(sprite, "left")
		elseif right_up then
			init_jump(sprite, "right")
		elseif right then
			walk(sprite, "right")
		else
			sprite:set_state("idle")
		end

	elseif sprite.state == "neutral_jump" then

		jump(sprite)

	elseif sprite.state == "forward_jump" then

		jump(sprite)
		sprite.x = sprite.x + sprite.jumpx

	elseif sprite.state == "backward_jump" then

		jump(sprite)
		sprite.x = sprite.x + sprite.jumpx

	elseif sprite.state == "sjab" then

		if sprite.frame == 3 then
			sprite:set_state("idle")
		end

	end

end

function walk(sprite, direction)
	local state = ""
	if direction == "right" and sprite.facing == "right" then
		state = "walk_forward"
	elseif direction == "right" and sprite.facing == "left" then
		state = "walk_backward"
	elseif direction == "left" and sprite.facing == "right" then
		state = "walk_backward"
	elseif direction == "left" and sprite.facing == "left" then
		state = "walk_forward"
	end

	sprite:set_state(state)

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

function init_jump(sprite, direction)

	local state = ""
	if direction == "right" and sprite.facing == "right" then
		state = "forward_jump"
		sprite.jumpx = sprite.speed + 2.5
	elseif direction == "right" and sprite.facing == "left" then
		state = "backward_jump"
		sprite.jumpx = sprite.speed + 2.5
	elseif direction == "left" and sprite.facing == "right" then
		state = "backward_jump"
		sprite.jumpx = 0 - (sprite.speed + 2.5)
	elseif direction == "left" and sprite.facing == "left" then
		state = "forward_jump"
		sprite.jumpx = 0 - (sprite.speed + 2.5)
	else
		state = "neutral_jump"
	end

	if sprite.state ~= state then
		sprite.dy = sprite.jumpv
		sprite:set_state(state)
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
	sprite:set_state("sjab")
end
