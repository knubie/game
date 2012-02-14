module(..., package.seeall)

function update(sprite)

local left = love.keyboard.isDown(sprite.left) and not love.keyboard.isDown(sprite.up) and not love.keyboard.isDown(sprite.right) and not love.keyboard.isDown(sprite.down)
local left_up = love.keyboard.isDown(sprite.left) and love.keyboard.isDown(sprite.up) and not love.keyboard.isDown(sprite.right) and not love.keyboard.isDown(sprite.down)
local left_down = love.keyboard.isDown(sprite.left) and love.keyboard.isDown(sprite.down) and not love.keyboard.isDown(sprite.right) and not love.keyboard.isDown(sprite.up)
local right = love.keyboard.isDown(sprite.right) and not love.keyboard.isDown(sprite.up) and not love.keyboard.isDown(sprite.left) and not love.keyboard.isDown(sprite.down)
local right_up = love.keyboard.isDown(sprite.right) and love.keyboard.isDown(sprite.up) and not love.keyboard.isDown(sprite.left) and not love.keyboard.isDown(sprite.down)
local right_down = love.keyboard.isDown(sprite.right) and love.keyboard.isDown(sprite.down) and not love.keyboard.isDown(sprite.left) and not love.keyboard.isDown(sprite.up)
local up = love.keyboard.isDown(sprite.up) and not love.keyboard.isDown(sprite.right) and not love.keyboard.isDown(sprite.down) and not love.keyboard.isDown(sprite.left)
local down = love.keyboard.isDown(sprite.down) and not love.keyboard.isDown(sprite.right) and not love.keyboard.isDown(sprite.up) and not love.keyboard.isDown(sprite.left)
local jab = love.keyboard.isDown(sprite.jab)	

	if sprite.x < sprite.opponent.x then
		sprite.facing = "right"
	else
		sprite.facing = "left"
	end
	
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
		elseif jab then
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
		sprite.x = sprite.x + sprite.speed + 2

	elseif sprite.state == "backward_jump" then

		jump(sprite)
		sprite.x = sprite.x - (sprite.speed + 2)

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
