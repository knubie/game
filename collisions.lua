module(..., package.seeall)

function update (sprite)

	local foe = sprite.foe

	local function checkCollision(sprite, foe)

		ax1,ay1,aw,ah = sprite:blue_box()
		bx1,by1,bw,bh = foe:blue_box()

		local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
		return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
	end

	local function checkHit(sprite, foe)

		ax1,ay1,aw,ah = sprite:red_box()
		bx1,by1,bw,bh = foe:blue_box()

		local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
		return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
	end

	if checkHit(sprite, foe) then
		if sprite.shake_frame > 0 then
			if sprite.facing == "right" then
				sprite.x = sprite.x - sprite.speed/2
				foe.x = foe.x + sprite.speed/2
			else
				sprite.x = sprite.x + sprite.speed/2
				foe.x = foe.x - sprite.speed/2
			end
		else
			foe:set_state("light_hit")
		end
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