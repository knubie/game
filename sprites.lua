module(..., package.seeall)

local sheets = {}

function new (src)
	table.insert(sheets, {
		img = love.graphics.newImage(src),
		states = {}
	})

	local sprite = {x = 0, y = 0, state = nil, frame = 1, sheet_id = #sheets, facing = "right", speed = 0, jumpv = 0, dy = 0, g = 0}

	function sprite:init_states (new_states)

		local function make_state (state_name, w, h, y, frames)
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

		for i,v in ipairs(new_states) do
			make_state(v[1], v[2], v[3], v[4], v[5])
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
		love.graphics.drawq(sheet.img, quad, self.x-math.floor(state.width/2), 650-state.height+self.y)
	end

	function sprite:animate ()
		local last_frame = #sheets[self.sheet_id].states[self.state].frames
		if self.frame < last_frame then -- if not at last frame, increment
			self.frame = self.frame + 1
		else -- at last frame
			if self.state == "crouch" then
				self.frame = 3 -- continue crouching
			elseif self.state == "neutral_jump" or self.state == "forward_jump" or self.state == "backward_jump" then
				self.frame = 1
			else
				self.frame = 1 -- start the state animation from the beginning
			end
		end
	end

	function sprite:set_state (state_name)
		self.frame = 1
		self.state = state_name
	end

	return sprite
end

cammy = new('assets/cammy.png')
cammy:init_states({
	-- name, looping?, width, height, y, x(frames)
	{"idle", 78, 93, 482, {70,160,248,334,421,503}},
	{"walk_forward", 75, 104, 587, {74,152,231,309,389,468,551,631,708,788}},
	{"walk_backward", 79, 106, 715, {92, 172, 257, 355, 452, 557, 662, 769, 874, 978}},
	{"crouch", 78, 89, 840, {96, 187, 270}},
	{"neutral_jump", 65, 152, 942, {92, 162, 236, 305, 379, 453, 524}},
	{"forward_jump", 122, 113, 1182, {94,223,366,506,645,782,912}},
	{"backward_jump", 122, 113, 1182, {912,782,645,506,366,223,94}},
	{"sjab", 119, 96, 1631, {109,230,109}}
})
cammy.state = "idle"
cammy.speed = 5
cammy.jumpv = 30
cammy.g = 3.9