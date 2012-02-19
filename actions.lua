module(..., package.seeall)

function update (sprite)

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

		if up then
			sprite:init_jump("neutral")
		elseif right_up then
			sprite:init_jump("right")
		elseif right then
			sprite:walk("right")
		elseif right_down then
			sprite:crouch()
		elseif down then
			sprite:crouch()
		elseif left_down then
			sprite:crouch()
		elseif left then
			sprite:walk("left")
		elseif left_up then
			sprite:init_jump("left")
		elseif jabb then
			jab(sprite, "standing")
		end

	elseif sprite.state == "walk_forward" then

		if down then
			sprite:crouch()
		elseif up then
			init_jump(sprite, "right")
		elseif left then
			if jabb then
				jab(sprite, "standing")
			else
				sprite:walk("left")
			end
		elseif right then
			if jabb then
				jab(sprite, "standing")
			else
				sprite:walk("right")
			end
		else
			sprite:set_state("idle")
		end

	elseif sprite.state == "walk_backward" then

		if jabb then
			jab(sprite, "standing")
		end
		if down then
			sprite:crouch()
		elseif up then
			init_jump(sprite, "left")
		elseif left then
			if jabb then
				jab(sprite, "standing")
			else
				sprite:walk("left")
			end
		elseif right then
			if jabb then
				jab(sprite, "standing")
			else
				sprite:walk("right")
			end
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
			sprite:walk("left")
		elseif left_up then
			init_jump(sprite, "left")
		elseif right_up then
			init_jump(sprite, "right")
		elseif right then
			sprite:walk("right")
		else
			sprite:set_state("idle")
		end

	elseif sprite:jumping() then

		jump(sprite)

	elseif sprite.state == "sjab" then

		-- if self.hitting == false and self.frame < 2
		sprite.red_box = {sprite:sjab()}
		-- end

		-- if opp.shake_frame == shake_dur and 

	elseif sprite.state == "light_hit" then
		sprite:hit(8) -- start shakin
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
		sprite.x = math.floor(sprite.x + sprite.jumpx)
end

function jab(sprite, position)
	sprite:set_state("sjab")
end
