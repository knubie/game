module(..., package.seeall)
require('states')

sheets = {}

function new (src)
	table.insert(sheets, {
		img = love.graphics.newImage(src),
		states = {}
	})

	local sprite = {
		x = 0,
		y = 0,
		state = "idle",
		frame = 1,
		sheet_id = #sheets,
		facing = "right",
		speed = 0,
		jumpv = 0,
		jumpx = 0,
		dy = 0,
		g = 0,
		up = "up",
		down = "down",
		left = "left",
		right = "right",
		jab = " ",
		opponent = nil
	}

	function sprite:init_states (new_states)

		local function make_state (state_name, w, h, y, frames)
			local sheet = sheets[self.sheet_id]
			sheet.states[state_name] = {
				width = w,
				height = h,
				y = y,
				frames = {},
				hittable_box = {}
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
		if self.facing == "left" then
			quad:flip(true, false)
		end
		love.graphics.drawq(sheet.img, quad, self.x, 650-state.height+self.y)
	end

	function sprite:hittable_box ()
		local sheet = sheets[self.sheet_id]
		local state = sheet.states[self.state]
		return "line", self.x, 650-state.height+self.y, state.width, state.height
	end

	function sprite:animate ()
		local last_frame = #sheets[self.sheet_id].states[self.state].frames
		if self.frame < last_frame then -- if not at last frame, increment
			self.frame = self.frame + 1
		else -- at last frame
			if self.state == "crouch" then
				self.frame = last_frame -- continue crouching
			else
				self.frame = 1 -- start the state animation from the beginning
			end
		end
	end

	function sprite:set_state (state_name)
		if self.state ~= state_name then
			self.frame = 1
			self.state = state_name
		end
	end

	function sprite:set_face ()
		if self.state ~= "neutral_jump" and self.state ~= "forward_jump" and self.state ~= "backward_jump" then
			if self.x < self.opponent.x then self.facing = "right" else self.facing = "left" end
		end
	end

	function sprite:get_width ()
		local sheet = sheets[self.sheet_id]
		local state = sheet.states[self.state]
		return state.width
	end

	function sprite:get_height ()
		local sheet = sheets[self.sheet_id]
		local state = sheet.states[self.state]
		return state.height
	end

	function sprite:left_side ()
		return self.x
	end

	function sprite:right_side ()
		return self.x + self:get_width()
	end

	function sprite:bottom ()
		return 650+self.y
	end

	function sprite:top ()
		return 650-self:get_height()+self.y
	end

	function sprite:is_on_left ()
		return self.x < self.opponent.x
	end

	function sprite:is_on_right ()
		return self.x > self.opponent.x
	end

	function sprite:crouch()
		self:set_state("crouch")
	end

	return sprite
end

p1 = new('assets/cammy.png')
p1:init_states(states.cammy)
p1.speed = 5
p1.jumpv = 30
p1.g = 3.9

p2 = new('assets/cammy.png')
p2:init_states(states.cammy)
p2.x = 400
p2.speed = 5
p2.jumpv = 28
p2.g = 3.9
p2.facing = "left"
p2.up = "w"
p2.down = "s"
p2.left = "a"
p2.right = "d"
p2.jab = "e"


p2.opponent = p1
p1.opponent = p2