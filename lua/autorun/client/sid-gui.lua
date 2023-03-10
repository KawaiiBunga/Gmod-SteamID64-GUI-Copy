local radius = 500 -- The radius in which the names and SteamIDs will be displayed
local font = "DermaLarge" -- The font to use for the names and SteamIDs
local textcolor = Color(255, 255, 255, 255) -- The color of the text
local boxcolor = Color(0, 0, 0, 200) -- The color of the box
local boxpadding = 10 -- The amount of padding to add to the box

hook.Add("HUDPaint", "ShowPlayerNamesAndSteamIDs", function()
    local ply = LocalPlayer()
    local pos = ply:GetPos()

    for _, v in ipairs(player.GetAll()) do
        if v ~= ply then
            local dist = pos:Distance(v:GetPos())
            if dist <= radius then
                local screenpos = v:GetPos():ToScreen()
                local name = v:Nick()
                local namewidth, nameheight = surface.GetTextSize(name)
                local steamid = v:SteamID64()
                local steamidwidth, steamidheight = surface.GetTextSize(steamid)
                
                local boxwidth = namewidth + steamidwidth + boxpadding*4
                local boxheight = math.max(nameheight, steamidheight) + boxpadding*2

                draw.RoundedBox(8, screenpos.x - boxwidth/2, screenpos.y - boxheight/2, boxwidth, boxheight, boxcolor)
                draw.DrawText(name, font, screenpos.x - boxwidth/2 + boxpadding*2, screenpos.y - nameheight/2, textcolor, TEXT_ALIGN_LEFT)
                draw.DrawText(steamid, font, screenpos.x - boxwidth/2 + boxpadding*2 + namewidth, screenpos.y - steamidheight/2, textcolor, TEXT_ALIGN_LEFT)

                local buttonx = screenpos.x + boxwidth/2 - boxpadding*2 - steamidwidth
                local buttony = screenpos.y - steamidheight/2
                local buttonwidth = steamidwidth + boxpadding*2
                local buttonheight = steamidheight + boxpadding*2

                draw.RoundedBox(8, buttonx, buttony, buttonwidth, buttonheight, boxcolor)
                draw.DrawText("Copy", font, buttonx + buttonwidth/2, buttony + buttonheight/2 - steamidheight/2, textcolor, TEXT_ALIGN_CENTER)
                
                if input.IsMouseDown(MOUSE_LEFT) and gui.MouseX() >= buttonx and gui.MouseX() <= buttonx + buttonwidth and gui.MouseY() >= buttony and gui.MouseY() <= buttony + buttonheight then
                    SetClipboardText(steamid)
                end
            end
        end
    end
end)
