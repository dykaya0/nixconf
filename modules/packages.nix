{ pkgs, ... }:
let
    shell_scripts = import ./submodules/shell_scripts.nix {inherit pkgs;};
in
{
    programs.git.enable = true;
    programs.bash.enable = true;
    services.emacs = {
        enable = true;
        package = pkgs.emacs-pgtk;
    };
    services.mullvad-vpn.enable = true;

    environment.systemPackages = with pkgs; [
        awww
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
        shell_scripts.screenshot_menu
        shell_scripts.tms
        shell_scripts.switch_audio
        shell_scripts.waybar_refresh
        tealdeer
        ungoogled-chromium
        unzip
        vim
        wget
        wl-clipboard
        wlogout
        zip
    ];
    fonts.packages = with pkgs; [
        noto-fonts
        nerd-fonts.jetbrains-mono
        nerd-fonts.iosevka
        nerd-fonts.caskaydia-mono
    ];
}
