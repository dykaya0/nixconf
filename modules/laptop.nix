{ pkgs, ... }:

{
    users.users.dogukan = {
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [
            "wheel"
            "networkmanager"
        ];
    };
    services.tlp.enable = true;
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
    security.pam.services.login.fprintAuth = false;
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
    };
    environment.systemPackages = with pkgs; [
        firefox
        btop
        cliphist
        dunst
        fastfetch
        ghostty
        kitty
        librewolf
        nsxiv
        pavucontrol
        rsync
    ];

    programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
    };

    xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    };

    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };

    programs.fish = {
        enable = true;
        shellAliases = {
            n="nvim";
        };
    };

    fonts.packages = with pkgs; [
        noto-fonts
            nerd-fonts.jetbrains-mono
            nerd-fonts.iosevka
            nerd-fonts.caskaydia-mono
    ];
}
