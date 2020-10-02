require 'init'

local bgColor = hex.rgb("5500AA")

local mouseCoords = Debug:addMessage('Mouse Coords: 0, 0')

function love.update(dt)
    Debug:update(dt)

    local mouseX, mouseY = love.mouse.getPosition()
    Debug:updateMessage(mouseCoords, 'Mouse Coords: ' .. mouseX .. ', ' .. mouseY)
end

function love.draw()
    Debug:draw()
    love.graphics.setBackgroundColor(bgColor)
end