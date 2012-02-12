module(..., package.seeall)

local sheets = {}

function new_state(sprite, state_name, w, h, y, frames)
	local sheet = sheets[sprite.sheet_id]
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
	return {x = 0, state = nil, frame = 1, active = false, sheet_id = #sheets}
end

function animate(sprite)
	if sprite.active == false then
		sprite.state = "stance"
	end
	if sprite.frame < #sheets[sprite.sheet_id].states[sprite.state].frames then
		sprite.frame = sprite.frame + 1
	else
		sprite.frame = 1
	end
end