hl.window_rule({
    name = "TransparentSpecialWorkspace",
    match = {
        workspace = "special:terminalScratchpad"
    },
    opacity = "0.6 override 0.5 override 0.4 override"
})

local whole_column_classes = table.concat({
    "firefox",
}, "|")
hl.window_rule({
    name = "WholeColumnApps",
    match = {
        class = whole_column_classes
    },
    scrolling_width = 1
})


local float_classes = table.concat({
    "org\\.pulseaudio\\.pavucontrol",
    "org\\.gnome\\.Calculator",
    "org\\.kde\\.kclock",
    "blueman-manager",
}, "|")
hl.window_rule({
    name = "FloatingApps",
    match = {
        class = float_classes
    },
    float = true,
    center = true,
    size = { "monitor_w * 0.5", "monitor_h * 0.6" }
})

local bigger_float_classes = table.concat({
    "anki",
    "thunar",
    "Thunar",
    "Nsxiv",
    "nm-connection-editor",
    "hyprland-share-picker",
}, "|")
hl.window_rule({
    name = "BiggerFloatingApps",
    match = {
        class = bigger_float_classes
    },
    float = true,
    center = true,
    size = { "monitor_w * 0.6", "monitor_h * 0.8" }
})
