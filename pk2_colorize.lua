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


local dlg = Dialog {title = "PK2 colorize"}
dlg:combobox {
    id = "colorName",
    label = "PK2 color",
    option = "gray",
    options = {
        "gray",
        "blue",
        "red",
        "green",
        "orange",
        "violet",
        "turquoise"
    }
}

dlg:button{
    id = "ok",
    text = "OK",
    focus = true,
    onclick = function()
        local colorIndex = pk2Colors[dlg.data.colorName]
        if app.image==nil then
            print("Cannot colorize, there's no image opened!")
            return
        end


        local selection = app.sprite.selection
        
        local image = app.image:clone()
        for it in image:pixels() do
            local value = it() -- get pixel

            if value < pk2Colors.blinking then
                local brightness = value % 32
                value = brightness + colorIndex

                if selection.isEmpty or selection:contains(it.x, it.y) then
                    it(value)
                end 
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