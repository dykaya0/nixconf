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
            cd="z";
            ls="eza -1";
            lsa="eza -a1";
            lsla="eza -la1";
            ncd="f() { cd $1 && nvim .; }; f";
        };
        shellInit = ''
            fpath+=($HOME/.zsh/pure)
            autoload -U promptinit; promptinit
            prompt pure
        '';
        interactiveShellInit = ''
            fpath+=($HOME/.zsh/pure)
            autoload -U promptinit; promptinit
            prompt pure
            eval "$(devenv hook zsh)"
            source <(fzf --zsh)
            export FZF_DEFAULT_OPTS="--style minimal --color 16 --layout=reverse --height 30% --preview='bat -p --color=always {}'"
            export FZF_CTRL_R_OPTS="--style minimal --color 16 --info inline --no-sort --no-preview"
        '';
        promptInit = ''
        '';

        syntaxHighlighting = {
            enable = true;
            highlighters = [
                "main"
                "brackets"
            ];
        };
        enableCompletion = true;

        setOptions = [
            "CORRECT"
            "MENU_COMPLETE"
            "AUTO_PARAM_SLASH"
        ];
    };
    programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
    };
}
