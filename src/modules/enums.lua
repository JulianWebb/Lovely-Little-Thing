local module = {}

module.DrawMode = {
    fill = "fill",
    line = "line"
}
module.Mouse = {
    primary = 1,
    secondary = 2,
    middle = 3
}
module.FileType = {
    file = "file",
    directory = "directory",
    dir = "directory",
    symlink = "symlink",
    other = "other"
}
module.ContainerType = {
    data = "data",
    string = "string"
}
module.FileMode = {
    r = "r",
    read = "r",
    w = "w",
    write = "w",
    a = "a",
    append = "a",
    c = "c",
    closed = "c"
}
module.SourceType = {
    static = "static",
    stream = "stream",
    queue  = "queue"
}

-- Homemade enums
module.ButtonState = {
    normal      = 0,
    under       = 1,
    pressed     = 2,
    released    = 3
}

return module
