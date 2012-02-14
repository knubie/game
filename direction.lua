module(..., package.seeall)
function set (sprite)
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
end