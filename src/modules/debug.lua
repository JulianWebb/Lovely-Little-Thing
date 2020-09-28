--- Debug Module
--- Shows the debug list
-- @module debug
local debug = {}

--- Creates 4 digit random ID using a-z
-- @return string ID
local function randomID()
    local id = ''
    repeat
        local randInt = math.random(97, 122)
        local char = string.char(randInt)
        id = id .. char
    until #id == 4

    return id
end

--- Removes nil entries from table
--- and moves higher entries down
-- @param table Table to be cleaned
-- @return table Cleaned table
local function cleanTable(dirty)
    local order = {}
    for key in pairs(dirty) do
        table.insert(order, key)
    end
    table.sort(order)

    local clean = {}
    for key, value in ipairs(order) do
        table.insert(clean, dirty[value])
    end
    return clean
end

--- Initalize the debug module
--- All it really does is show a list of messages
--- Probably should rename it at some point and make
--- an actual debug module
-- @param table style parameter for the draw function
-- @param string the character used to toggle the display
function debug:init(style, debugKey)
    self.style = Util.mergeTables({
        textColor = hex.rgb('AAFF55'),
        backgroundColor = hex.rgb('8FAD71')
    }, style)

    self.debugKey = Util.fallback(debugKey, 'f5')
    self.keyPressed = false
    self.showDebug = false

    self.messageList = {}
    self.positionList = {}
end

--- Add message to list
-- @param string message to add
-- @return string message identifier
function debug:addMessage(message)
    if message == nil then return nil end
    local messageID = randomID()
    self.messageList[messageID] = message
    table.insert(self.positionList, messageID)

    return messageID
end

--- Checks if message exists in list
-- @param string message identifier
-- @return string Returns position if message exists otherwise nil
function debug:messageExists(id)
    for key, value in ipairs(self.positionList) do
        if value == id then
            return key
        end
    end

    return nil
end

--- Update message in list
-- @param string message identifier
-- @param string updated text for message
-- @return boolean success of update
function debug:updateMessage(id, message)
    local exists = self:messageExists(id)
    if exists ~= nil then
        self.messageList[id] = message
        return true
    end

    return false
end

--- Remove message from list
-- @param string message identifer
-- @return boolean success of removal
function debug:removeMessage(id)
    local exists = self:messageExists(id)
    if exists ~= nil then
        table.remove(self.positionList, exists)
        table.remove(self.messageList, id)
        self.positionList = cleanTable(self.positionList)
        return true
    end

    return false
end

--- Clears list of all messages
function debug:clearList()
    self.messageList = {}
    self.positionList = {}
end

--- Update function
-- @param dt Update delta
function debug:update(dt)
    if love.keyboard.isDown(self.debugKey) then
        if not self.keyPressed then
            self.showDebug = not self.showDebug
        end
        self.keyPressed = true
    else
        self.keyPressed = false
    end
end

--- Draw function
function debug:draw()
    if self.showDebug then
        for key, value in ipairs(self.positionList) do
            love.graphics.setColor(self.style.textColor)
            love.graphics.print(self.messageList[value], 10, 12*key)
        end
    end
end

return debug