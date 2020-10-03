require 'init'

local bgColor = hex.rgb("5500AA")
local mouseCoords = Debug:addMessage('Mouse Coords: 0, 0')

local testButton = ObjectManager.objects.interface.button(nil, {
    color = {
        active = {
            fill = hex.rgb('0000AA'),
            text = hex.rgb('FFFFFF')
        }
    },
    font = AssetManager.fonts['RubberNippleFactory'],
    borderRadius = 0
},{
    sounds = {
        [enums.ButtonState.pressed] = nil
    },
    text = "hello world"
})

function love.update(dt)
    Debug:update(dt)

    local mouseX, mouseY = love.mouse.getPosition()
    Debug:updateMessage(mouseCoords, 'Mouse Coords: ' .. mouseX .. ', ' .. mouseY)
    testButton:update(dt)
end

function love.draw()
    Debug:draw()
    love.graphics.setBackgroundColor(bgColor)
    testButton:draw()
end