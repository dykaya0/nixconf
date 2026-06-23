{ pkgs, ... }:
let
    shell_scripts = import ./shell_scripts.nix { inherit pkgs; };
in
{
    system.stateVersion = "26.05";
    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];

    # Time and Networking
    time.timeZone = "Europe/Istanbul";
    nixpkgs.config.allowUnfree = true;
    i18n.defaultLocale = "en_GB.UTF-8";
    networking.networkmanager.enable = true;
    programs.nm-applet.enable = true;

    # Programs
    programs.git.enable = true;
    programs.bash.enable = true;

    # Global shell options
    environment.variables = {
        EDITOR="nvim";
        TERMINAL="ghostty";
        BROWSER="firefox";
        MANPAGER="nvim +Man!";
    };
    environment.loginShellInit = ''
        SS_DIR="$HOME/pictures/screenshots/$(date +%Y-%m)"
        WP_DIR="$HOME/pictures/wallpapers"
        mkdir -p "$SS_DIR"
        mkdir -p "$WP_DIR"
        export HYPRSHOT_DIR="$SS_DIR"
        export WALLPAPER_DIR="$WP_DIR"
        '';
    programs.zsh = {
        enable = true;
        shellAliases = {
            n="nvim";
        };
        loginShellInit = ''
        eval "$(starship init zsh)"
        '';

        syntaxHighlighting.highlighters = [
            "main"
            "brackets"
        ];
        enableCompletion = true;

        setOptions = [
            "CORRECT"
            "MENU_COMPLETE"
            "AUTO_PARAM_SLASH"
        ];
    };
    programs.starship = {
        enable = true;
        settings = {
            add_newline = true;
            command_timeout = 1300;
            scan_timeout = 50;
            format = "$all$nix_shell$nodejs$lua$golang$rust$php$git_branch$git_commit$git_state$git_status\n$username$hostname$directory";
            character = {
                success_symbol = "[](bold green) ";
                error_symbol = "[✗](bold red) ";
            };
        };
    };
    # Common packages and fonts
    environment.systemPackages = with pkgs; [
        awww
        bitwarden-desktop
        btop
        cliphist
        curl
        dunst
        fastfetch
        ghostty
        hyprshot
        kdePackages.okular
        kitty
        mpv
        nsxiv
        obs-studio
        pavucontrol
        rsync
        shell_scripts.clipboard_history
        shell_scripts.tms
        shell_scripts.waybar_refresh
        tealdeer
        ungoogled-chromium
        unzip
        vim
        wget
        wlogout
        zip
        wl-clipboard
    ];
    fonts.packages = with pkgs; [
        noto-fonts
        nerd-fonts.jetbrains-mono
        nerd-fonts.iosevka
        nerd-fonts.caskaydia-mono
    ];
    qt = {
        enable = true;
        platformTheme = "kde";
    };
}
