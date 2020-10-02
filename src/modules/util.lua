--- Utility Modules
--- Basically any reused function that doesn't have a category
-- @module Util

local util = {}

function util.fallback(value, default)
    if value == nil then
        return default
    else
        return value
    end
end

function util.pointInBox(pointX, pointY, boxLeft, boxRight, boxTop, boxBottom)
    return (pointX > boxLeft and pointX < boxRight) and (pointY > boxTop and pointY < boxBottom)
end

function util.splitString(toSplit, sep)
    local seperator = sep or "%s"

    local splitTable = {}
    for subString in string.gmatch(toSplit, "([^"..seperator.."]+)") do
        table.insert(splitTable, subString)
    end

    return splitTable
end

function util.mergeTables(original, new)
    if new == nil then return original end

    local merged = original
    for key in pairs(new) do
        if type(new[key]) == "table" then
            if original[key] == nil then original[key] = {} end
            merged[key] = util.mergeTables(original[key], new[key])
        else
            merged[key] = new[key]
        end
    end

    return merged
end

function util.clamp(num, low, high)
    return math.min(math.max(low, num), high)
end

return util