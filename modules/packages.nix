{ pkgs, ... }:
let
    shell_scripts = import ./submodules/shell_scripts.nix {inherit pkgs;};
in
{
    programs.git.enable = true;
    programs.bash.enable = true;
    programs.ssh.startAgent = true;
    programs.thunar.enable = true;
    services.mullvad-vpn = {
        enable = true;
        package = pkgs.mullvad-vpn;
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
            ghostty
            gimp
            hyprshot
            kdePackages.okular
            kdePackages.kclock
            mpv
            nsxiv
            obs-studio
            pavucontrol
            rsync
            shell_scripts.clipboard_history
            shell_scripts.screenshot_menu
            shell_scripts.switch_audio
            shell_scripts.tms
            shell_scripts.waybar_refresh
            shell_scripts.xkblayout
            tealdeer
            (tomato-c.overrideAttrs (old: {
              patches = (old.patches or []) ++ [
                ./patches/tomato-config.patch
              ];
            }))
            ungoogled-chromium
            unzip
            vim
            wget
            wl-clipboard
            wlogout
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
        nerd-fonts.jetbrains-mono
        nerd-fonts.iosevka
        nerd-fonts.caskaydia-mono
    ];
}
