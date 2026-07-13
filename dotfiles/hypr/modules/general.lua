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
        layout = "scrolling",
        border_size = 2,
        gaps_in = 2,
        gaps_out = 3,

        col = {
            active_border   = "rgba(723ec3ff)",
            inactive_border = "rgba(595959aa)",
        }
    },

    scrolling = {
        fullscreen_on_one_column = true,
        focus_fit_method = 1,
        wrap_swapcol = false,
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

--- Cursor settings
hl.env("XCURSOR_SIZE", "18")
hl.env("HYPRCURSOR_SIZE", "18")
--- Toolkit backend variables
hl.env("GDK_BACKEND", "wayland,x11,*")   -- GTK: Use Wayland if available; if not, try X11 and then any other GDK backend.
hl.env("QT_QPA_PLATFORM", "wayland;xcb") -- Qt: Use Wayland if available, fall back to X11 if not.
hl.env("SDL_VIDEODRIVER", "wayland")     -- Run SDL2 applications on Wayland. Remove or set to x11 if games that provide older versions of SDL cause compatibility issues
hl.env("CLUTTER_BACKEND", "wayland")     -- Clutter package already has Wayland enabled, this variable will force Clutter applications to try and use the Wayland backend
--- XDG specifications (uwsm sets up automatically)
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
--- GTK theming
-- hl.env("GTK_THEME", "__NONE__")                    -- TODO
--- QT theming
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")         -- Enables automatic scaling, based on the monitor’s pixel density
hl.env("QT_QPA_PLATFORM", "wayland;xcb")           -- Tell Qt applications to use the Wayland backend, and fall back to X11 if Wayland is unavailable
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1") -- Disables window decorations on Qt applications
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")            -- Tells Qt based applications to pick your theme from qt5ct, use with Kvantum.
--- Wayland native if possible
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
--- NVIDIA specific
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
    misc = {
        disable_autoreload = true,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = -1,
    }

})
