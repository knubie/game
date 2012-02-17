module(..., package.seeall)
require("states/idle")

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
			idle.up(sprite)
		elseif right_up then
			idle.right_up(sprite)
		elseif right then
			idle.right(sprite)
		elseif right_down then
			idle.right_down(sprite)
		elseif down then
			idle.down(sprite)
		elseif left_down then
			idle.left_down(sprite)
		elseif left then
			idle.left(sprite)
		elseif left_up then
			idle.left_up(sprite)
		elseif jabb then
			jab(sprite, "standing")
		end

	elseif sprite.state == "walk_forward" then

		if down then
			sprite:crouch()
		elseif up then
			init_jump(sprite, "right")
		elseif left then
			sprite:walk("left")
		elseif right then
			sprite:walk("right")
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
			sprite:walk("left")
		elseif right then
			sprite:walk("right")
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

		if sprite.frame == 3 then
			sprite:set_state("idle")
		end

	elseif sprite.state == "light_hit" then
		sprite:shake()
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
