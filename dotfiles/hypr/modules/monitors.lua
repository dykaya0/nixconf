local terminal_cmd = terminal
local browser_cmd = browser
local emacs_cmd = emacs
hl.on("monitor.added", function(m)
    local monitor_desc = m.description
    if string.match(monitor_desc, "LG Electronics LG FULL HD 0x01010101") then
        hl.monitor({ output = "desc:LG Electronics LG FULL HD", mode = "preferred", position = "auto", scale = 1 })
        hl.notification.create({
            text = "Left monitor configured.",
            timeout = 5000,
            icon = "hint"
        })
    elseif string.match(monitor_desc, "Samsung Electric Company LS27AG32x H9JW501547") then
        hl.monitor({ output = "desc:Samsung Electric Company LS27AG32x", mode = "preferred", position = "auto", scale = 1 })
        hl.monitor({
            output = "",
            mode = "preferred",
            position = "auto",
            scale = 1,
            mirror =
            "desc:Samsung Electric Company LS27AG32x"
        })

        for i = 1, 5 do
            hl.workspace_rule({ workspace = i, monitor = "desc:Samsung Electric Company LS27AG32x" })
        end

        hl.workspace_rule({
            workspace = "special:terminalScratchpad",
            monitor = "desc:Samsung Electric Company LS27AG32x",
            on_created_empty =
                terminal_cmd
        })
        hl.workspace_rule({
            workspace = "name:browser",
            monitor = "desc:Samsung Electric Company LS27AG32x",
            on_created_empty =
                browser_cmd
        })
        hl.workspace_rule({
            workspace = "name:terminal",
            monitor = "desc:Samsung Electric Company LS27AG32x",
            on_created_empty =
                terminal_cmd
        })
        hl.workspace_rule({
            workspace = "name:emacs",
            monitor = "desc:Samsung Electric Company LS27AG32x",
            on_created_empty =
                emacs_cmd
        })

        hl.notification.create({
            text = "Primary monitor configured.",
            timeout = 5000,
            icon = "hint"
        })
    else
        hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

        hl.workspace_rule({ workspace = "special:terminalScratchpad", on_created_empty = terminal_cmd })
        hl.workspace_rule({ workspace = "name:browser", on_created_empty = browser_cmd })
        hl.workspace_rule({ workspace = "name:terminal", on_created_empty = terminal_cmd })
        hl.workspace_rule({ workspace = "name:emacs", on_created_empty = emacs_cmd })

        hl.notification.create({
            text = "No monitor configuration detected. Applying fallback",
            timeout = 5000,
            icon = "warning"
        })
    end
end)
