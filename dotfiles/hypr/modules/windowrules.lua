hl.window_rule({
    name = "OnFullscreen",
    match = {
        fullscreen = true
    },
    border_size = 5,
    rounding = 1
})

hl.window_rule({
    name = "TransparentSpecialWorkspace",
    match = {
        workspace = "special:terminalScratchpad"
    },
    opacity = "0.6 override 0.5 override 0.4 override"
})

hl.window_rule({
    name = "Named workspaces has max one tiled window",
    match = { workspace = "n[true]w[t1]" },
    float = true,
    center = true,
    size = { "monitor_w * 0.6", "monitor_h * 0.8" }
})

local float_classes = table.concat({
    "org\\.pulseaudio\\.pavucontrol",
    "org\\.gnome\\.Calculator",
    "org\\.kde\\.kclock",
    "blueman-manager",
    "kitty",
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
