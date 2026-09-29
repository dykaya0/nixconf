{ pkgs, ... }:
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

    programs.wireshark = {
        enable = true;
        dumpcap.enable = true;
        usbmon.enable = true;
        package = pkgs.wireshark;
    };

    programs.thunar.enable = true;
    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images

    services.mullvad-vpn = {
        enable = true;
        package = pkgs.mullvad-vpn;
        enableEarlyBootBlocking = false;
    };


    environment.systemPackages = with pkgs; [
            awww
            anki-bin
            (pkgs.anki.withAddons [
             (pkgs.ankiAddons.passfail2.withConfig {
              config = {
              again_button_name = "Incorrect";
              good_button_name = "Correct";
              };
              })
             (pkgs.ankiAddons.anki-connect)
             (pkgs.ankiAddons.review-heatmap)
            ])
            btop
            brave
            cliphist
            curl
            devenv
            dunst
            eza
            fastfetch
            fzf
            gimp
            hyprshot
            hyprlock
            kdePackages.okular
            kdePackages.kclock
            libnotify
            monero-gui
            mpv
            nsxiv
            nmap
            obs-studio
            pavucontrol
            playerctl
            pure-prompt
            rsync
            shell_scripts.clipboard_history
            shell_scripts.screenshot_menu
            shell_scripts.switch_audio
            shell_scripts.tms
            shell_scripts.waybar_refresh
            shell_scripts.xkblayout
            shell_scripts.hyprland_scroll
            shell_scripts.battery_capacity
            texliveFull
            tealdeer
            (tomato-c.overrideAttrs (old: {
              patches = (old.patches or []) ++ [
                ./patches/tomato-config.patch
              ];
            }))
            tuigreet
            ungoogled-chromium
            unzip
            vim
            wget
            wl-clipboard
            zip
            (emacsWithPackagesFromUsePackage {
             package = pkgs.emacs;
             config = ../dotfiles/emacs/config.el;
             alwaysEnsure = true;
             defaultInitFile = true;
             alwaysTangle = false;

# Optionally provide extra packages not in the configuration file.
             extraEmacsPackages = epkgs: [
             epkgs.use-package
             ];
             })
    ];
    fonts.packages = with pkgs; [
        noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-color-emoji
            nerd-fonts.jetbrains-mono
            nerd-fonts.iosevka
            nerd-fonts.caskaydia-mono
            nerd-fonts.fira-code
            terminus_font_ttf
    ];
}
