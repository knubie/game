module(..., package.seeall)

local sheets = {}

function draw(sprite)
	local sheet = sheets[sprite.sheet_id]
	local state = sheet.states[sprite.state]
	local quad = love.graphics.newQuad(
		state.frames[sprite.frame], state.y,
		state.width, state.height,
		sheet.img:getWidth(), sheet.img:getHeight()
	)
	love.graphics.drawq(sheet.img, quad, sprite.x, 650-state.height)
end

function new(src)
	table.insert(sheets, {
		img = love.graphics.newImage(src),
		states = {}
	})

	local sprite = {x = 0, state = nil, frame = 1, sheet_id = #sheets}

	function sprite:new_state (state_name, w, h, y, frames)
		local sheet = sheets[self.sheet_id]
		sheet.states[state_name] = {
			width = w,
			height = h,
			y = y,
			frames = {}
		}
		for i,v in ipairs(frames) do
			sheet.states[state_name].frames[i] = v
		end
	end

	function sprite:draw ()
		local sheet = sheets[self.sheet_id]
		local state = sheet.states[self.state]
		local quad = love.graphics.newQuad(
			state.frames[self.frame], state.y,
			state.width, state.height,
			sheet.img:getWidth(), sheet.img:getHeight()
		)
		love.graphics.drawq(sheet.img, quad, self.x, 650-state.height)
	end

	function sprite:animate(sprite)
		local last_frame = #sheets[self.sheet_id].states[self.state].frames
		if self.frame < last_frame then
			self.frame = self.frame + 1
		else
			if self.state == "crouch" then
				self.frame = 3
			elseif self.state == "neutral_jump" then
				self.frame = 1
				self.state = "idle"
			else
				self.frame = 1
			end
		end
	end
	
	return sprite
end


cammy = new('assets/cammy.png')
cammy:new_state("idle", 78, 93, 482, {70,160,248,334,421,503})
cammy:new_state("walk_forward", 75, 104, 587, {74,152,231,309,389,468,551,631,708,788})
cammy:new_state("walk_backward", 79, 106, 715, {92, 172, 257, 355, 452, 557, 662, 769, 874, 978})
cammy:new_state("crouch", 78, 89, 840, {96, 187, 270})
cammy:new_state("neutral_jump", 65, 152, 942, {92, 162, 236, 305, 379, 453, 524})
cammy.state = "idle"