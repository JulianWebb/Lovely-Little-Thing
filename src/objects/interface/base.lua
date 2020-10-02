local Base = Object:extend()

function Base:new(parent, style)
    self.parent = Util.fallback(parent, nil)

    self.style = Util.mergeTables({
        padding = 2,
        minWidth = 1,
        maxWidth = 100,
        minHeight = 1,
        maxHeight = 100
    }, style)
end

function Base:update(dt)

end

function Base:draw()

end

return Base