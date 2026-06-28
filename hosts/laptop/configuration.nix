{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix

        ../../modules/system.nix
        ../../modules/nvidia.nix
        ../../modules/sound.nix
        ../../modules/hyprland.nix
        ../../modules/shell.nix
        ../../modules/packages.nix
    ];

    networking.hostName = "nixos-laptop";

    # Bootloader
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";

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

    # Laptop specific packages
    environment.systemPackages = with pkgs; [
        brightnessctl
    ];
}
