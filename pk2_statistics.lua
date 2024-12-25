--[==[
A tool to count PK2 pixels by color

Copyright (C) by SaturninTheAlien 2024

--]==]

local pk2Colors = {
    gray = 0,
    blue = 32,
    red = 64,
    green = 96,
    orange = 128,
    violet = 160,
    turquoise = 192,
    blinking = 224,
    exotic = 240,
    tilesetTransparent = 254,
    transparent = 255
}

local function getColorName(value)
    if value==pk2Colors.transparent then
        return "transparent"
    elseif value==pk2Colors.tilesetTransparent then
        return "tilesetTransparent"
    elseif value>=pk2Colors.exotic then
        return "exotic"
    end

    local color = 32 * (value // 32)
    
    for k, v in pairs(pk2Colors) do
        if v==color then
            return k
        end
    end

    return "unknown"
end

local function countPixels()
    if app.image==nil then
        print("Cannot count pixels, there's no image opened!")
        return
    end

    local res = {}

    for key, _ in pairs(pk2Colors) do
        res[key] = 0
    end

    local image = app.image
    local selection = app.sprite.selection

    for it in image:pixels() do
        if selection.isEmpty or selection:contains(it.x, it.y) then
            local color = getColorName(it())
            if res[color]==nil then
                res[color] = 1
            else
                res[color] = res[color] + 1
            end 
        end
    end

    -- sorting
    local values = {}
    for key, value in pairs(res) do
        table.insert(values, {k = key, v = value})
    end

    table.sort(values, function (a, b)
        return a.v > b.v        
    end)

    print("PK2 Colors statistics:")
    for _, tmp in ipairs(values) do
        print(tmp.k .. " -> " .. tostring(tmp.v))
    end
 
end

countPixels()