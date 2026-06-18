hl.on("config.reloaded", function(m)
    hl.notification.create({
        text = "Config reloaded",
        timeout = 3000,
        icon = "info"
    })
end)
-- Look and feel
hl.config({
    general = {
        layout = "master",
        border_size = 2,
        gaps_in = 2,
        gaps_out = 3,

        col = {
            active_border   = "rgba(723ec3ff)",
            inactive_border = "rgba(595959aa)",
        }
    },

    decoration = {
        active_opacity = 1.00,
        inactive_opacity = 1.00,
        dim_special = 0.6,
        rounding = 1,
        rounding_power = 1.5,

        shadow = {
            enabled = false,
        },
        blur = {
            enabled = false,
        }
    },

    animations = {
        enabled = true,
    }
})

-- Input
hl.config({
    input = {
        numlock_by_default = true,
        follow_mouse = 1,

        kb_layout = "gb, tr",
        kb_options = "caps:swapescape",

        sensitivity = -0.5,
        scroll_button_lock = true,

        touchpad = {
            natural_scroll = true,
            scroll_factor = 1.2,
        }

    }
})

-- Environment Variables

hl.env("XCURSOR_SIZE", "18")
hl.env("HYPRCURSOR_SIZE", "18")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-- Animation
--- Curves
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "quick" })
hl.animation({ leaf = "windows", enabled = true, speed = 5, spring = "easy" })
hl.animation({ leaf = "border", enabled = true, speed = 15, spring = "easy" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "quick" })
hl.animation({ leaf = "workspaces", enabled = false, speed = 2, bezier = "quick", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 10, bezier = "quick" })

hl.config({
    master = {
        new_on_top = true
    },
})

hl.config({
    misc = {
        disable_autoreload = true,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = -1,
    }

})
