{ pkgs, config, ... }:

{
    imports = [
        ./hardware-configuration.nix

            ../../modules/system.nix
            ../../modules/hyprland.nix
            ../../modules/nvidia.nix
            ../../modules/sound.nix
            ../../modules/shell.nix
            ../../modules/packages.nix
    ];

    networking.hostName = "nixos";

    services.displayManager.sddm.settings = {
        Autologin = {
            Session = "hyprland.desktop";
            User = config.users.users.dogukan.name;
        };
    };
# Bootloader
    boot.loader = {
        efi.canTouchEfiVariables = true;
        grub = {
            enable = true;
            efiSupport = true;
            device = "nodev";
            useOSProber = true;
        };
    };

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
    services.hardware.openrgb = {
        enable = true;
        startupProfile = "Default.orp";
    };
}
