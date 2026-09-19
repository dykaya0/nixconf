-- Look and feel
hl.config({
    general = {
        layout = "scrolling",
        border_size = 3,
        gaps_in = 2,
        gaps_out = 3,

        col = {
            active_border   = "rgba(c4b28aaa)",
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

        kb_layout = "us, tr",
        kb_options = "caps:escape",

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

hl.curve( "overshoot", { type = "bezier", points = { {0.5, 0.9}, {0.1, 1.1} } } )
hl.curve("overshoot-subtle", { type = "bezier", points = { {0.45, 0.9}, {0.15, 1.04}, }, })
hl.curve("smooth", { type = "bezier", points = { {0.25, 0.1}, {0.25, 1.0}, }, })
hl.curve("snap", { type = "bezier", points = { {0.7, 0.0}, {0.2, 1.0}, }, })

hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "smooth", style = "fade" })
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "overshoot-subtle", style = "slide"})
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "smooth"})
hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "smooth", style = "fade"})


hl.config({
    misc = {
        disable_autoreload = true,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = -1,
    }

})
