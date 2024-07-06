function love.main()
    love.graphics.print("Hello World", 400, 300)
end

function love.draw()
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle('fill', 5, 5, 10, 10)
end
