{ pkgs, ... }:

{
    system.stateVersion = "26.05";
    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];

    time.timeZone = "Europe/Istanbul";
    i18n.defaultLocale = "en_GB.UTF-8";
    networking.networkmanager.enable = true;
    programs.nm-applet.enable = true;

    programs.git.enable = true;
    programs.bash.enable = true;

    environment.variables = {
        EDITOR="nvim";
        TERMINAL="ghostty";
        BROWSER="firefox";
        MANPAGER="nvim +Man!";
    };
    environment.loginShellInit = ''
        SS_DIR="$HOME/pictures/screenshots/$(date +%Y-%m)"
        mkdir -p "$SS_DIR"
        export HYPRSHOT_DIR="$SS_DIR"
        export WALLPAPER_DIR="$HOME/pictures/wallpapers"
        '';
    programs.zsh = {
        enable = true;
        shellAliases = {
            n="nvim";
        };

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
    environment.systemPackages = with pkgs; [
        btop
        cliphist
        curl
        dunst
        mpv
        kdePackages.okular
        obs-studio
        fastfetch
        hyprshot
        ghostty
        kitty
        nsxiv
        pavucontrol
        rsync
        vim
        tealdeer
        wget
        wlogout
        ungoogled-chromium
        unzip
        zip
    ];

    fonts.packages = with pkgs; [
        noto-fonts
        nerd-fonts.jetbrains-mono
        nerd-fonts.iosevka
        nerd-fonts.caskaydia-mono
    ];
}
