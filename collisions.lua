module(..., package.seeall)

function update (sprite)
	if sprite.facing == "right" then
		print("facing right =============")
		print(sprite:right_side(sprite:blue_box()))
		print(sprite.x)
	elseif sprite.facing == "left" then
		print("facing left =============")
		print(sprite:left_side(sprite:blue_box()))
		print(sprite.x)
	end

	if sprite:right_side(sprite:blue_box()) > sprite.opponent:left_side(sprite.opponent:blue_box()) and sprite:bottom(sprite:blue_box()) > sprite.opponent:top(sprite.opponent:blue_box()) and sprite:top(sprite:blue_box()) < sprite.opponent:bottom(sprite.opponent:blue_box()) and sprite:is_on_left() then
		sprite.x = sprite.x - sprite.speed/2
		sprite.opponent.x = sprite.opponent.x + sprite.speed/2
	elseif sprite:is_on_right() and sprite.opponent:right_side(sprite.opponent:blue_box()) > sprite:left_side(sprite:blue_box()) and sprite:bottom(sprite:blue_box()) > sprite.opponent:top(sprite.opponent:blue_box()) and sprite:top(sprite:blue_box()) < sprite.opponent:bottom(sprite.opponent:blue_box()) then
		sprite.x = sprite.x + sprite.speed/2
		sprite.opponent.x = sprite.opponent.x - sprite.speed/2
	end
end