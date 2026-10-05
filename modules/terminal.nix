{ lib, pkgs, ... }:
let
    shell_scripts = import ./submodules/shell_scripts.nix {inherit pkgs;};
in
{


    programs.git.enable = true;
    programs.bash.enable = true;
    programs.ssh.startAgent = true;
    programs.foot = {
        enable = true;
        theme = "poimandres";
        settings = {
            main = {
                font = "CaskaydiaMono Nerd Font:size=15";
                dpi-aware = "yes";
                term = "xterm-256color";
            };
            scrollback = {
                lines = 10000;
                multiplier = 3;
            };
            cursor = {
                style = "block";
                blink = "yes";
                blink-rate = 500;
            };
        };
    };
    environment.systemPackages = with pkgs; [
            btop
            cliphist
            curl
            devenv
            eza
            fastfetch
            fd
            fzf
            libnotify
            netcat-gnu
            nmap
            pure-prompt
            rsync
            shell_scripts.tms
            tealdeer
            texliveFull
            unzip
            vim
            wget
            wl-clipboard
            zip
            zoxide
    ];

    environment.variables = {
        EDITOR="nvim";
        TERMINAL="footclient";
        BROWSER="firefox";
        MANPAGER="nvim +Man!";
    };
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
            n="nvim";
            ls="eza -1";
            lsa="eza -a1";
            lsla="eza -la1";
        };
        shellInit = ''
            source <(fzf --zsh)
            export FZF_DEFAULT_OPTS="--style minimal --color 16 --layout=reverse --height 30% --preview='bat -p --color=always {}'"
            export FZF_CTRL_R_OPTS="--style minimal --color 16 --info inline --no-sort --no-preview"
            _fzf_compgen_path() {
              fd --follow --exclude ".git" . "$1"
            }
            _fzf_compgen_dir() {
              fd --type d --hidden --follow --exclude ".git" . "$1"
            }
        '';
        interactiveShellInit = lib.mkAfter ''
            eval "$(devenv hook zsh)"
            eval "$(zoxide init zsh --cmd cd)"
        '';
        promptInit = ''
            fpath+=($HOME/.zsh/pure)
            autoload -U promptinit; promptinit
            prompt pure
        '';

        syntaxHighlighting = {
            enable = true;
            highlighters = [
                "main"
                "brackets"
            ];
        };

        setOptions = [
            "CORRECT"
            "MENU_COMPLETE"
            "AUTO_PARAM_SLASH"
        ];
    };
}
