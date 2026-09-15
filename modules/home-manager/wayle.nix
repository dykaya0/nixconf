{ pkgs, inputs, system, hostname, ... }:

{
    services.wayle = {
        enable = true;
        autoInstallDependencies = true;
        settings = {
            bar = {
                scale = if hostname == "desktop" then 0.75 else 0.5;
                button-label-size = 1.1;
                button-rounding = "md";
                button-variant = "basic";
                layout = [
                {
                    center = [
                        "hyprland-workspaces"
                            "notifications"
                    ];
                    left = [
                        "dashboard"
                            "clock"
                            "weather"
                    ];
                    monitor = "*";
                    right = [
                        "systray"
                            "keyboard-input"
                            "idle-inhibit"
                            "bluetooth"
                            "battery"
                            "brightness"
                            "network"
                            "volume"
                            "power"
                    ];
                    show = true;
                }
                ];
            };
            modules = {
                notifications = {
                    popup-monitor = if hostname == "desktop" then "DP-2" else "primary";
                };
                dashboard = {
                    dropdown-logout-command = "loginctl kill-session $XDG_SESSION_ID";
                };
                clock = {
                    dropdown-show-seconds = true;
                    format = "%H:%M";
                };
                hyprland-workspaces = {
                    app-icons-dedupe = false;
                    app-icons-show = true;
                    divider = " | ";
                };
                idle-inhibit = {
                    startup-duration = 0;
                };
                keyboard-input = {
                    layout-alias-map = {
                        "English (US)" = "EN";
                        "Turkish" = "TR";
                    };
                };
                power = {
                    left-click = "wlogout";
                };
                volume = {
                    middle-click = "pavucontrol";
                    right-click = "wayle audio output-mute";
                    scroll-down = "wayle audio output-volume -5";
                    scroll-up = "wayle audio output-volume +5";
                };
                weather = {
                    location = "Izmir";
                    time-format = "24h";
                    units = "metric";
                };
            };
            osd = {
                monitor = if hostname == "desktop" then "DP-2" else "primary";
            };
            styling = {
                palette = {
                    bg = "#0d0c0c";
                    blue = "#8ba4b0";
                    elevated = "#282727";
                    fg = "#c5c9c5";
                    fg-muted = "#a6a69c";
                    green = "#87a987";
                    primary = "#8992a7";
                    red = "#c4746e";
                    surface = "#181616";
                    yellow = "#c4b28a";
                };
                theme-provider = "wayle";
            };
            wallpaper = {
                engine-enabled = false;
            };
        };
    };
}
