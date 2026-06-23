{ ... }:
{

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
        programs.zsh.promptInit = ''
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
}
