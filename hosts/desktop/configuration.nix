{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix

        ../../modules/system.nix
        ../../modules/hyprland.nix
        ../../modules/nvidia.nix
        ../../modules/sound.nix
        ../../modules/shell.nix
        ../../modules/packages.nix
        ../../modules/firefox.nix
    ];

    networking.hostName = "nixos";

    # Bootloader
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    # User
    users.users.dogukan = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [
            "wheel"
            "networkmanager"
        ];
    };

    # Desktop specific packages
    environment.systemPackages = with pkgs; [
        steam
    ];
}
