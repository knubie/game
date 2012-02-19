module(..., package.seeall)
require('states')

local GROUND = 650
local BLUE_BOX = {
	x = 18,
	y = 2,
	width = 40,
	height = 89
}
local CENTER = 40
local SHAKE_DUR = 7

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
		foe = nil,
		shake_frame = 0,
		push_back_frame = 0,
		hitting = false,
		blue_box = {},
		red_box = {0,0,0,0}
	}

	function sprite:init_states (new_states)

		local function make_state (state_name, w, h, y, frames)
			local sheet = sheets[self.sheet_id]
			sheet.states[state_name] = {
				width = w,
				height = h,
				y = y,
				frames = {},
				blue_box = {}
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
			love.graphics.drawq(sheet.img, quad, self.x-state.width+CENTER, GROUND-self:get_height()+self.y)
		else
			love.graphics.drawq(sheet.img, quad, self.x-CENTER, GROUND-self:get_height()+self.y)
		end
	end

	function sprite:movex(v)
		if self.x-CENTER > 0 and self.x-CENTER+self:get_width() < 650 then
			self.x = self.x+v
		end
	end

	function sprite:hit (recovery_frames)

		local function shake ()
			print('shaking')
			print('shake frame:')
			print(self.shake_frame)
			if self.shake_frame%2 ~= 0 then
				self:movex(2)
				-- self.x = self.x+2
			else
				self:movex(-2)
				-- self.x = self.x-2
			end
		end

		local function push_back ()
			print('red_box:')
			print(self.foe.red_box[1])
			print('pushing back')
			if self.facing == "left" then
				self:movex(3)
				-- self.x = self.x + 3
			else
				self:movex(-3)
				-- self.x = self.x - 3
			end
		end
	-- 	while i < 10
		if self.shake_frame < SHAKE_DUR then
			shake()
			self.shake_frame = self.shake_frame + 1
	-- 		hold on first frame
		else
			if self.push_back_frame < recovery_frames then
				push_back()
				self.push_back_frame = self.push_back_frame + 1
			else
				self.push_back_frame = 0
				self.shake_frame = 0
				self:set_state("idle")
			end
		end
	-- 		recover(hit.for_recovery_frames)
	-- 	end

	-- 	function recover()
	-- 		move back
	-- 	end

	end



	function sprite:animate ()

		local last_frame = #sheets[self.sheet_id].states[self.state].frames

		if self.shake_frame > 0 and self.shake_frame < SHAKE_DUR then
			self.frame = 1

		elseif self.hitting == true then
			self.frame = 2

		else
			if self.frame < last_frame then -- if not at last frame, increment
				self.frame = self.frame + 1
			else -- at last frame
				if self.state == "crouch" or self.state == "neutral_jump" or self.state == "forward_jump" or self.state == "backward_jump" or self.state == "light_hit" then
					self.frame = last_frame -- continue crouching
				else
					self.frame = 1 -- start the state animation from the beginning
				end
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
		if not self:jumping() then
			if self.x < self.foe.x then self.facing = "right" else self.facing = "left" end
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

	function sprite:blue_box ()
		if self.facing == "right" then
			return self.x+BLUE_BOX.x-CENTER, GROUND-self:get_height()+self.y+BLUE_BOX.y, BLUE_BOX.width, BLUE_BOX.height
		else
			return self.x-BLUE_BOX.x-BLUE_BOX.width+CENTER, GROUND-self:get_height()+self.y+BLUE_BOX.y, BLUE_BOX.width, BLUE_BOX.height
		end
	end

	function sprite:crouch()
		self:set_state("crouch")
	end

	function sprite:init_jump(direction)

		local state = ""

		if direction == "neutral" then
			state = "neutral_jump"
		elseif direction == self.facing then
			state = "forward_jump"
		else
			state = "backward_jump"
		end

		if direction == "right" then
			if self.x < 650 - 50 then
				self.jumpx = self.speed + 2.5
			end
		elseif direction == "left" then
			if self.x > 50 then
				self.jumpx = 0 - (self.speed + 2.5)
			end
		else
			self.jumpx = 0
		end

		if self.state ~= state then
			self.dy = self.jumpv
			self:set_state(state)
		end
	end

	function sprite:walk(direction)
		local walk = ""
		if direction == self.facing then
			walk = "walk_forward"
		else
			walk = "walk_backward"
		end

		self:set_state(walk)

		if direction == "right" then
			self:movex(self.speed)
			-- if self.x < 650 - 50 then
			-- 	self.x = self.x + self.speed
			-- end
		else
			self:movex(0-self.speed)
			-- if self.x > 50 then
			-- 	self.x = self.x - self.speed
			-- end
		end
	end

	function sprite:jumping()
		return self.state == "neutral_jump" or self.state == "forward_jump" or self.state == "backward_jump"
	end

	function sprite:sjab()
		if self.frame == 2 and self.hitting == false then
			if self.facing == "right" then
				return self.x+82-CENTER, GROUND-self:get_height()+self.y+10, 38, 15
			else
				return self.x-82-38+CENTER, GROUND-self:get_height()+self.y+10, 38, 15
			end
		else
			self.hitting = false
			return 0,0,0,0
		end
	end

	return sprite
end

p1 = new('assets/cammy.png')
p1:init_states(states.cammy)
p1.speed = 5
p1.jumpv = 23
p1.g = 2.4

p2 = new('assets/cammy.png')
p2:init_states(states.cammy)
p2.x = 400
p2.speed = 5
p2.jumpv = 30
p2.g = 3.9
p2.facing = "left"
p2.up = "w"
p2.down = "s"
p2.left = "a"
p2.right = "d"
p2.jab = "e"


p2.foe = p1
p1.foe = p2