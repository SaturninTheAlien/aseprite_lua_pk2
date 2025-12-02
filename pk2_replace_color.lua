--[==[
A tool to change PK2 colors just like PK2 does it with sprites.

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


local colorNames = {
    "gray",
    "blue",
    "red",
    "green",
    "orange",
    "violet",
    "turquoise"
}

local dlg = Dialog {title = "PK2 colorize"}


dlg:combobox {
    id = "oldColor",
    label = "old color",
    option = "gray",
    options = colorNames
}

dlg:combobox {
    id = "newColor",
    label = "new color",
    option = "gray",
    options = colorNames
}


dlg:button{
    id = "ok",
    text = "OK",
    focus = true,
    onclick = function()

        if app.image==nil then
            print("Cannot colorize, there's no image opened!")
            return
        end

        local oldColorIndex = pk2Colors[dlg.data.oldColor]
        local newColorIndex = pk2Colors[dlg.data.newColor]

        print(oldColorIndex)
        print(newColorIndex)

        if oldColorIndex==newColorIndex then
            print("It doesn't make any sense!")
            return
        end

        local selection = app.sprite.selection
        
        
        local image = app.image:clone()
        for it in image:pixels() do

            if selection.isEmpty or selection:contains(it.x, it.y) then

                local value = it() -- get pixel
                local colorType = 32 *(value // 32 )
                if colorType == oldColorIndex then
                    local brightness = value % 32
                    value = brightness + newColorIndex
                end
                it(value)
            end
        end

        app.image:drawImage(image)

        app.refresh()
    end
}


dlg:button {
    id = "cancel",
    text = "CANCEL",
    onclick = function()
        dlg:close()
    end
}

dlg:show { wait = false }