local assetManager = {}

function assetManager:init(location)
    self.location = Util.fallback(location, 'assets')
    Console.log(l10n:getString('console.from', { l10n:getString('console.loading', { 'Assets' }), self.location .. '/'}))

    self.fonts   = self:loadAssets(self.location .. '/fonts', 'font', self.addFont)
    self.sounds  = self:loadAssets(self.location .. '/sounds', 'sound', self.addSound)
    self.music   = self:loadAssets(self.location .. '/music', 'music', self.addMusic)
    self.sprites = self:loadAssets(self.location .. '/sprites', 'sprite', self.addSprite)
end

function assetManager:loadAssets(location, type, func)
    local list = {}
    local assets = love.filesystem.getDirectoryItems(location)
    for _, value in ipairs(assets) do
        if value == nil then break end
        Console.log(l10n:getString('console.assets.' .. type, { value }))
        local name = string.match(value, "[^$.]+")
        local path = location .. '/' .. value
        list[name] = func(self, path)
    end

    return list
end

function assetManager:addFont(path)
    local font = love.graphics.newFont(path)
    return font
end

function assetManager:addSound(path)
    local sound = love.audio.newSource(path, e.SourceType.static)
    return sound
end

function assetManager:addMusic(path)
    local music = love.audio.newSource(path, e.SourceType.stream)
    return music
end

function assetManager:addSprite(path)
    local sprite = love.graphics.newImage(path)
    return sprite
end

return assetManager