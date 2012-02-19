module(..., package.seeall)

local sheets = {}

function new (effect)

	table.insert(sheets, love.graphics.newImage(effect.src))

	local new_effect = {
		x = -500,
		y = -500,
		frame = 1,
		sheet_id = #sheets,
		center = effect.c
	}

	function new_effect:animate ()
		if self.frame < effect.nf then
			self.frame = self.frame + 1
		else
			self.frame = 1
			self.x = -500
			self.y = -500
		end
	end

	function new_effect:draw ()
		local sheet = sheets[self.sheet_id]
		local quad = love.graphics.newQuad(
			self.frame*effect.w-effect.w, 0,
			effect.w, effect.h,
			sheet:getWidth(), sheet:getHeight()
		)
		love.graphics.drawq(sheet, quad, self.x-effect.c.x, self.y-effect.c.y)
	end

	return new_effect
end	

small_spark = new{
	src = "assets/small-spark.png",
	c = {x=56,y=116},
	w = 193,
	h = 219,
	nf = 10
}