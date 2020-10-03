local mt = {
    __call = function(t, ...) return t.init(...) end
}
local enum = {}

function enum.init(keyval, name)
    local enumTable = {}
    if name == nil then name = "enum" end
    local metatable = {
        __name = name,
        __index = function(t, k) error("No property '"..k.."' in enum '"..getmetatable(t).__name.."'") end,
        __newindex = function(t, k, v) error("Attempted to set property '"..k.."' on '"..getmetatable(t).__name.."' to '"..v.."'") end
    }
    for key, value in pairs(keyval) do
        enumTable[key] = value
    end

    setmetatable(enumTable, metatable)
    return enumTable
end

setmetatable(enum, mt)
return enum