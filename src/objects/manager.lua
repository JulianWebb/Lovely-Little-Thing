local objectManager = {}

function objectManager:init(location)
    local directoryItems = love.filesystem.getDirectoryItems(location)
    self.objects = {}
    for _, value in ipairs(directoryItems) do
        local fullPath = location .. '/' .. value
        local potentialDir = love.filesystem.getInfo(fullPath)
        if potentialDir.type == e.FileType.directory then
            self.objects[value] = self:scanDir(fullPath)
        end
    end
end

function objectManager:scanDir(location)
    local directoryItems = love.filesystem.getDirectoryItems(location)
    local tree = {}
    for _, value in ipairs(directoryItems) do
        local fullPath = location .. '/' .. value
        local itemInfo = love.filesystem.getInfo(fullPath)
        if itemInfo.type == e.FileType.directory then
            tree[value] = self:scanDir(fullPath)
        elseif itemInfo.type == e.FileType.file then
            if string.find(value, '.lua') then
                local requireString = string.gsub(string.gsub(fullPath, '.lua', ''), '/', '.')
                Console.log(requireString)
                tree[string.gsub(value, '.lua', '')] = require(requireString)
            end
        end
    end

    return tree
end

return objectManager
