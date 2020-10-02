local Base = require 'objects.interface.base'

local Group = Base:extend()

function Group:new(parent, style)
    self.super:new(parent, style)
    self.style = Util.mergeTables(self.style, Util.mergeTables({}, style))
end

function Group:update(dt)
    self.super:update(dt)
end

function Group:draw()
    self.super:draw()
end

return Group