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
        promptInit = ''
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
        enableBashIntegration = true;  # or zsh/fish
            settings = {
                format = ''
                    $username$hostname$directory$git_branch$git_state$git_status$cmd_duration$line_break$python$character
                    '';
                character = {
                    success_symbol = "[❯](purple)";
                    error_symbol = "[❯](red)";
                    vimcmd_symbol = "[❮](green)";
                };
                directory.style = "blue";
                git_branch = {
                    format = "[$branch]($style)";
                    style = "bright-black";
                };
                git_status = {
                    format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
                    style = "cyan";
                    conflicted = "​";
                    untracked = "​";
                    modified = "​";
                    staged = "​";
                    renamed = "​";
                    deleted = "​";
                    stashed = "≡";
                };
                git_state = {
                    format = ''\([$state( $progress_current/$progress_total)]($style)\) '';
                    style = "bright-black";
                };
                cmd_duration = {
                    format = "[$duration]($style) ";
                    style = "yellow";
                };
                python = {
                    format = "[$virtualenv]($style) ";
                    style = "bright-black";
                };
            };
    };
}
