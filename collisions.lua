module(..., package.seeall)
require('effects')

function update (sprite)

	local foe = sprite.foe

	local function checkCollision(sprite, foe)

		ax1,ay1,aw,ah = sprite:blue_box()
		bx1,by1,bw,bh = foe:blue_box()

		local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
		return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
	end

	local function checkHit(sprite, foe)

		local s = sprite.red_box

		ax1,ay1,aw,ah = s[1], s[2], s[3], s[4]
		bx1,by1,bw,bh = foe:blue_box()

		local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
		return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
	end

	if checkHit(sprite, foe) then

		if sprite.hitting == false then
			foe.frame = 1
			foe.shake_frame = 0
			foe.push_back_frame = 0
			sprite.hitting = true
			foe:set_state("light_hit")
			effects.small_spark.frame = 1
			if sprite.facing == "right" then
				effects.small_spark.x = sprite.red_box[1]+sprite.red_box[3]
			else
				effects.small_spark.x = sprite.red_box[1]
			end
			effects.small_spark.y = sprite.red_box[2]+(sprite.red_box[4]/2)
		end
		-- 	if sprite.facing == "right" then
		-- 		sprite.x = sprite.x - sprite.speed/2
		-- 		foe.x = foe.x + sprite.speed/2
		-- 	else
		-- 		sprite.x = sprite.x + sprite.speed/2
		-- 		foe.x = foe.x - sprite.speed/2
		-- 	end
		-- else
		-- 	foe:set_state("light_hit")
		-- end
	end

	if checkCollision(sprite, foe) then
		if sprite.facing == "right" then
			sprite.x = sprite.x - sprite.speed/2
			foe.x = foe.x + sprite.speed/2
		else
			sprite.x = sprite.x + sprite.speed/2
			foe.x = foe.x - sprite.speed/2
		end
	end

end


-- if hit then
-- 	self:set_red_box(0)
-- 	foe:hit(self.hit.foe-recovery_frames)
-- 	self.hold_frame for hit.recover_frames
-- end

-- sprite:hit (recover_frames)

-- 	while i < 10
-- 		shake()
-- 		hold on first frame
-- 	else
-- 		recover(hit.for_recovery_frames)
-- 	end

-- 	function recover()
-- 		move back
-- 	end
-- end