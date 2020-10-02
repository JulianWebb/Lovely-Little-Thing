local Base = require 'objects.interface.base'

local Button = Base:extend()

function Button:new(parent, style, options)
    Button.super:new(parent, style)
    self.style = Util.mergeTables(self.style,
        Util.mergeTables({
            color = {
                normal = {
                    fill = hex.rgb('ffffff'),
                    border = hex.rgb('dddddd'),
                    text = hex.rgb('000000')
                },
                hover = {
                    fill = hex.rgb('dddddd'),
                    border = hex.rgb('bbbbbb'),
                    text = hex.rgb('000000')
                },
                active = {
                    fill = hex.rgb('bbbbbb'),
                    border = hex.rgb('999999'),
                    text = hex.rgb('000000')
                }
            },
            font = AssetManager.fonts['RubberNippleFactory'],
            borderWidth = 2,
            borderRadius = 0
        }, style))

    self.style.color.current = self.style.color.normal

    self.sounds = Util.mergeTables({
        [e.ButtonState.pressed] = nil,
        [e.ButtonState.released] = nil
    }, options.sounds)

    local textString = Util.fallback(options.text, l10n:getString("game.missingString"))
    self.text = love.graphics.newText(self.style.font, textString)

    -- positioning
    if self.parent == nil then
        self.mask = {}
        self.mask.centre = {}
        self.mask.centre.x = love.graphics.getWidth()/2
        self.mask.centre.y = love.graphics.getHeight()/2
        self.mask.width = self.text:getWidth() * 1.25;
        self.mask.height = self.text:getHeight() * 1.25
        self.mask.left = self.mask.centre.x - (self.mask.width / 2)
        self.mask.right = self.mask.centre.x + (self.mask.width / 2)
        self.mask.top = self.mask.centre.y - (self.mask.height / 2)
        self.mask.bottom = self.mask.centre.y + (self.mask.height / 2)
    end

    self.stat = e.ButtonState.normal
    self.pressedCount = 0
    self.debug = Debug:addMessage()
end

function Button:update(dt)
    if Util.pointInBox(love.mouse.getX(), love.mouse.getY(), self.mask.left, self.mask.right, self.mask.top, self.mask.bottom) then
        if love.mouse.isDown(e.Mouse.primary) then
            if self.state ~= e.ButtonState.pressed then
                if (self.sounds[e.ButtonState.pressed] ~= nil) then
                    self.sounds[e.ButtonState.pressed]:play()
                end
                self.state = e.ButtonState.pressed
                self.pressedCount = self.pressedCount + 1
                Debug:updateMessage(self.debug, "Button pressed " .. self.pressedCount .. " times.")
            end
            self.style.color.current = self.style.color.active
        else
            self.style.color.current = self.style.color.hover
            self.state = e.ButtonState.under
        end
    else
        self.style.color.current = self.style.color.normal
        self.state = e.ButtonState.normal
    end
end

function Button:draw()
    -- Infill
    love.graphics.setColor(self.style.color.current.fill)
    love.graphics.rectangle(e.DrawMode.fill, self.mask.left, self.mask.top, self.mask.width, self.mask.height, self.style.borderRadius, self.style.borderRadius)
    -- Border
    love.graphics.setColor(self.style.color.current.border)
    love.graphics.setLineWidth(self.style.borderWidth)
    love.graphics.rectangle(e.DrawMode.line, self.mask.left, self.mask.top, self.mask.width, self.mask.height, self.style.borderRadius, self.style.borderRadius)
    -- Text
    love.graphics.setColor(self.style.color.current.text)
    love.graphics.draw(self.text, self.mask.centre.x - (self.text:getWidth()/2), self.mask.centre.y - (self.text:getHeight()/2))
end

return Button