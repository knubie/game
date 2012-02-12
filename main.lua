require('sprites')

function love.load()
	sprite = love.graphics.newImage("fft.png")
	knife = love.graphics.newQuad(2, 4, 13, 9, 436, 360)
	camera = {}
	camera.x = 0
	camera.y = 0
	camera.scaleX = 1
	camera.scaleY = 1
	camera.rotation = 0
end

function love.draw()
	--camera:set()
	sprites.draw("zelda", "front_idle", 0, 0)
	--camera:unset()
end


-- knifex = 50
-- knifey = 50
-- gravity = 1
-- momentumx = 0
-- function love.draw()
-- 	camera:set()
-- 	sprites.zelda.draw(front_idle, 0, 0)
-- 	camera:unset()
-- end

-- function love.update()
-- 	if love.keyboard.isDown('left') then 
-- 		momentumx = momentumx - 1
-- 	end
-- 	if love.keyboard.isDown('right') then 
-- 		momentumx = momentumx + 1
-- 	end
-- 	if love.keyboard.isDown('up') then knifey = knifey - 1 end
-- 	if love.keyboard.isDown('down') then knifey = knifey + 1 end
-- 	knifex = knifex + momentumx
-- 	knifey = knifey + gravity
-- 	if knifex <= 0 then
-- 		momentumx = momentumx - momentumx*2
-- 	end
-- 	if knifex >= love.graphics.getWidth()-13 then
-- 		momentumx = momentumx - momentumx*2
-- 	end
-- 	if knifey <= love.graphics.getHeight() then
-- 		gravity = gravity + 1
-- 	else
-- 		gravity = gravity - gravity*2
-- 		if momentumx > 0 then
-- 			momentumx = momentumx - 2
-- 		end
-- 	end
-- end
