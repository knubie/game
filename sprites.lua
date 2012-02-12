module(..., package.seeall)

local sheets = {}

function set_states(sheet, state_table)
	for k,v in pairs(state_table) do
		sheet["state"][k] = v
	end
end

function new_sheet(w, h, img)
	return {cellw= w, cellh = h, img = love.graphics.newImage(img), state = {}}
end

sheets["zelda"] = new_sheet(40, 40, "darklink_lttp-oot-younglink_sheet.png")

set_states(sheets["zelda"], {
	front_idle = {0,0},
	front_walk1 = {1,0},
	front_walk2 = {2,0},
	front_walk3 = {3,0},
	front_walk4 = {4,0},
	front_walk5 = {5,0},
	front_walk6 = {6,0},
	front_walk7 = {7,0}
})

function draw(sheet_name, sk, x, y)
	sheet = sheets[sheet_name]
	local quad = love.graphics.newQuad(
		sheet["cellw"]*sheet["state"][sk][1], sheet["cellh"]*sheet["state"][sk][2],
		sheet["cellw"], sheet["cellh"],
		sheet["img"]:getWidth(), sheet["img"]:getHeight()
	)
	love.graphics.drawq(sheet["img"], quad, x, y)
end