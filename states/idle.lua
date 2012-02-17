module('idle', package.seeall)

function up (sprite)
	sprite:init_jump("neutral")
end

function right_up (sprite)
	sprite:init_jump("right")
end

function right (sprite)
	sprite:walk("right")
end

function right_down (sprite)
	sprite:crouch()
end

function down (sprite)
	sprite:crouch()
end

function left_down (sprite)
	sprite:crouch()
end

function left (sprite)
	sprite:walk("left")
end

function left_up (sprite)
	sprite:init_jump("left")
end
