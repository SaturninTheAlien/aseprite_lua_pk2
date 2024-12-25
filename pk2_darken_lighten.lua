--[==[
A tool to darken or lighten PK2 graphics.
It can work on the selection or on the whole image.

Copyright (C) SaturninTheAlien 2024

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

local function lighten(offset)
    if app.image==nil then
        print("There's no image opened!")
        return
    end

    local selection = app.sprite.selection

    local image = app.image:clone()
    for it in image:pixels() do
        local value = it() -- get pixel

        if value < pk2Colors.blinking then

            if selection.isEmpty or selection:contains(it.x, it.y) then

                local brightness = value % 32
                local color = value // 32

                brightness = brightness + offset
                if brightness > 31 then
                    brightness = 31
                elseif brightness < 0 then
                    brightness = 0
                end

                it(32*color + brightness)
            end
        end
    end

    app.image:drawImage(image)

    app.refresh()

end


local dlg = Dialog {title = "PK2 Darken or lighten"}

dlg:button{
    id = "darken",
    text = "Darken",
    focus = true,
    onclick = function ()
        lighten(-1)
    end
}

dlg:button{
    id = "lighten",
    text = "Lighten",
    focus = true,
    onclick = function ()
        lighten(1)
    end
}

dlg:show { wait = false }