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
    # TLP for battery management
    services.tlp.enable = true;

    # Bootloader and Display Manager
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

    security.pam.services.login.fprintAuth = false;
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
    };

    # Laptop specific packages
    environment.systemPackages = with pkgs; [
        brightnessctl
    ];

    # Sound and Bluetooth
    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = false;
    hardware.blueman.enable = true;

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
