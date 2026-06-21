{ pkgs, ... }:

{
    # User
    users.users.dogukan = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [
            "wheel"
            "networkmanager"
        ];
    };

    # Bootloader and Display Manager
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
    security.pam.services.login.fprintAuth = false;
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
    };

    # Sound
    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };
    # Desktop specific packages
    environment.systemPackages = with pkgs; [
        steam
    ];

    # Window Manager and Wayland 
    programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
    };

    xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    };

}
