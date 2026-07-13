hl.on("monitor.added", function(m)
    local monitor_desc = m.description
    if string.match(monitor_desc, "LG Electronics LG FULL HD 0x01010101") then
        hl.monitor({ output = "desc:LG Electronics LG FULL HD", mode = "1920x1080@60", position = "0x0", scale = 1 })
        hl.notification.create({
            text = "Left monitor configured.",
            timeout = 5000,
            icon = "hint"
        })
    elseif string.match(monitor_desc, "Samsung Electric Company LS27AG32x H9JW501547") then
        hl.monitor({ output = "desc:Samsung Electric Company LS27AG32x", mode = "1920x1080@165", position = "1920x0", scale = 1 })
        hl.monitor({
            output = "",
            mode = "preferred",
            position = "auto",
            scale = 1,
            mirror =
            "desc:Samsung Electric Company LS27AG32x"
        })

        for i = 1, 9 do
            if i ~= 9 then 
                hl.workspace_rule({ workspace = i, monitor = "desc:Samsung Electric Company LS27AG32x" })
            else
                hl.workspace_rule({ workspace = i, monitor = "desc:LG Electronics LG FULL HD" })
            end
        end

        hl.notification.create({
            text = "Primary monitor configured.",
            timeout = 5000,
            icon = "hint"
        })
    else
        hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

        hl.notification.create({
            text = "No monitor configuration detected. Applying fallback",
            timeout = 5000,
            icon = "warning"
        })
    end
end)
