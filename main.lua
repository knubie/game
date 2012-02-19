dofile('dumper.lua')
require('sprites')
require('actions')
require('collisions')
require('effects')

function love.load()
	min_dt = 1/30
	next_time = love.timer.getMicroTime()
	love.graphics.setMode(650, 650, false, true, 0)
	-- love.graphics.setBackgroundColor(255, 255, 255)
	i = 0
end

function love.update(dt)
	-- print(love.timer.getFPS())
	next_time = next_time + min_dt

	print('hitting:')
	print(sprites.p1.hitting)

	collisions.update(sprites.p1)
	collisions.update(sprites.p2)
	actions.update(sprites.p1)
	actions.update(sprites.p2)

	if i == 2 then
		i = 0
		sprites.p1:animate()
		sprites.p2:animate()
		effects.small_spark:animate()
	else
		i = i + 1
	end
end

function love.draw()
	sprites.p1:draw()
	sprites.p2:draw()
	effects.small_spark:draw()
	

	-- love.graphics.rectangle("line", sprites.p1:blue_box())
	-- love.graphics.rectangle("line", sprites.p1:sjab())
	-- love.graphics.rectangle("line", sprites.p2:blue_box())
	-- love.graphics.rectangle("line", sprites.p1.x, 0, 1, 650)
	-- love.graphics.rectangle("line", sprites.p2.x, 0, 1, 650)

	local cur_time = love.timer.getMicroTime()
   if next_time <= cur_time then
      next_time = cur_time
      return
   end
   love.timer.sleep(1000*(next_time - cur_time))
end

function love.keypressed(key)
end