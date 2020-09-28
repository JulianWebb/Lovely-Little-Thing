--- Console Module
-- @module Console

local Console = {}

--- Generates whitespace based on parameter
-- @param number the amount of indents
-- @param string the indent string, optional
-- @return string the indent string repeated by amount
local function indent(amount, indentString)
    local indentString = Util.fallback(indentString, "\32\32\32\32")
    return string.rep(indentString, amount)
end

--- Basic print function, generally not used in favour
--- of other Console functions
-- @param string Category for message
-- @param string Message
function Console.print(category, message)
    print(l10n:getString("console.message", {
        [1] = category,
        [2] = message
    }))
end

--- Log print function
-- @param string Message
function Console.log(message)
    Console.print(l10n:getString("console.log"), message)
end

--- Alert print function
-- @param string Message
function Console.alert(message)
    Console.print(l10n:getString("console.alert"), message)
end

--- Error print function
-- @param string Mesage
function Console.error(message)
    Console.print(l10n:getString("console.error"), message)
end

--- Table print function
--- Used recursively to print lua tables
-- @param table Table to print
-- @param number Indent level (optional, default: 0)
-- @param string Indent string (optional, default: '    ')
-- @return string Table substring, only used for recursion
function Console.table(object, level, indentString)
    local level = Util.fallback(level, 0)
    local indentString = Util.fallback(indentString, "\32\32\32\32")

    if type(object) == 'table' then
        local objString = "{\n"
        for key, value in pairs(object) do
            if type(key) == "string" then key = '"' .. key .. '"' end
            key = '[' .. key .. ']'
            if type(value) == "string" then value = '"' .. value .. '"' end
            objString = objString .. indent(level + 1, indentString) .. key .. " = " .. Console.table(value, level + 1)
            
            if type(value) ~= "table" then
                objString = objString .. ",\n"
            end
        end
        if level == 0 then
            print(string.sub(objString, 1, string.len(objString) - 2) .. "\n" .. indent(level, indentString) .. '}')
        else
            return string.sub(objString, 1, string.len(objString) - 2) .. "\n" .. indent(level, indentString) ..  '},\n'
        end
    else
        if level == 0 then
            print(tostring(object))
        else
            return tostring(object)
        end
    end
end

return Console