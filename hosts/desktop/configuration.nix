{ ... }:

{
    imports = [
        ./hardware-configuration.nix

        ../../modules/common.nix
        ../../modules/desktop.nix
        ../../modules/nvidia.nix
        ../../modules/firefox.nix
    ];

    networking.hostName = "nixos";
}
