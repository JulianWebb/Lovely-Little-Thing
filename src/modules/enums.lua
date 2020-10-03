local module = {}

module.DrawMode = builtins.enum({
    fill = "fill",
    line = "line"
}, "DrawMode")

print(module.DrawMode)
module.Mouse = builtins.enum({
    primary = 1,
    secondary = 2,
    middle = 3
}, "Mouse")

module.FileType = builtins.enum({
    file = "file",
    directory = "directory",
    dir = "directory",
    symlink = "symlink",
    other = "other"
}, "FileType")

module.ContainerType = builtins.enum({
    data = "data",
    string = "string"
}, "ContainerType")

module.FileMode = builtins.enum({
    r = "r",
    read = "r",
    w = "w",
    write = "w",
    a = "a",
    append = "a",
    c = "c",
    closed = "c"
}, "FileMode")

module.SourceType = builtins.enum({
    static = "static",
    stream = "stream",
    queue  = "queue"
}, "SourceType")

-- Homemade enums
module.ButtonState = builtins.enum({
    normal      = 0,
    under       = 1,
    pressed     = 2,
    released    = 3
}, "ButtonState")

return module
