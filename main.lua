require('sprites')
require('controls')

function love.load()
	min_dt = 1/30
	next_time = love.timer.getMicroTime()
	love.graphics.setMode(650, 650, false, true, 0)
	love.graphics.setBackgroundColor(255, 255, 255)
	i = 0
end

function love.update(dt)
	print(love.timer.getFPS())
	next_time = next_time + min_dt
	controls.update(sprites.cammy)
	if i == 2 then
		i = 0
		sprites.cammy:animate()
	else
		i = i + 1
	end
end

function love.draw()
	sprites.cammy:draw()

	local cur_time = love.timer.getMicroTime()
   if next_time <= cur_time then
      next_time = cur_time
      return
   end
   love.timer.sleep(1000*(next_time - cur_time))
end

function love.keypressed(key)
end