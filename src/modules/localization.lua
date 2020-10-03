--- Localization Module
--- Used to get localized text strings
-- @module Localization

local localization = {}

function localization:init(locale)
    self.locale = locale or "en-ca"

    print("[LOG] Initializing Localization")
    local filePath = "locale/" .. self.locale .. ".json"
    print("[LOG] Looking for locale file at " .. filePath)
    local localeFile = love.filesystem.newFile(filePath)
    local ok, err = localeFile:open(enums.FileMode.read)
    if ok then
        print("[LOG] File Object Opened for " .. self.locale)
        local contents, size = localeFile:read()
        self.localeStrings = json.decode(contents)
    else
        print("[ERROR] " .. err)
        print("[ALERT] Rerunning initialization with default locale")
        self:init()
    end
end

function localization:getString(localeString, inserts)
    local stringParts = Util.splitString(localeString, '.')

    -- To ensure the parts stay in order
    local order = {}
    for k in pairs(stringParts) do
        table.insert(order, k)
    end

    table.sort(order)

    local textLocation = self.localeStrings
    for index = 1, #order do
        textLocation = textLocation[stringParts[index]]

        -- Can't go deeper if the current location doesn't exist
        if textLocation == nil then break end
    end

    local responseString = Util.fallback(textLocation, localeString)

    if responseString ~= localeString then
        if inserts ~= nil then
            for index = 1, #inserts do
                responseString = string.gsub(responseString, tostring("$" .. index), inserts[index]) 
            end
        end
    end

    return responseString
end

return localization