function love.load()
	sprite = love.graphics.newImage("fft.png")
	knife = love.graphics.newQuad(2, 4, 13, 9, 436, 360)
	camera = {}
	camera.x = 0
	camera.y = 0
	camera.scaleX = 1
	camera.scaleY = 1
	camera.rotation = 0

	function camera:set()
	  love.graphics.push()
	  love.graphics.rotate(-self.rotation)
	  love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
	  love.graphics.translate(-self.x, -self.y)
	end

	function camera:unset()
	  love.graphics.pop()
	end

	function camera:move(dx, dy)
	  self.x = self.x + (dx or 0)
	  self.y = self.y + (dy or 0)
	end

	function camera:rotate(dr)
	  self.rotation = self.rotation + dr
	end

	function camera:scale(sx, sy)
	  sx = sx or 1
	  self.scaleX = self.scaleX * sx
	  self.scaleY = self.scaleY * (sy or sx)
	end

	function camera:setPosition(x, y)
	  self.x = x or self.x
	  self.y = y or self.y
	end

	function camera:setScale(sx, sy)
	  self.scaleX = sx or self.scaleX
	  self.scaleY = sy or self.scaleY
	end

	knifex = 50
	knifey = 50
	gravity = 1
	momentumx = 0
	function love.draw()
		camera:set()
		love.graphics.drawq(sprite, knife, knifex, knifey)
		camera:unset()
	end

	function love.update()
		if love.keyboard.isDown('left') then 
			momentumx = momentumx - 1
		end
		if love.keyboard.isDown('right') then 
			momentumx = momentumx + 1
		end
		if love.keyboard.isDown('up') then knifey = knifey - 1 end
		if love.keyboard.isDown('down') then knifey = knifey + 1 end
		knifex = knifex + momentumx
		knifey = knifey + gravity
		if knifex <= 0 then
			momentumx = momentumx - momentumx*2
		end
		if knifex >= love.graphics.getWidth()-13 then
			momentumx = momentumx - momentumx*2
		end
		if knifey <= love.graphics.getHeight() then
			gravity = gravity + 1
		else
			gravity = gravity - gravity*2
			if momentumx > 0 then
				momentumx = momentumx - 2
			end
		end
	end
end