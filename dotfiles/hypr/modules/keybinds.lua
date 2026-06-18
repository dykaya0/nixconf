-- Essentials
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + M", hl.dsp.layout("swapwithmaster master"))

-- exec_cmd keybindings
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("ALT + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(emacs))
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd("audio_switcher"))
hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + F8", hl.dsp.exec_cmd("passrofi"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("waybar_refresh"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("screenshot_menu"))
hl.bind("ALT + C", hl.dsp.exec_cmd("clipboard_history"))
hl.bind("ALT + SPACE", hl.dsp.exec_cmd(appLauncher))
hl.bind("PRINT", hl.dsp.exec_cmd("screenshot_menu" .. " Monitor"))

-- Focus window
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Move window
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Default workspace keybindings
for i = 1, 9 do
    local key = i
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Repeating keybindings makes sure on_created_empty is triggered(even if named workspace is empty)
-- There is a difference with this and special workspaces but too lazy to explain
local function focus_workspace_persistent_window(key_combo, workspace_name)
    hl.bind(key_combo,
        hl.dsp.focus({ workspace = 1 }))
    hl.bind(key_combo,
        hl.dsp.focus({ workspace = "name:" .. tostring(workspace_name) }))
end

-- Switch workspaces
focus_workspace_persistent_window(mainMod .. " + B", "browser")
focus_workspace_persistent_window(mainMod .. " + T", "terminal")
focus_workspace_persistent_window(mainMod .. " + E", "emacs")
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("terminalScratchpad"))

-- Move workspace to directions
hl.bind(mainMod .. " + CTRL + H", hl.dsp.workspace.move({ monitor = "l" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.workspace.move({ monitor = "r" }))

-- Move active window to a workspace
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:terminalScratchpad" }))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.window.move({ workspace = "name:browser" }))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.window.move({ workspace = "name:terminal" }))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.window.move({ workspace = "name:emacs" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Zoom
local MAX_ZOOM = 3
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 1.5

---@param offset number
---@return nil
local function zoom(offset)
    local current = hl.get_config("cursor.zoom_factor")
    if offset ~= nil then
        current = current + offset
    elseif current ~= MIN_ZOOM then
        current = MIN_ZOOM
    else
        current = ZOOM_TOGGLE_FACTOR
    end
    current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
    hl.config({ cursor = { zoom_factor = current } })
end

hl.bind("SUPER + Z", zoom)
hl.bind("SUPER + KP_ADD", function()
    zoom(0.5)
end)
hl.bind("SUPER + KP_SUBTRACT", function()
    zoom(-0.5)
end)
